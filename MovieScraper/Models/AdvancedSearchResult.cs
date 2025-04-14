using System.Collections.Generic;
using Newtonsoft.Json;

namespace NextStream.MovieScraper.Models
{
    public class AdvancedSearchResult
    {
        [JsonProperty("responseHeader")]
        public ResponseHeader ResponseHeader { get; set; }

        [JsonProperty("response")]
        public ArchiveResponse Response { get; set; }
    }

    public class ResponseHeader
    {
        [JsonProperty("status")]
        public int Status { get; set; }

        [JsonProperty("QTime")]
        public int QTime { get; set; }

        [JsonProperty("params")]
        public QueryParams Params { get; set; }
    }

    public class QueryParams
    {
        [JsonProperty("query")]
        public string Query { get; set; }

        [JsonProperty("qin")]
        public string Qin { get; set; }

        [JsonProperty("fields")]
        public string Fields { get; set; }

        [JsonProperty("wt")]
        public string Wt { get; set; }

        [JsonProperty("sort")]
        public string Sort { get; set; }

        [JsonProperty("rows")]
        public int Rows { get; set; }

        [JsonProperty("start")]
        public int Start { get; set; }
    }

    public class ArchiveResponse
    {
        [JsonProperty("numFound")]
        public int NumFound { get; set; }

        [JsonProperty("start")]
        public int Start { get; set; }

        [JsonProperty("docs")]
        public List<ArchiveMovie> Docs { get; set; }
    }

    public class ArchiveMovie
    {
        [JsonProperty("creator")]
        public object Creator { get; set; } // can be string or array

        [JsonProperty("downloads")]
        public int Downloads { get; set; }

        [JsonProperty("genre")]
        public object Genre { get; set; } // can be string or array

        [JsonProperty("identifier")]
        public string Identifier { get; set; }

    }
}
