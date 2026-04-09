using System.ComponentModel.DataAnnotations;
using MoviesManager.Models;
using Xunit;

namespace MoviesManager.Tests;

/// <summary>
/// Tests for Movie model validation rules.
/// </summary>
public class MovieModelTests
{
    private static List<ValidationResult> ValidateModel(Movie movie)
    {
        var results = new List<ValidationResult>();
        var context = new ValidationContext(movie);
        Validator.TryValidateObject(movie, context, results, validateAllProperties: true);
        return results;
    }

    // Test 1: Valid movie passes all validations
    [Fact]
    public void Movie_WithValidData_PassesValidation()
    {
        var movie = new Movie
        {
            Title = "Inception",
            Director = "Christopher Nolan",
            Genre = "Sci-Fi",
            Year = 2010,
            Rating = 8.8m
        };

        var errors = ValidateModel(movie);

        Assert.Empty(errors);
    }

    // Test 2: Empty title fails validation
    [Fact]
    public void Movie_WithEmptyTitle_FailsValidation()
    {
        var movie = new Movie
        {
            Title = "",
            Director = "Christopher Nolan",
            Genre = "Sci-Fi",
            Year = 2010,
            Rating = 8.8m
        };

        var errors = ValidateModel(movie);

        Assert.Contains(errors, e => e.MemberNames.Contains("Title"));
    }

    // Test 3: Rating above 10 fails validation
    [Fact]
    public void Movie_WithRatingAbove10_FailsValidation()
    {
        var movie = new Movie
        {
            Title = "Test Movie",
            Director = "Test Director",
            Genre = "Drama",
            Year = 2020,
            Rating = 11.0m
        };

        var errors = ValidateModel(movie);

        Assert.Contains(errors, e => e.MemberNames.Contains("Rating"));
    }

    // Test 4: Year below 1888 fails validation
    [Fact]
    public void Movie_WithYearBefore1888_FailsValidation()
    {
        var movie = new Movie
        {
            Title = "Ancient Film",
            Director = "Old Director",
            Genre = "History",
            Year = 1800,
            Rating = 5.0m
        };

        var errors = ValidateModel(movie);

        Assert.Contains(errors, e => e.MemberNames.Contains("Year"));
    }

    // Test 5: Title shorter than 2 characters fails validation
    [Fact]
    public void Movie_WithTitleTooShort_FailsValidation()
    {
        var movie = new Movie
        {
            Title = "X",
            Director = "Some Director",
            Genre = "Action",
            Year = 2000,
            Rating = 7.0m
        };

        var errors = ValidateModel(movie);

        Assert.Contains(errors, e => e.MemberNames.Contains("Title"));
    }

    // Test 6: Rating of exactly 0 is valid
    [Fact]
    public void Movie_WithRatingOfZero_PassesValidation()
    {
        var movie = new Movie
        {
            Title = "Bad Movie",
            Director = "Poor Director",
            Genre = "Comedy",
            Year = 2001,
            Rating = 0.0m
        };

        var errors = ValidateModel(movie);

        Assert.Empty(errors);
    }

    // Test 7: Rating of exactly 10 is valid
    [Fact]
    public void Movie_WithMaxRating_PassesValidation()
    {
        var movie = new Movie
        {
            Title = "Perfect Movie",
            Director = "Great Director",
            Genre = "Drama",
            Year = 2015,
            Rating = 10.0m
        };

        var errors = ValidateModel(movie);

        Assert.Empty(errors);
    }

    // Test 8: Empty Director fails validation
    [Fact]
    public void Movie_WithEmptyDirector_FailsValidation()
    {
        var movie = new Movie
        {
            Title = "Some Movie",
            Director = "",
            Genre = "Action",
            Year = 2020,
            Rating = 7.5m
        };

        var errors = ValidateModel(movie);

        Assert.Contains(errors, e => e.MemberNames.Contains("Director"));
    }
}
