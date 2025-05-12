using Microsoft.Extensions.Logging;
using NextStream.MovieScraper.Models;
using Newtonsoft.Json.Linq;
using NextStream.DataAccessLayer;
using Xabe.FFmpeg;


namespace NextStream.MovieScraper
{
    public class MovieScraper
    {
        public const string filter = @"mediatype%3A%28movies%29+and+collection%3A%28moviesandfilms%29+AND+genre%3A%5B""""+TO+*%5D&fl%5B%5D=creator&fl%5B%5D=downloads&fl%5B%5D=genre&fl%5B%5D=identifier&fl%5B%5D=year&sort%5B%5D=downloads+desc&sort%5B%5D=&sort%5B%5D=&rows=100&page=@pageIndex&output=json";
        private RequestHelper _requestHelper;
        private readonly ILogger _logger;
        private readonly NextStreamContext _movieContext;
        private readonly List<Genre> _allGenres = new List<Genre>();

        public MovieScraper(RequestHelper requestHelper, ILogger<MovieScraper> logger, NextStreamContext movieContext) 
        {
            _requestHelper = requestHelper;
            _logger = logger;
            _movieContext = movieContext;
            _allGenres = _movieContext.Genres.ToList();
        }

        public async Task ScrapeMovies(int startPage, CancellationToken token)
        {
            int currentIndex = startPage;
            while (true)
            {
                string currentFilter = filter.Replace("@pageIndex", currentIndex.ToString());

                AdvancedSearchResult? searchResult = await _requestHelper.GetJsonAsync<AdvancedSearchResult>("advancedsearch.php?q=" + currentFilter);

                if (searchResult == null) 
                {
                    _logger.LogError($"Could not process the following filter into a search object '{searchResult}'");
                    continue;
                }

                await ProcessSearchResults(searchResult);

                currentIndex++;
            }
        }

        public async Task ProcessSearchResults(AdvancedSearchResult searchResult)
        {
            foreach(ArchiveMovie archiveMovie in searchResult.Response.Docs)
            {
                if (_movieContext.Movies
                    .Any(m => m.ApiId == archiveMovie.Identifier))
                {
                    _logger.LogInformation($"Movie '{archiveMovie.Identifier}' already exists. Skipping.");
                    continue;
                }

                try
                {
                    await ProcessOneSearchResult(archiveMovie);

                }
                catch (Exception e)
                {

                    _logger.LogError($"Unable to parse the movie {archiveMovie.Identifier} due to the exception: {e.Message}, stacktrace: {e.StackTrace}");
                }
            }
        }

        public async Task ProcessOneSearchResult(ArchiveMovie archiveMovie)
        {
            // Get the full metadata JSON for this movie
            string metadataUrl = $"https://brave-api.archive.org/metadata/{archiveMovie.Identifier}";
            JObject? metadata = await _requestHelper.GetJsonAsync<JObject>(metadataUrl);

            if (metadata == null)
            {
                _logger.LogWarning($"Metadata is null for identifier: {archiveMovie.Identifier}");
                return;
            }

            var files = metadata["files"]?.ToObject<List<MovieFile>>();
            var meta = metadata["metadata"];

            if (meta == null || files == null || files.Count == 0)
            {
                _logger.LogWarning($"Missing metadata or files for: {archiveMovie.Identifier}");
                return;
            }
            
            var movieMetaData = meta.ToObject<MovieMetadata>();

            if (movieMetaData == null)
            {
                return;
            }

            movieMetaData.Files = files;
            if (meta["creator"] != null)
            {
                if (meta["creator"].Type == JTokenType.String)
                {
                    movieMetaData.Creator = meta["creator"].ToObject<string>().Split(",").ToList();
                }
                else
                {
                    movieMetaData.Creator = meta["creator"].ToObject<List<string>>();
                }
            }


            if (meta["genre"] != null)
            {
                if (meta["genre"].Type == JTokenType.String)
                {
                    movieMetaData.Genre = meta["genre"].ToObject<string>().Split(",").ToList();
                }
                else
                {
                    movieMetaData.Genre = meta["genre"].ToObject<List<string>>();
                }
            }

            if (meta["date"] != null)
            {
                if (meta["date"].Type != JTokenType.Array)
                {
                    movieMetaData.Date = meta["date"].Value<string>();
                }
                else
                {
                    movieMetaData.Date = meta["date"].ToObject<List<string>>().FirstOrDefault();
                }
            }

            await ProcessMovieMetadata(movieMetaData);
        }

        public async Task ProcessMovieMetadata(MovieMetadata movieMetadata)
        {
            // Extract important fields safely
            string? title = movieMetadata.Title;
            string? description = movieMetadata.Description;
            string? year = movieMetadata.Date;

            List<string> creator = movieMetadata.Creator;
            List<string> genres = movieMetadata.Genre;

            if (string.IsNullOrWhiteSpace(title) ||
                string.IsNullOrWhiteSpace(description) ||
                genres == null || genres.Count == 0 ||
                string.IsNullOrWhiteSpace(year) ||
                creator == null || creator.Count == 0 ||
                !movieMetadata.Files.Exists(f => f.Name == "__ia_thumb.jpg") || 
                (
                !movieMetadata.Files.Exists(f => f.Name.EndsWith(".mp4", StringComparison.OrdinalIgnoreCase)) &&
                !movieMetadata.Files.Exists(f => f.Name.EndsWith(".mpeg", StringComparison.OrdinalIgnoreCase)))
                 ||
                movieMetadata.Files == null || movieMetadata.Files.Count == 0)
            {
                _logger.LogInformation("Skipping movie due to missing required fields.");
                return;
            }

            var dbGenres = new List<Genre>();
            var newGenres = new List<Genre>();


            foreach(var genre in movieMetadata.Genre)
            {
                var dbGenre = _allGenres.FirstOrDefault(dbGenre => dbGenre.Name == genre);
                if (dbGenre != null)
                {
                    dbGenres.Add(dbGenre);
                    continue;
                }

                var newGenre = new Genre()
                {
                    Name = genre
                };

                newGenres.Add(newGenre);
                dbGenres.Add(newGenre);
                _movieContext.Genres.Add(newGenre);
            }

            if (newGenres.Count > 0) 
            {
                await _movieContext.SaveChangesAsync();
            }

            _allGenres.AddRange(newGenres);

            var newMovie = new Movie
            {
                ApiId = movieMetadata.Identifier,
                Title = movieMetadata.Title,
                Description = movieMetadata.Description,
                Creator = string.Join(",", movieMetadata.Creator),
                Published = ParseYearToDate(movieMetadata.Date),
                DownloadedMovieFiles = false,
                ProcessedIntoStreamableFormat = false,
                Genres = dbGenres
            };

            _movieContext.Movies.Add(newMovie);
            await _movieContext.SaveChangesAsync();
            _logger.LogInformation($"Added movie '{newMovie.Title}' to database with ID {newMovie.Id}.");

            // Download thumbnail image
            var thumbFile = movieMetadata.Files.FirstOrDefault(f => f.Name == "__ia_thumb.jpg");
            var movieFile = movieMetadata.Files.FirstOrDefault(f => f.Name.EndsWith(".mp4", StringComparison.InvariantCultureIgnoreCase)
            || f.Name.EndsWith(".mpeg", StringComparison.InvariantCultureIgnoreCase));
            try
            {
                string thumbnailUrl = $"https://archive.org/download/{movieMetadata.Identifier}/{thumbFile!.Name}";
                string movieUrl = $"https://archive.org/download/{movieMetadata.Identifier}/{movieFile!.Name}";
                string localFileName = $"M_{newMovie.Id}";
                string thumbnailDirectory = "C:\\NextStream\\Thumbnails";
                string MovieDirectory = $"C:\\NextStream\\Movies\\M_{newMovie.Id}";

                if (!Directory.Exists(thumbnailDirectory))
                {
                    Directory.CreateDirectory(thumbnailDirectory);
                }

                if (!Directory.Exists(MovieDirectory))
                {
                    Directory.CreateDirectory(MovieDirectory);
                }

                if (!Directory.Exists(Path.Combine(MovieDirectory, "hls")))
                {
                    Directory.CreateDirectory(Path.Combine(MovieDirectory, "hls"));
                }

                string fullFilePath = Path.Combine(thumbnailDirectory, localFileName+".jpg");
                using var response = await _requestHelper.GetHttpResponseAsync(thumbnailUrl);
                response.EnsureSuccessStatusCode();

                string movieFilePath = Path.Combine(MovieDirectory, $"{localFileName}.mp4");
                string hlsDirectory = Path.Combine(MovieDirectory, "hls");

                using var movieResponse = await _requestHelper.GetHttpResponseAsync(movieUrl);
                movieResponse.EnsureSuccessStatusCode();

                using var movieStream = new FileStream(movieFilePath, FileMode.Create);
                await movieResponse.Content.CopyToAsync(movieStream);
                movieStream.Close();
                using var fs = new FileStream(fullFilePath, FileMode.Create);
                await response.Content.CopyToAsync(fs);

                _logger.LogInformation($"Movie downloaded to {movieFilePath}");

                // Convert to HLS
                bool converted = await ConvertToHlsAsync(movieFilePath, hlsDirectory);
                newMovie.ProcessedIntoStreamableFormat = converted;
                await _movieContext.SaveChangesAsync();


                _logger.LogInformation($"Thumbnail and movie downloaded and saved to {fullFilePath} and {movieFilePath}");
            }
            catch (Exception ex)
            {
                _logger.LogError($"Failed to download or save thumbnail or movie for '{movieMetadata.Identifier}': {ex.Message}");
            }
        }


private async Task<bool> ConvertToHlsAsync(string inputFilePath, string outputDirectory)
    {
        try
        {
            if (!Directory.Exists(outputDirectory))
            {
                Directory.CreateDirectory(outputDirectory);
            }

            string outputPath = Path.Combine(outputDirectory, "index.m3u8");

            var conversion = FFmpeg.Conversions.New()
                .AddParameter($"-i \"{inputFilePath}\"")
                .AddParameter("-codec: copy")
                .AddParameter("-start_number 0")
                .AddParameter("-hls_time 10")
                .AddParameter("-hls_list_size 0")
                .AddParameter($"-f hls \"{outputPath}\"", ParameterPosition.PostInput);
            var result = await conversion.Start();
            File.Delete(inputFilePath);

            _logger.LogInformation($"HLS conversion completed: {outputPath}");
            return true;
        }
        catch (Exception ex)
        {
            _logger.LogError($"Error during HLS conversion: {ex.Message}");
            return false;
        }
    }

    private DateTime? ParseYearToDate(string year)
        {
            if (int.TryParse(year, out var y) && y > 1800 && y <= DateTime.Now.Year)
            {
                return new DateTime(y, 1, 1);
            }
            return null;
        }
    }
}
