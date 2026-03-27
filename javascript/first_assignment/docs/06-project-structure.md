# Project Structure and Development Plan

## Target File Layout

```text
first_assignment/
├── index.js
├── app.js
├── package.json
├── .dev.vars
├── .gitignore
├── README.md
├── DEVELOPMENT_CHECKLIST.md
├── playwright.config.js
├── docs/
│   ├── 01-project-overview.md
│   ├── 02-data-model.md
│   ├── 03-pages-and-page-data.md
│   ├── 06-project-structure.md
│   └── 10-submission-checklist.md
├── tests/
│   ├── users.spec.js
│   └── helpers/
├── config/
│   └── db.js
├── controllers/
│   └── userController.js
├── models/
│   └── User.js
├── routes/
│   └── userRoutes.js
├── views/
│   ├── layout.pug
│   ├── partials/
│   │   └── navbar.pug
│   └── users/
│       ├── list.pug
│       ├── create.pug
│       └── edit.pug
├── public/
│   └── css/
│       └── styles.css
└── screenshots/
    ├── list-page.png
    ├── create-page.png
    └── edit-page.png
```

## Notes

- `index.js` is the main entry file and should contain the required header comment with the student name and `CNumber`
- `playwright.config.js` and `tests/` are for automated tests
- `config/db.js` should connect to the local Docker MongoDB instance with `mongoose.connect()`
- `screenshots/` stores final submission screenshots
- This layout describes the intended project structure for implementation and submission, not the current state of the repository at every stage of development

## Development Plan

### Phase 1: Project Setup

1. Initialize `package.json`
2. Install dependencies:
   - `express`
   - `pug`
   - `bootstrap`
   - `mongoose`
   - `dotenv`
3. Install development dependencies:
   - `nodemon`
   - `@playwright/test`
4. Create the base directory structure
5. Configure `.gitignore`

### Phase 2: Base Application Setup

1. Create `index.js` and `app.js`
2. Configure Express
3. Configure static assets
4. Configure the `Pug` view engine
5. Configure form body parsing
6. Configure the local Docker MongoDB connection through `Mongoose`

### Phase 3: CRUD Implementation

1. Create the `User` Mongoose model
2. Implement create logic
3. Implement list logic
4. Implement edit-page logic
5. Implement update logic
6. Implement delete logic

### Phase 4: Frontend Pages

1. Implement the layout and navbar
2. Complete the add page
3. Complete the edit page
4. Complete the list page
5. Apply Bootstrap styling consistently

### Phase 5: Testing

1. Configure `playwright.config.js`
2. Write add-user tests
3. Write update-user tests
4. Write delete-user tests
5. Run and fix failing tests

### Phase 6: Deployment

1. Start the local Docker MongoDB container
2. Configure local environment variables
3. Configure `Mongoose` to connect to local MongoDB
4. Start the app locally
5. Verify access at `http://127.0.0.1:3000/users`

### Phase 7: Submission Preparation

1. Finalize `README.md`
2. Finalize `DEVELOPMENT_CHECKLIST.md`
3. Capture screenshots of the 3 final pages
4. Ensure `node_modules` is not included
5. Zip the project as `CNumber.zip`

## Execution Order

1. Build the local CRUD app first
2. Add end-to-end tests
3. Validate the local Docker-backed runtime last

This order keeps the assignment core stable before final local runtime verification.
