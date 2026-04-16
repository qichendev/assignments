# Project Overview

## Project Goal

Build a full-stack MERN user management website that satisfies the final assignment requirements.

The application stack is:

- Frontend: `React` with `Vite`
- Frontend HTTP client: `Axios`
- Styling: `Bootstrap 5` plus custom CSS
- Backend: `Node.js + Express`
- API style: REST endpoints under `/api/users`
- Database: `MongoDB`
- ODM: `Mongoose`
- Automated testing: `Playwright`

The application supports:

- A simple React login page
- A React form for adding users
- A React form for updating users
- A delete button on the update page
- A React table/grid page for displaying user data
- HTTP methods for database changes: `POST`, `PUT`, and `DELETE`
- Random seed data for MongoDB

## Overall Technical Approach

The project uses a separated MERN structure:

- The project root contains the Express API, database configuration, controllers, routes, models, tests, and documentation.
- The `client/` folder contains the Vite React application.
- During development, Vite serves the React app and proxies `/api` requests to Express.
- For production-style local serving, `npm run client:build` creates `client/dist`, and Express serves that build folder.

The backend keeps a clean data boundary:

- `models/User.js` defines the Mongoose schema.
- `models/userRepository.js` handles database operations.
- `controllers/userController.js` translates HTTP requests into repository calls.
- `routes/userRoutes.js` exposes the REST API.

## Runtime Notes

Expected local runtime:

- Express API: `http://127.0.0.1:3000`
- React development app: `http://127.0.0.1:5173`
- MongoDB URI example: `mongodb://127.0.0.1:27017/final_mern_users`

The app can also run without `MONGODB_URI` for basic local UI/testing because the repository includes an in-memory fallback. For final submission screenshots and seed data, use MongoDB.
