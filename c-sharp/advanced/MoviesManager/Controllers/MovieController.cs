using Microsoft.AspNetCore.Mvc;
using MoviesManager.Models;

namespace MoviesManager.Controllers;

public class MovieController : Controller
{
    private static readonly List<Movie> movies = new List<Movie>
    {
        new Movie { Id = 1, Title = "Inception", Director = "Christopher Nolan", Genre = "Sci-Fi", Year = 2010, Rating = 8.8m },
        new Movie { Id = 2, Title = "The Godfather", Director = "Francis Ford Coppola", Genre = "Crime", Year = 1972, Rating = 9.2m },
        new Movie { Id = 3, Title = "The Dark Knight", Director = "Christopher Nolan", Genre = "Action", Year = 2008, Rating = 9.0m }
    };
    public IActionResult Index()
    {
        return View(movies);
    }

    public IActionResult Create()
    {
        return View();
    }

    [HttpPost]
    public IActionResult Create(Movie movie)
    {
        if (ModelState.IsValid)
        {
            movie.Id = movies.Max(m => m.Id) + 1;
            movies.Add(movie);
            return RedirectToAction(nameof(Index));
        }
        return View(movie);
    }

    public IActionResult Edit(int id)
    {
        var movie = movies.FirstOrDefault(m => m.Id == id);
        if (movie == null)
        {
            return NotFound();
        }
        return View(movie);
    }

    [HttpPost]
    public IActionResult Edit(int id, Movie movie)
    {
        var tempMovie = movies.FirstOrDefault(m => m.Id == id);
        if (tempMovie == null)
        {
            return NotFound();
        }

        if (ModelState.IsValid)
        {
            tempMovie.Title = movie.Title;
            tempMovie.Director = movie.Director;
            tempMovie.Genre = movie.Genre;
            tempMovie.Year = movie.Year;
            tempMovie.Rating = movie.Rating;
            return RedirectToAction(nameof(Index));
        }
        return View(movie);
    }

    public IActionResult Delete(int id)
    {
        var movie = movies.FirstOrDefault(m => m.Id == id);
        if (movie == null)
        {
            return NotFound();
        }
        return View(movie);
    }

    [HttpPost, ActionName("Delete")]
    public IActionResult DeleteConfirmed(int id)
    {
        var tempMovie = movies.FirstOrDefault(m => m.Id == id);
        if (tempMovie == null)
        {
            return NotFound();
        }
        movies.Remove(tempMovie);
        return RedirectToAction(nameof(Index));
    }
}