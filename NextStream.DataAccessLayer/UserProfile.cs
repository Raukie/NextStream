using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace NextStream.DataAccessLayer;

[Table("UserProfile")]
public partial class UserProfile
{
    [Key]
    [Column("ID")]
    public int Id { get; set; }

    [Column("UserID")]
    public int UserId { get; set; }

    [Column("ProfileID")]
    public int ProfileId { get; set; }

    [ForeignKey("ProfileId")]
    [InverseProperty("UserProfiles")]
    public virtual Profile Profile { get; set; } = null!;

    [ForeignKey("UserId")]
    [InverseProperty("UserProfiles")]
    public virtual User User { get; set; } = null!;
}
