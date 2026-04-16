# Testing, Local Runtime, and Submission

## Testing Scope

Playwright covers the main React user flows:

- Login page rendering
- Table/grid page rendering
- Add user
- Update user
- Delete user

Checks:

- The required pages load correctly
- Forms and buttons are visible
- The table renders current user data
- Create, update, and delete actions call the API successfully

## Local Runtime Summary

Application runtime:

- Backend: local `Node.js + Express`
- Frontend development server: local `Vite`
- Database target: local `MongoDB`

Environment variables:

```env
PORT=3000
HOST=127.0.0.1
MONGODB_URI=mongodb://127.0.0.1:27017/final_mern_users
```

Install dependencies:

```bash
npm install
npm --prefix client install
```

Seed sample data:

```bash
npm run seed
```

Run the backend:

```bash
npm run dev
```

Run the React client in a second terminal:

```bash
npm run client:dev
```

Open the app:

```text
http://127.0.0.1:5173
```

Build the React client:

```bash
npm run client:build
```

After the build, Express can serve the React app from `client/dist`.

## README Contents

- Project summary
- MERN stack summary
- REST API routes
- Dependency installation steps
- Environment variable setup
- Seed command
- Backend and frontend startup commands
- Documentation links

## Final Checklist Contents

Checklist items:

- Express REST API completed
- React client completed
- Bootstrap/custom CSS integrated
- MongoDB/Mongoose connected
- Seed script completed
- Login page completed
- Add page completed
- Update/delete page completed
- Table/grid page completed
- Playwright tests written
- Local build verified
- README completed
- User manual completed
- Screenshots prepared
- `node_modules` excluded from submission

## Submission Artifacts

- Source code project
- `README.md`
- Markdown checklist in `docs/final-project-checklist.md`
- Markdown user manual in `docs/user-manual.md`
- Page screenshots in `screenshots/`
- Runnable backend `package.json`
- Runnable React client `client/package.json`
- Main entry file `index.js` with the required header comment

## Risks and Notes

- Final screenshots should be captured with MongoDB running and seeded.
- Do not include `node_modules` in the ZIP file.
- Name the ZIP file with the CNumber before submitting.
