using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Moq;
using MoviesManager.Controllers;
using MoviesManager.Data;
using MoviesManager.Models;
using Xunit;

namespace MoviesManager.Tests;

/// <summary>
/// Integration tests for MovieController using EF Core InMemory database.
/// </summary>
public class MovieControllerTests : IDisposable
{
    private readonly MovieDbContext _context;
    private readonly Mock<ILogger<MovieController>> _loggerMock;
    private readonly MovieController _controller;

    public MovieControllerTests()
    {
        var options = new DbContextOptionsBuilder<MovieDbContext>()
            .UseInMemoryDatabase(databaseName: Guid.NewGuid().ToString())
            .Options;

        _context = new MovieDbContext(options);
        _loggerMock = new Mock<ILogger<MovieController>>();
        _controller = new MovieController(_context, _loggerMock.Object);

        SeedDatabase();
    }

    private void SeedDatabase()
    {
        _context.Movies.AddRange(
            new Movie { Id = 1, Title = "Inception", Director = "Christopher Nolan", Genre = "Sci-Fi", Year = 2010, Rating = 8.8m },
            new Movie { Id = 2, Title = "The Godfather", Director = "Francis Ford Coppola", Genre = "Crime", Year = 1972, Rating = 9.2m }
        );
        _context.SaveChanges();
    }

    // Test 1: Index returns all movies
    [Fact]
    public async Task Index_ReturnsViewWithAllMovies()
    {
        var result = await _controller.Index();

        var viewResult = Assert.IsType<ViewResult>(result);
        var movies = Assert.IsAssignableFrom<IEnumerable<Movie>>(viewResult.Model);
        Assert.Equal(2, movies.Count());
    }

    // Test 2: Create GET returns view
    [Fact]
    public void Create_Get_ReturnsView()
    {
        var result = _controller.Create();

        Assert.IsType<ViewResult>(result);
    }

    // Test 3: Create POST with valid data saves to database
    [Fact]
    public async Task Create_Post_WithValidMovie_SavesAndRedirects()
    {
        var newMovie = new Movie
        {
            Title = "The Dark Knight",
            Director = "Christopher Nolan",
            Genre = "Action",
            Year = 2008,
            Rating = 9.0m
        };

        var result = await _controller.Create(newMovie);

        var redirect = Assert.IsType<RedirectToActionResult>(result);
        Assert.Equal("Index", redirect.ActionName);
        Assert.Equal(3, await _context.Movies.CountAsync());
    }

    // Test 4: Edit GET with valid id returns view with movie
    [Fact]
    public async Task Edit_Get_WithValidId_ReturnsMovieInView()
    {
        var result = await _controller.Edit(1);

        var viewResult = Assert.IsType<ViewResult>(result);
        var movie = Assert.IsType<Movie>(viewResult.Model);
        Assert.Equal("Inception", movie.Title);
    }

    // Test 5: Edit GET with null id returns NotFound
    [Fact]
    public async Task Edit_Get_WithNullId_ReturnsNotFound()
    {
        var result = await _controller.Edit(null);

        Assert.IsType<NotFoundResult>(result);
    }

    // Test 6: Edit GET with non-existent id returns NotFound
    [Fact]
    public async Task Edit_Get_WithNonExistentId_ReturnsNotFound()
    {
        var result = await _controller.Edit(999);

        Assert.IsType<NotFoundResult>(result);
    }

    // Test 7: Delete GET with valid id returns view with movie
    [Fact]
    public async Task Delete_Get_WithValidId_ReturnsMovieInView()
    {
        var result = await _controller.Delete(1);

        var viewResult = Assert.IsType<ViewResult>(result);
        var movie = Assert.IsType<Movie>(viewResult.Model);
        Assert.Equal(1, movie.Id);
    }

    // Test 8: DeleteConfirmed removes movie from database
    [Fact]
    public async Task DeleteConfirmed_RemovesMovieAndRedirects()
    {
        var result = await _controller.DeleteConfirmed(1);

        var redirect = Assert.IsType<RedirectToActionResult>(result);
        Assert.Equal("Index", redirect.ActionName);
        Assert.Equal(1, await _context.Movies.CountAsync());
        Assert.Null(await _context.Movies.FindAsync(1));
    }

    // Test 9: Create POST with invalid model returns view
    [Fact]
    public async Task Create_Post_WithInvalidModel_ReturnsView()
    {
        _controller.ModelState.AddModelError("Title", "Title is required");
        var invalidMovie = new Movie { Title = "" };

        var result = await _controller.Create(invalidMovie);

        Assert.IsType<ViewResult>(result);
    }

    // Test 10: Delete GET with null id returns NotFound
    [Fact]
    public async Task Delete_Get_WithNullId_ReturnsNotFound()
    {
        var result = await _controller.Delete(null);

        Assert.IsType<NotFoundResult>(result);
    }

    public void Dispose()
    {
        _context.Dispose();
    }
}
