using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace NextStream.DataAccessLayer;

[Table("MovieGenre")]
public partial class MovieGenre
{
    [Key]
    [Column("ID")]
    public int Id { get; set; }

    [Column("MovieID")]
    public int MovieId { get; set; }

    [Column("GenreID")]
    public int GenreId { get; set; }

    [ForeignKey("GenreId")]
    [InverseProperty("MovieGenres")]
    public virtual Genre Genre { get; set; } = null!;

    [ForeignKey("MovieId")]
    [InverseProperty("MovieGenres")]
    public virtual Movie Movie { get; set; } = null!;
}
