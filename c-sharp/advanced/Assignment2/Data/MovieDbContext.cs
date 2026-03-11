using Microsoft.EntityFrameworkCore;
using MoviesManager.Models;

namespace MoviesManager.Data;

public class MovieDbContext : DbContext
{
    public MovieDbContext(DbContextOptions<MovieDbContext> options)
        : base(options)
    {
    }

    public DbSet<Movie> Movies { get; set; } = null!;

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // Seed initial data
        modelBuilder.Entity<Movie>().HasData(
            new Movie { Id = 1, Title = "Inception", Director = "Christopher Nolan", Genre = "Sci-Fi", Year = 2010, Rating = 8.8m },
            new Movie { Id = 2, Title = "The Godfather", Director = "Francis Ford Coppola", Genre = "Crime", Year = 1972, Rating = 9.2m },
            new Movie { Id = 3, Title = "The Dark Knight", Director = "Christopher Nolan", Genre = "Action", Year = 2008, Rating = 9.0m }
        );
    }
}
