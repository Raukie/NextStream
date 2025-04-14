using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace NextStream.DataAccessLayer;

[Table("Genre")]
public partial class Genre
{
    [Key]
    [Column("ID")]
    public int Id { get; set; }

    [StringLength(256)]
    public string Name { get; set; } = null!;

    public virtual ICollection<Movie> Movies { get; set; } = new List<Movie>();
}
