# Testing, Local Runtime, and Submission

## Testing Scope

Playwright covers the main user flows:

- Add user
- Update user
- Delete user
- Basic page rendering checks

Checks:

- All 3 pages load correctly
- Titles, forms, and buttons are visible
- The table renders correctly
- Test data is isolated when possible

## Local Runtime Summary

Application runtime:

- Local `Node.js + Express`

Database target:

- Local Docker `MongoDB`

Local development environment variables:

```env
PORT=3000
MONGODB_URI=mongodb://127.0.0.1:27017/first_assignment
```

Local Docker MongoDB setup:

```bash
docker run -d \
  --name first-assignment-mongo \
  -p 27017:27017 \
  -e MONGO_INITDB_DATABASE=first_assignment \
  mongo:7
```

Example local Docker database connection:

```env
PORT=3000
MONGODB_URI=mongodb://127.0.0.1:27017/first_assignment
```

Runtime notes:

- Start Docker before running the application
- Ensure port `27017` is available for MongoDB
- Ensure port `3000` is available for the Express app
- Keep `MONGODB_URI` aligned with the Docker container port mapping

## README Contents

- Project overview
- Environment requirements
- Dependency installation steps
- Local development startup instructions
- Playwright test instructions
- Docker MongoDB local runtime instructions
- Environment variable setup
- Summary of the 3 pages

## DEVELOPMENT_CHECKLIST Contents

Checklist items:

- Express project created
- Pug configured
- Bootstrap integrated
- MongoDB connected
- Mongoose connected to local Docker MongoDB
- Add page completed
- Edit page completed
- List page completed
- Delete feature completed
- Playwright tests written
- Local testing completed
- Optional Docker MongoDB local test path documented
- Local runtime verified
- README completed
- Screenshots prepared
- `node_modules` excluded from submission

## Submission Artifacts

- Source code project
- `README.md`
- `DEVELOPMENT_CHECKLIST.md`
- 3 page screenshots
- Runnable `package.json`
- Main entry file `index.js`

## Risks and Notes

- CRUD completeness is still the primary assignment requirement
- Functional pages should come before test polish and runtime refinement
- The delete button on the edit page must not be omitted
- The documented runtime path is local `Node.js + Express` with Docker `MongoDB`
