using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using NextStream.DataAccessLayer;
using NextStream.MovieScraper;
using System.Threading;
using System.Threading.Tasks;

internal class Program
{
    private static async Task Main(string[] args)
    {
        using IHost host = Host.CreateDefaultBuilder(args)
            .ConfigureLogging(logging =>
            {
                logging.AddFilter("Microsoft.EntityFrameworkCore.Database.Command", LogLevel.Warning);
                logging.ClearProviders();
                logging.AddConsole();
            })
            .ConfigureServices((context, services) =>
            {
                // Replace this with your actual connection string
                var connectionString = "Data Source=localhost\\SQLEXPRESS;Initial Catalog=NextStream;Integrated Security=True;Trust Server Certificate=True";

                // Add EF Core DB context
                services.AddDbContext<NextStreamContext>(options =>
                    options.UseSqlServer(connectionString));

                // Add app services
                services.AddSingleton<RequestHelper>();
                services.AddScoped<MovieScraper>();
            })
            .Build();

        // Create service scope
        using var scope = host.Services.CreateScope();
        var services = scope.ServiceProvider;

        try
        {
            var scraper = services.GetRequiredService<MovieScraper>();
            var tokenSource = new CancellationTokenSource();

            // Start scraping from page 1
            await scraper.ScrapeMovies(1, tokenSource.Token);
        }
        catch (Exception ex)
        {
            var logger = services.GetRequiredService<ILogger<Program>>();
            logger.LogError(ex, "An error occurred during scraping.");
        }
    }
}
