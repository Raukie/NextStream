using System;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Logging.Abstractions;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Polly;
using Polly.RateLimit;
using Polly.Retry;
using Polly.Wrap;

namespace NextStream.MovieScraper
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
                BaseAddress = new Uri("https://brave-api.archive.org/"),
                Timeout = TimeSpan.FromHours(1)
            };

            var rateLimitPolicy = Policy.RateLimitAsync(200, TimeSpan.FromSeconds(60), 200);

            var retryPolicy =
                Policy
                    .Handle<RateLimitRejectedException>()
                    .WaitAndRetryAsync
                    (
                        retryCount: 3,
                        retryNumber => TimeSpan.FromSeconds(60)
                    )
                    .WrapAsync(rateLimitPolicy);

            // Retry on transient HTTP errors (like 500, 502, 503)
            var httpRetryPolicy = Policy
                .Handle<HttpRequestException>()
                .OrResult<HttpResponseMessage>(r => !r.IsSuccessStatusCode)
                .WaitAndRetryAsync(
                    retryCount: 3,
                    sleepDurationProvider: attempt => TimeSpan.FromSeconds(Math.Pow(2, attempt)),
                    onRetry: async (outcome, timespan, attempt, context) =>
                    {
                        var result = outcome?.Result;
                        var content = result != null ? await result.Content.ReadAsStringAsync() : "N/A";
                        var statusCode = result?.StatusCode.ToString() ?? "Exception";
                        _logger.LogError($"[HTTP Error] Attempt {attempt}: Status '{statusCode}' - Response: {content}");
                        _logger.LogWarning($"[Retry] Waiting {timespan.TotalSeconds}s before retrying...");
                    });

            // Combine them into a policy wrap: first apply rateLimit, then retry policies
            _policyWrap = httpRetryPolicy.WrapAsync(retryPolicy);
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
        public async Task<T?> GetJsonAsync<T>(string relativeUrl) where T : class
        {
            string content = await GetStringAsync(relativeUrl);
            return JsonConvert.DeserializeObject<T>(content);
        }

        /// <summary>
        /// Used to download files for example
        /// </summary>
        /// <param name="fullUrl"></param>
        /// <returns></returns>
        public async Task<HttpResponseMessage> GetHttpResponseAsync(string fullUrl)
        {
            var request = new HttpRequestMessage(HttpMethod.Get, fullUrl);
            return await _policyWrap.ExecuteAsync(() => _httpClient.SendAsync(request));
        }
    }
}
