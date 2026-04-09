using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MoviesManager.Data;
using MoviesManager.Models;

namespace MoviesManager.Controllers;

public class MovieController : Controller
{
    private readonly MovieDbContext _context;
    private readonly ILogger<MovieController> _logger;

    public MovieController(MovieDbContext context, ILogger<MovieController> logger)
    {
        _context = context;
        _logger = logger;
    }

    public async Task<IActionResult> Index()
    {
        _logger.LogInformation("Fetching all movies from database");
        var movies = await _context.Movies.ToListAsync();
        _logger.LogInformation("Retrieved {Count} movies", movies.Count);
        return View(movies);
    }

    public IActionResult Create()
    {
        _logger.LogInformation("Navigated to Create Movie page");
        return View();
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Create([Bind("Id,Title,Director,Genre,Year,Rating")] Movie movie)
    {
        if (ModelState.IsValid)
        {
            _context.Add(movie);
            await _context.SaveChangesAsync();
            _logger.LogInformation("Created new movie: {Title} (Id={Id})", movie.Title, movie.Id);
            return RedirectToAction(nameof(Index));
        }
        _logger.LogWarning("Create movie failed validation for: {Title}", movie.Title);
        return View(movie);
    }

    public async Task<IActionResult> Edit(int? id)
    {
        if (id == null)
        {
            _logger.LogWarning("Edit called with null id");
            return NotFound();
        }

        var movie = await _context.Movies.FindAsync(id);
        if (movie == null)
        {
            _logger.LogWarning("Edit: Movie with Id={Id} not found", id);
            return NotFound();
        }

        _logger.LogInformation("Navigated to Edit page for movie Id={Id}", id);
        return View(movie);
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Edit(int id, [Bind("Id,Title,Director,Genre,Year,Rating")] Movie movie)
    {
        if (id != movie.Id)
        {
            _logger.LogWarning("Edit POST: route id={RouteId} does not match model id={ModelId}", id, movie.Id);
            return NotFound();
        }

        if (ModelState.IsValid)
        {
            try
            {
                _context.Update(movie);
                await _context.SaveChangesAsync();
                _logger.LogInformation("Updated movie Id={Id}, Title={Title}", movie.Id, movie.Title);
            }
            catch (DbUpdateConcurrencyException ex)
            {
                if (!MovieExists(movie.Id))
                {
                    _logger.LogError(ex, "Concurrency error: movie Id={Id} no longer exists", movie.Id);
                    return NotFound();
                }
                else
                {
                    _logger.LogError(ex, "Concurrency error updating movie Id={Id}", movie.Id);
                    throw;
                }
            }
            return RedirectToAction(nameof(Index));
        }
        _logger.LogWarning("Edit movie failed validation for Id={Id}", movie.Id);
        return View(movie);
    }

    public async Task<IActionResult> Delete(int? id)
    {
        if (id == null)
        {
            _logger.LogWarning("Delete called with null id");
            return NotFound();
        }

        var movie = await _context.Movies.FirstOrDefaultAsync(m => m.Id == id);
        if (movie == null)
        {
            _logger.LogWarning("Delete: Movie with Id={Id} not found", id);
            return NotFound();
        }

        _logger.LogInformation("Navigated to Delete confirmation for movie Id={Id}", id);
        return View(movie);
    }

    [HttpPost, ActionName("Delete")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> DeleteConfirmed(int id)
    {
        var movie = await _context.Movies.FindAsync(id);
        if (movie != null)
        {
            _context.Movies.Remove(movie);
            await _context.SaveChangesAsync();
            _logger.LogInformation("Deleted movie Id={Id}, Title={Title}", id, movie.Title);
        }
        else
        {
            _logger.LogWarning("DeleteConfirmed: Movie with Id={Id} not found", id);
        }

        return RedirectToAction(nameof(Index));
    }

    private bool MovieExists(int id)
    {
        return _context.Movies.Any(e => e.Id == id);
    }
}
