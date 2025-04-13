using System;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Logging.Abstractions;
using Newtonsoft.Json.Linq;
using Polly;
using Polly.RateLimit;
using Polly.Retry;
using Polly.Wrap;

namespace MovieScraper
{
    public class RequestHelper
    {
        private readonly HttpClient _httpClient;
        private readonly ILogger<RequestHelper> _logger;
        private readonly AsyncPolicyWrap<HttpResponseMessage> _policyWrap;

        public RequestHelper(ILogger<RequestHelper> logger)
        {
            if(logger == null)
            {
                _logger = new NullLogger<RequestHelper>();
            } else
            {
                _logger = logger;
            }


            _httpClient = new HttpClient
            {
                BaseAddress = new Uri("https://archive.org/")
            };

            // Rate limiting: max 5 requests per second
            var rateLimitPolicy = Policy.RateLimitAsync<HttpResponseMessage>(
                5,
                TimeSpan.FromSeconds(1)
            );

            // Retry on transient HTTP errors (like 500, 502, 503)
            var retryPolicy = Policy
                .Handle<HttpRequestException>()
                .OrResult<HttpResponseMessage>(r => !r.IsSuccessStatusCode)
                .WaitAndRetryAsync(
                    retryCount: 3,
                    sleepDurationProvider: attempt => TimeSpan.FromSeconds(Math.Pow(2, attempt)),
                    onRetry: async (outcome, timespan, attempt, context) =>
                    {
                        _logger.LogError($"[Failed] Request failed with status code '{outcome.Result.StatusCode}' and result '{await outcome.Result.Content.ReadAsStringAsync()}'");
                        _logger.LogWarning($"[Retry] Attempt '{attempt}': Waiting '{timespan.TotalSeconds}s'");
                    });

            _policyWrap = Policy.WrapAsync(retryPolicy, rateLimitPolicy);
        }

        /// <summary>
        /// Sends a GET request to the specified relative URL and returns the raw response content.
        /// </summary>
        public async Task<string> GetStringAsync(string relativeUrl)
        {
            var response = await _policyWrap.ExecuteAsync(() => _httpClient.GetAsync(relativeUrl));
            response.EnsureSuccessStatusCode();
            return await response.Content.ReadAsStringAsync();
        }

        /// <summary>
        /// Sends a GET request and parses the response content as a JObject (JSON).
        /// </summary>
        public async Task<JObject> GetJsonAsync(string relativeUrl)
        {
            string content = await GetStringAsync(relativeUrl);
            return JObject.Parse(content);
        }
    }
}
