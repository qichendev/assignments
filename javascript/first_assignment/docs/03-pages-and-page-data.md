# Pages, Routes, and UI

## Add User Page `/users/new`

Purpose:

- Enter a complete new user record

Data displayed or entered on the page:

| Field | Form Control | Required | Description |
| --- | --- | --- | --- |
| `lastName` | text input | Yes | User last name |
| `firstName` | text input | Yes | User first name |
| `dateOfBirth` | date input | No | Date of birth |
| `address1` | text input | No | Address line 1 |
| `address2` | text input | No | Address line 2 |
| `city` | text input | No | City |
| `postalCode` | text input | No | Postal code |
| `country` | text input | No | Country |
| `phoneNumber` | text input | No | Phone number |
| `email` | email input | Yes | Email address |
| `userNotes` | textarea | No | User notes |

Submitted data:

- Uses `POST /users/create`
- Sends the fields above in the request body
- On success, redirects to the list page or shows a success message

## Edit User Page `/users/:id/edit`

Purpose:

- View and modify an existing user
- Delete the current user

Data displayed or edited on the page:

| Field | Display Type | Editable | Description |
| --- | --- | --- | --- |
| `_id` | hidden field or route param | No | Unique user identifier |
| `lastName` | text input | Yes | User last name |
| `firstName` | text input | Yes | User first name |
| `dateOfBirth` | date input | Yes | Date of birth |
| `address1` | text input | Yes | Address line 1 |
| `address2` | text input | Yes | Address line 2 |
| `city` | text input | Yes | City |
| `postalCode` | text input | Yes | Postal code |
| `country` | text input | Yes | Country |
| `phoneNumber` | text input | Yes | Phone number |
| `email` | email input | Yes | Email address |
| `userNotes` | textarea | Yes | User notes |
| `createdAt` | text display | No | Created time, optional |
| `updatedAt` | text display | No | Updated time, optional |

Update and delete payloads:

- Save uses `POST /users/:id/update`
- Sends all editable fields in the form
- Delete uses `POST /users/:id/delete`
- The request must identify the current user by `_id`

## User List Page `/users`

Purpose:

- Show all users in a table
- Provide navigation to the Add and Edit pages

Displayed data:

| Column | Source Field | Description |
| --- | --- | --- |
| Full Name | `firstName` + `lastName` | Combined display name |
| Date of Birth | `dateOfBirth` | Birth date |
| City | `city` | City |
| Country | `country` | Country |
| Phone | `phoneNumber` | Phone number |
| Email | `email` | Email address |
| Notes Preview | `userNotes` | Short notes preview |
| Actions | `_id` | Used to generate Edit links |

Additional page behavior:

- Show an `Add User` button linking to `/users/new`
- Show an `Edit` button per row linking to `/users/:id/edit`
- A summary such as `Total Users` may be shown if useful

## Routes Summary

| Method | Path | Purpose |
| --- | --- | --- |
| `GET` | `/` | Redirect to `/users` |
| `GET` | `/users` | User list page |
| `GET` | `/users/new` | Add page |
| `POST` | `/users/create` | Create user |
| `GET` | `/users/:id/edit` | Edit page |
| `POST` | `/users/:id/update` | Update user |
| `POST` | `/users/:id/delete` | Delete user |

## Controller Responsibilities

- `listUsers`: query all users and render the list
- `renderCreateForm`: render the add page
- `createUser`: handle add submission
- `renderEditForm`: query one user and render the edit page
- `updateUser`: handle update submission
- `deleteUser`: handle delete submission

## Shared UI Summary

Use `Pug` for all templates and `Bootstrap 5` for styling.

Shared view structure:

- `views/layout.pug`
- `views/partials/navbar.pug`
- `views/users/list.pug`
- `views/users/create.pug`
- `views/users/edit.pug`

Shared components:

- Shared layout
- Navigation bar
- Page header
- Shared user form structure for add and edit pages
- Table for user listing
- Save, delete, and navigation buttons

Key UI requirements:

- All 3 pages should use a consistent layout
- Required fields should be clearly marked
- Validation errors should be visible
- The edit page should prefill existing values
- The delete button should appear only on the edit page
- The list page should never render as an unexplained blank table

## Page-Level Content Summary

### Add User Page

Routes:

- `GET /users/new`
- `POST /users/create`

Page content:

- Bootstrap navigation bar
- User entry form
- Submit button
- Success or error feedback area

### Edit User Page

Routes:

- `GET /users/:id/edit`
- `POST /users/:id/update`
- `POST /users/:id/delete`

Page content:

- Pre-filled user form
- Save button
- Delete button
- Back to list button

Note:

- To match the assignment requirement, both update and delete actions should use `POST`

### User List Page

Route:

- `GET /users`

Page content:

- Bootstrap navigation bar
- `Add User` button
- User table
- One `Edit` button per row

Table columns:

- Full Name
- Date of Birth
- City
- Country
- Phone
- Email
- Actions
