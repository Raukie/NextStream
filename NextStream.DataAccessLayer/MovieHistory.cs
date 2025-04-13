using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace NextStream.DataAccessLayer;

[Keyless]
[Table("MovieHistory")]
public partial class MovieHistory
{
    [Column("ProfileID")]
    public int ProfileId { get; set; }

    [Column("MovieID")]
    public int MovieId { get; set; }

    public bool IsWatching { get; set; }

    public int? CurrentPositionInSeconds { get; set; }

    [ForeignKey("MovieId")]
    public virtual Movie Movie { get; set; } = null!;

    [ForeignKey("ProfileId")]
    public virtual Profile Profile { get; set; } = null!;
}
