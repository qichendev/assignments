# User Manual

## Start the Project

1. Install backend dependencies:

   ```bash
   npm install
   ```

2. Install React client dependencies:

   ```bash
   npm --prefix client install
   ```

3. Create a `.env` file in the project root:

   ```bash
   MONGODB_URI=mongodb://127.0.0.1:27017/final_mern_users
   PORT=3000
   ```

4. Add sample users:

   ```bash
   npm run seed
   ```

5. Run the Express API:

   ```bash
   npm run dev
   ```

6. In a second terminal, run the React client:

   ```bash
   npm run client:dev
   ```

7. Open the React app:

   ```text
   http://127.0.0.1:5173
   ```

## Use the Website

1. Sign in on the login page with any valid email and password.
2. Use the table page to view all users in MongoDB.
3. Select `Add` to create a new user record.
4. Select `Edit` beside a user in the table to update that user.
5. Use the delete button on the update page to remove the selected user.
6. Use `Refresh` on the table page to reload the latest database data.

## API Routes

| Method | Route | Purpose |
| --- | --- | --- |
| GET | `/api/users` | List all users |
| GET | `/api/users/:id` | Load one user |
| POST | `/api/users` | Create one user |
| PUT | `/api/users/:id` | Update one user |
| DELETE | `/api/users/:id` | Delete one user |
