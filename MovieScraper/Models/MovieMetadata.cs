using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace NextStream.MovieScraper.Models
{
    public class MovieMetadata
    {
        public string Identifier { get; set; } = String.Empty;
        public string Title { get; set; } = String.Empty;
        public string Description { get; set; } = String.Empty;
        [JsonIgnore]
        public List<string> Genre { get; set; } =  [];
        [JsonIgnore]
        public string Date { get; set; } = String.Empty;
        [JsonIgnore]
        public List<string> Creator { get; set; } = [];
        public List<MovieFile> Files { get; set; } = new();
    }

    public class MovieFile
    {
        public string Name { get; set; } = String.Empty;
        public string Format { get; set; } = String.Empty;
        public string Source { get; set; } = String.Empty;
        public long Size { get; set; }
        public string? Md5 { get; set; }
        public string? Sha1 { get; set; }
        public string? Crc32 { get; set; }
        public string? Length { get; set; }
        public int? Width { get; set; }
        public int? Height { get; set; }
    }
}
