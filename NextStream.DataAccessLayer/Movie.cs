using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace NextStream.DataAccessLayer;

[Table("Movie")]
public partial class Movie
{
    [Key]
    [Column("ID")]
    public int Id { get; set; }

    [StringLength(256)]
    public string Title { get; set; } = null!;

    [Column("ApiID")]
    public string ApiId { get; set; } = null!;

    public string Description { get; set; } = null!;

    [StringLength(256)]
    public string OriginalFilePath { get; set; } = null!;

    public bool ProcessedIntoStreamableFormat { get; set; }

    public bool DownloadedMovieFiles { get; set; }

    [Column(TypeName = "datetime")]
    public DateTime? Published { get; set; }

    [StringLength(256)]
    public string? Creator { get; set; }

    [StringLength(256)]
    public string? Subject { get; set; }

    [InverseProperty("Movie")]
    public virtual ICollection<MovieGenre> MovieGenres { get; set; } = new List<MovieGenre>();
}
