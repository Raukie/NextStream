using Microsoft.Extensions.Logging;
using NextStream.MovieScraper.Models;
using Newtonsoft.Json.Linq;
using NextStream.DataAccessLayer;

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

            // 🖼️ Download thumbnail image
            var thumbFile = movieMetadata.Files.FirstOrDefault(f => f.Name == "__ia_thumb.jpg");
            try
            {
                string thumbnailUrl = $"https://archive.org/download/{movieMetadata.Identifier}/{thumbFile.Name}";
                string localFileName = $"{newMovie.Id}_thumb.jpg";
                string thumbnailDirectory = "C:\\NextStream\\Thumbnails";

                if (!Directory.Exists(thumbnailDirectory))
                {
                    Directory.CreateDirectory(thumbnailDirectory);
                }

                string fullFilePath = Path.Combine(thumbnailDirectory, localFileName);
                using var response = await _requestHelper.GetHttpResponseAsync(thumbnailUrl);
                response.EnsureSuccessStatusCode();

                using var fs = new FileStream(fullFilePath, FileMode.Create);
                await response.Content.CopyToAsync(fs);

                _logger.LogInformation($"Thumbnail downloaded and saved to {fullFilePath}");
            }
            catch (Exception ex)
            {
                _logger.LogError($"Failed to download or save thumbnail for '{movieMetadata.Identifier}': {ex.Message}");
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
