# Project Structure and Development Plan

## File Layout

```text
final_project/
├── index.js
├── app.js
├── package.json
├── package-lock.json
├── .gitignore
├── README.md
├── playwright.config.js
├── client/
│   ├── index.html
│   ├── package.json
│   ├── package-lock.json
│   ├── vite.config.js
│   └── src/
│       ├── main.jsx
│       ├── styles.css
│       ├── api/
│       │   └── users.js
│       └── components/
│           └── UserForm.jsx
├── config/
│   └── db.js
├── controllers/
│   └── userController.js
├── docs/
│   ├── 01-project-overview.md
│   ├── 02-data-model.md
│   ├── 03-pages-and-page-data.md
│   ├── 06-project-structure.md
│   ├── 10-submission-checklist.md
│   ├── final-project-checklist.md
│   └── user-manual.md
├── models/
│   ├── User.js
│   └── userRepository.js
├── routes/
│   └── userRoutes.js
├── scripts/
│   └── seedUsers.js
├── screenshots/
└── tests/
    └── users.spec.js
```

## Notes

- `index.js` is the main backend entry file and contains the required header comment with the student name and CNumber.
- `app.js` configures Express, JSON parsing, API routes, and static serving for `client/dist`.
- `client/` is the Vite React app.
- `config/db.js` connects to MongoDB when `MONGODB_URI` is set.
- `models/userRepository.js` keeps database access separate from controllers.
- `screenshots/` stores final submission screenshots.
- `docs/` contains the planning checklist, user manual, and supporting documentation.

## Development Plan

### Phase 1: Convert the Backend to a REST API

1. Keep the existing Express server.
2. Keep the existing MongoDB connection.
3. Keep the existing Mongoose `User` model.
4. Keep the repository layer for CRUD operations.
5. Replace page-rendering routes with JSON API routes.

### Phase 2: Add the React Client

1. Create a Vite React project in `client/`.
2. Add Axios for API requests.
3. Add Bootstrap and custom CSS.
4. Build a simple login page.
5. Build a table/grid page.
6. Build a reusable add/update user form.
7. Add delete behavior on the update page.

### Phase 3: Add Data and Documentation

1. Add `scripts/seedUsers.js` for random sample users.
2. Update `README.md`.
3. Add a Markdown final project checklist.
4. Add a Markdown user manual.
5. Prepare screenshots for each page.

### Phase 4: Verification

1. Build the React client with `npm run client:build`.
2. Start the Express app.
3. Verify `/` serves the React build.
4. Verify `/api/users` returns JSON.
5. Run Playwright tests for the main CRUD flow.

## Execution Order

1. Build and verify the REST API.
2. Build and verify the React UI.
3. Seed MongoDB data.
4. Capture screenshots.
5. Prepare the ZIP submission without `node_modules`.
