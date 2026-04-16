# Final MERN User CRUD

## Project Summary

This project is a MERN CRUD application for managing user records with a React/Vite frontend, an Express REST API, and MongoDB/Mongoose data storage.

The application stores and manages:

- Last name
- First name
- Date of birth
- Address 1
- Address 2
- City
- Postal code
- Country
- Phone number
- Email
- User notes

## Stack

- MongoDB and Mongoose for user data
- Express REST API for CRUD operations
- React and Axios for the web client
- Bootstrap and custom CSS for layout and styling

## REST API

| Method | Route | Purpose |
| --- | --- | --- |
| GET | `/api/users` | List all users |
| GET | `/api/users/:id` | Load one user |
| POST | `/api/users` | Create one user |
| PUT | `/api/users/:id` | Update one user |
| DELETE | `/api/users/:id` | Delete one user |

## Run the Project

Install dependencies:

```bash
npm install
npm --prefix client install
```

Create `.env`:

```env
PORT=3000
MONGODB_URI=mongodb://127.0.0.1:27017/final_mern_users
```

Seed the database:

```bash
npm run seed
```

Run the API:

```bash
npm run dev
```

Run the React client in a second terminal:

```bash
npm run client:dev
```

Open:

```text
http://127.0.0.1:5173
```

## Documentation

- [Final project checklist](docs/final-project-checklist.md)
- [User manual](docs/user-manual.md)
