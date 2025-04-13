using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace NextStream.DataAccessLayer;

[Table("User")]
public partial class User
{
    [Key]
    [Column("ID")]
    public int Id { get; set; }

    [Column("UserID")]
    public int UserId { get; set; }

    [InverseProperty("User")]
    public virtual ICollection<UserProfile> UserProfiles { get; set; } = new List<UserProfile>();
}
