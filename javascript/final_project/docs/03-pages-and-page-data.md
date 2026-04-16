# Pages, Routes, and UI

## React Pages

The React application lives in `client/src/main.jsx` and uses component state for simple page navigation.

| Page | Purpose | Main UI |
| --- | --- | --- |
| Login | Demonstrates a required login screen | Email/password form and sign-in button |
| Table/Grid | Displays all user records | Responsive Bootstrap table with edit actions |
| Add User | Creates a new user | Reusable React user form |
| Update User | Updates or deletes an existing user | Prefilled user form with save and delete buttons |

## Add User Page

Purpose:

- Enter a complete new user record.
- Submit the form with Axios.
- Create the user through the Express API.

Submitted data:

- Uses `POST /api/users`
- Sends JSON in the request body
- Shows validation errors returned by the API
- Returns to the table page after a successful create

## Update User Page

Purpose:

- Load one user by id.
- Prefill the React form with current values.
- Save edits.
- Delete the current user.

Update behavior:

- Loads the selected user with `GET /api/users/:id`
- Saves changes with `PUT /api/users/:id`
- Sends all editable fields as JSON
- Returns to the table page after a successful update

Delete behavior:

- Uses `DELETE /api/users/:id`
- The delete button appears on the update page
- Returns to the table page after a successful delete

## Table/Grid Page

Purpose:

- Show all users in a responsive table.
- Provide access to the update page.
- Refresh data from the API.

Displayed data:

| Column | Source Field | Description |
| --- | --- | --- |
| Name | `firstName` + `lastName` | Combined display name |
| Date of Birth | `dateOfBirth` | Birth date |
| City | `city` | City |
| Country | `country` | Country |
| Phone | `phoneNumber` | Phone number |
| Email | `email` | Email address |
| Notes | `userNotes` | User notes |
| Action | `_id` | Used to load the update form |

## REST API Summary

| Method | Path | Purpose |
| --- | --- | --- |
| `GET` | `/api/users` | List all users |
| `GET` | `/api/users/:id` | Load one user |
| `POST` | `/api/users` | Create one user |
| `PUT` | `/api/users/:id` | Update one user |
| `DELETE` | `/api/users/:id` | Delete one user |

## Controller Responsibilities

- `listUsers`: return all users as JSON
- `getUser`: return one user as JSON
- `createUser`: validate and create a user
- `updateUser`: validate and update a user
- `deleteUser`: delete a user by id

## Shared UI Summary

The React UI uses:

- `client/src/main.jsx` for app state, page selection, and API flow
- `client/src/components/UserForm.jsx` for the reusable add/update form
- `client/src/api/users.js` for Axios calls
- `client/src/styles.css` for custom styling
- Bootstrap classes for form, table, alert, and button styling

Key UI requirements:

- Required fields are enforced by React form controls and Mongoose validation
- Validation errors from the API are visible in the UI
- The update page prefills existing values
- The delete button appears on the update page
- The table page handles an empty user list clearly
