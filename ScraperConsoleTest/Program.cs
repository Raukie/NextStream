using Microsoft.Extensions.Logging;

internal class Program
{
    private static void Main(string[] args)
    {
        using var loggerFactory = LoggerFactory.Create(builder =>
        {
            builder.SetMinimumLevel(LogLevel.Information);
        });

        var logger = loggerFactory.CreateLogger<MovieScraper.MovieScraper>();
        var scraper = new MovieScraper.MovieScraper(logger);

        await scraper.ScrapeMoviesAsync("science fiction", 5);
    }
}