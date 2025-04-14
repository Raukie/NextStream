using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.EntityFrameworkCore;

namespace NextStream.DataAccessLayer;

public partial class NextStreamContext : DbContext
{
    public NextStreamContext()
    {
    }

    public NextStreamContext(DbContextOptions<NextStreamContext> options)
        : base(options)
    {
    }

    public void SeedDatabaseWithUser()
    {
        
    }

    public virtual DbSet<Genre> Genres { get; set; }

    public virtual DbSet<Movie> Movies { get; set; }

    public virtual DbSet<MovieGenre> MovieGenres { get; set; }

    public virtual DbSet<MovieHistory> MovieHistories { get; set; }

    public virtual DbSet<Profile> Profiles { get; set; }

    public virtual DbSet<User> Users { get; set; }

    public virtual DbSet<UserProfile> UserProfiles { get; set; }


    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Genre>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Genre__3214EC27697E2EFD");
            entity.HasMany(e => e.Movies).WithMany(e => e.Genres).UsingEntity<MovieGenre>();
        });

        modelBuilder.Entity<Movie>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Movie__3214EC2773F364A1");
            entity.HasMany(e => e.Genres).WithMany(e => e.Movies).UsingEntity<MovieGenre>();
        });


        modelBuilder.Entity<MovieHistory>(entity =>
        {
            entity.HasOne(d => d.Movie).WithMany()
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__MovieHist__Movie__48CFD27E");

            entity.HasOne(d => d.Profile).WithMany()
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__MovieHist__Profi__47DBAE45");
        });

        modelBuilder.Entity<Profile>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Profile__3214EC27B1F76D41");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__User__3214EC27DB169862");
        });

        modelBuilder.Entity<UserProfile>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__UserProf__3214EC2719762B99");

            entity.HasOne(d => d.Profile).WithMany(p => p.UserProfiles)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__UserProfi__Profi__46E78A0C");

            entity.HasOne(d => d.User).WithMany(p => p.UserProfiles)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__UserProfi__UserI__45F365D3");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
