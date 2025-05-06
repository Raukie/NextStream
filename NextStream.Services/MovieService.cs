using Microsoft.EntityFrameworkCore;
using NextStream.DataAccessLayer;
using NextStream.Services.DataTransferObjects;

namespace NextStream.Services
{
    public class MovieService(NextStreamContext nextStreamContext)
    {
        private readonly NextStreamContext _nextStreamContext = nextStreamContext ?? throw new ArgumentNullException(nameof(nextStreamContext));

        public List<GenreDTO> GetMoviesWithGenres() 
        {
            var allGenres = _nextStreamContext.Genres.Include(genre=>genre.Movies);
            var resultGenres = new List<GenreDTO>();
            foreach (var genre in allGenres) 
            {
                resultGenres.Add(new GenreDTO
                {
                    Id = genre.Id,
                    Name = genre.Name,
                    Movies = genre.Movies.Take(30).Select(movie =>
                    {
                        return new MovieInOverviewDTO()
                        {
                            Id = movie.Id,
                            Title = movie.Title,
                            ThumbmailFileName = $"{movie.Id}_thumb.jpg"
                        };
                    }).ToList()
                });
            }
            return resultGenres.Where(genre=>genre.Movies.Count != 0).ToList();
        }

        public MovieSelectedDTO? GetSelectedMovie(int selectedMovieId)
        {
            return _nextStreamContext.Movies.Select(movie => new MovieSelectedDTO()
            {
                Description = movie.Description,
                Id = movie.Id,
                Title = movie.Title,
                Genres = movie.Genres.Select(genre=>genre.Name).ToList(),
                ThumbmailFileName = $"{movie.Id}_thumb.jpg"
            })
            .FirstOrDefault(movie => movie.Id == selectedMovieId);
        }

        public GenreDTO FetchNext(GenreDTO genreDTO)
        {
            var genre = _nextStreamContext.Genres.FirstOrDefault(genre => genre.Id == genreDTO.Id);

            if (genre == null) 
            {
                return genreDTO;
            }

            var newGenreDto = new GenreDTO
            {
                Id = genre.Id,
                Name = genre.Name,
                CurrentPage = genreDTO.CurrentPage++,
                Movies = genre.Movies.Skip(genreDTO.CurrentPage++ * 30).Take(30).Select(movie =>
                {
                    return new MovieInOverviewDTO()
                    {
                        Id = movie.Id,
                        Title = movie.Title,
                        ThumbmailFileName = $"{movie.Id}_thumb.jpg"
                    };
                }).ToList()
            };

            if (newGenreDto.Movies.Count == 0) 
            {
                genreDTO.CurrentPage = 0;
                genreDTO.Movies = genre.Movies.Skip(0).Take(30).Select(movie =>
                {
                    return new MovieInOverviewDTO()
                    {
                        Id = movie.Id,
                        Title = movie.Title,
                        ThumbmailFileName = $"{movie.Id}_thumb.jpg"
                    };
                }).ToList();
            }

            return newGenreDto;
        }

        public GenreDTO FetchPrevious(GenreDTO genreDTO)
        {
            if(genreDTO.CurrentPage == 0)
            {
                return genreDTO;
            }

            var genre = _nextStreamContext.Genres.FirstOrDefault(genre => genre.Id == genreDTO.Id);

            if (genre == null)
            {
                return genreDTO;
            }

            var newGenreDto = new GenreDTO
            {
                Id = genre.Id,
                Name = genre.Name,
                CurrentPage = genreDTO.CurrentPage--,
                Movies = genre.Movies.Skip(genreDTO.CurrentPage-- * 30).Take(30).Select(movie =>
                {
                    return new MovieInOverviewDTO()
                    {
                        Id = movie.Id,
                        Title = movie.Title,
                        ThumbmailFileName = $"{movie.Id}_thumb.jpg"
                    };
                }).ToList()
            };

            return newGenreDto;
        }
    }
}
