# Full Stack JavaScript - First Assignment

## Project Summary

This project is a user management CRUD web application built for the first Full Stack JavaScript assignment.

The application stores and manages the following user data:

- Last Name
- First Name
- Date of Birth
- Address1
- Address2
- City
- Postal Code
- Country
- Phone Number
- Email
- User Notes

All create, update, and delete form submissions use `POST` requests to match the assignment requirement.

## Implementation Approach

The assignment allows multiple implementation options. This project adopts the following implementation stack:

- Runtime and server: `Node.js + Express`
- Templating: `Pug`
- Styling: `Bootstrap 5`
- Database: `MongoDB` running locally in Docker
- ODM: `Mongoose`
- Testing: `Playwright`
- Runtime target: local Node.js server

These choices are project-specific implementation decisions used to satisfy the assignment requirements. They describe how this project is built and deployed; they do not redefine the assignment itself.

The application is developed as an `Express`-based server-rendered web app and is intended to be run locally with a Docker-hosted MongoDB database.

## Required Pages and Features

The application includes the three required pages and the corresponding CRUD behavior:

1. Add User page for creating a user
2. Edit User page for updating a user and performing the required delete action
3. User List page for displaying all users and linking to add/edit actions

Core implementation features:

- Server-rendered pages with `Pug`
- Shared navigation/menu structure
- MongoDB-backed user storage
- `POST` form submissions for create, update, and delete operations

## Page Behavior

### Add User

- Route: `GET /users/new`
- Submit: `POST /users/create`
- Purpose: create a new user record

### Edit User

- Route: `GET /users/:id/edit`
- Submit: `POST /users/:id/update`
- Delete: `POST /users/:id/delete`
- Purpose: edit or delete an existing user record

### User List

- Route: `GET /users`
- Purpose: display all users in a table and link to add/edit actions

## Local Development

Setup:

```bash
npm install
```

Create an environment file for local development:

```env
PORT=3000
MONGODB_URI=mongodb://127.0.0.1:27017/first_assignment
```

Start the local MongoDB database with Docker:

```bash
docker run -d \
  --name first-assignment-mongo \
  -p 27017:27017 \
  -e MONGO_INITDB_DATABASE=first_assignment \
  mongo:7
```

Use the following local environment values:

```env
PORT=3000
MONGODB_URI=mongodb://127.0.0.1:27017/first_assignment
```

To stop and remove the local test database:

```bash
docker stop first-assignment-mongo
docker rm first-assignment-mongo
```

Preferred local start command:

```bash
npm run dev
```

If a development script is not defined, use the standard start command:

```bash
npm start
```

## Testing

End-to-end testing is implemented with Playwright.

Recommended local database-backed test flow:

1. Start the Docker MongoDB container
2. Set `MONGODB_URI=mongodb://127.0.0.1:27017/first_assignment`
3. Start the application with `npm run dev` or `npm start`
4. Run Playwright with `npx playwright test`

Test command:

```bash
npx playwright test
```

Main test coverage:

- Add user flow
- Update user flow
- Delete user flow
- Basic page rendering checks

## Runtime Approach

This project is intended to run locally:

- Application server: `Node.js + Express`
- Database server: `MongoDB` in Docker
- Application URL: `http://127.0.0.1:3000/users`

## Submission Requirements

The final submission should include:

- Source code
- `README.md`
- `DEVELOPMENT_CHECKLIST.md`
- Screenshots of the three completed pages
- `index.js` with the required header comment
- A ZIP file named with the student's `CNumber`

Do not include `node_modules`.

## Documentation Map

Detailed project documentation is organized in the `docs/` directory:

- [Project Overview](./docs/01-project-overview.md)
- [Data Model](./docs/02-data-model.md)
- [Pages, Routes, and UI](./docs/03-pages-and-page-data.md)
- [Project Structure and Development Plan](./docs/06-project-structure.md)
- [Testing, Local Runtime, and Submission](./docs/10-submission-checklist.md)
