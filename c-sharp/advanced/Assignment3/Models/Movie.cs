using System.ComponentModel.DataAnnotations;

namespace MoviesManager.Models;

public class Movie
{
    public int Id { get; set; }

    [Required(ErrorMessage = "Title is required")]
    [StringLength(100, MinimumLength = 2, ErrorMessage = "Title must be between 2 and 100 characters")]
    public string Title { get; set; } = string.Empty;

    [Required(ErrorMessage = "Director is required")]
    [StringLength(100, MinimumLength = 2, ErrorMessage = "Director must be between 2 and 100 characters")]
    public string Director { get; set; } = string.Empty;

    [Required(ErrorMessage = "Genre is required")]
    [StringLength(50, MinimumLength = 2, ErrorMessage = "Genre must be between 2 and 50 characters")]
    public string Genre { get; set; } = string.Empty;

    [Required(ErrorMessage = "Year is required")]
    [Range(1888, 2030, ErrorMessage = "Year must be between 1888 and 2030")]
    public int Year { get; set; }

    [Required(ErrorMessage = "Rating is required")]
    [Range(0.0, 10.0, ErrorMessage = "Rating must be between 0 and 10")]
    public decimal Rating { get; set; }
}
