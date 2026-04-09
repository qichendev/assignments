# Assignment 4 – CSD-3353 Web Applications in C#.NET

**Weight: 15%**

**Final Enhancements – UI + Testing + Deployment**

Polish the frontend, implement testing and logging, and demonstrate deployment of your secure Movies app.

## Course Learning Outcomes (CLOs)

- **CLO 1:** Improve frontend styling using Bootstrap
- **CLO 5:** Debug and test application and deploy web application locally

## Features Added in Assignment 4

- **Bootstrap UI:** Responsive layout with cards, badges, color-coded ratings, and styled tables
- **ILogger:** Structured logging across all MovieController actions (Info, Warning, Error)
- **xUnit Tests:** 10 tests covering model validation and controller logic (using InMemory DB + Moq)
- **Deployment:** Published via `dotnet publish` for local web server simulation

## How to Run

```bash
# Restore dependencies
dotnet restore

# Run the application
dotnet run

# Open browser at:
# https://localhost:5001  (or the port shown in console)
```

## How to Run Tests

```bash
# From the solution root
dotnet test MoviesManager.Tests/

# With detailed output
dotnet test MoviesManager.Tests/ --verbosity normal
```

## How to Publish (Deployment)

```bash
# Publish to a local folder
dotnet publish -c Release -o ./publish

# Run the published app
cd publish
dotnet MoviesManager.dll
```

## Project Structure

```
Assignment4/
├── Controllers/
│   ├── HomeController.cs
│   ├── MovieController.cs       ← ILogger added
│   └── MoviesApiController.cs
├── Data/
│   └── MovieDbContext.cs
├── Models/
│   └── Movie.cs
├── Views/
│   └── Movie/
│       ├── Index.cshtml         ← Bootstrap table with badges
│       ├── Create.cshtml        ← Card layout form
│       ├── Edit.cshtml          ← Card layout form
│       └── Delete.cshtml        ← Danger card confirmation
├── MoviesManager.Tests/
│   ├── MovieModelTests.cs       ← 8 model validation tests
│   └── MovieControllerTests.cs  ← 10 controller tests
└── appsettings.json             ← Logging config
```

## Test Coverage Summary

| Test File | Tests | Covers |
|-----------|-------|--------|
| MovieModelTests.cs | 8 | Data annotation validation rules |
| MovieControllerTests.cs | 10 | CRUD actions, redirects, NotFound |

## Logging

Logs are written to the console with timestamps. Log levels:
- `Information` – normal operations (fetch, create, update, delete)
- `Warning` – null IDs, missing records, validation failures
- `Error` – database concurrency exceptions
