# Data Model

## User Schema

Use a `Mongoose Schema` to define a `User` model with the following fields:

| Field | Type | Description |
| --- | --- | --- |
| `lastName` | String | User last name |
| `firstName` | String | User first name |
| `dateOfBirth` | Date | Date of birth |
| `address1` | String | Address line 1 |
| `address2` | String | Address line 2 |
| `city` | String | City |
| `postalCode` | String | Postal code |
| `country` | String | Country |
| `phoneNumber` | String | Phone number |
| `email` | String | Email address |
| `userNotes` | String | User notes |
| `createdAt` | Date | Record creation time |
| `updatedAt` | Date | Record last update time |

## Validation Rules

- `lastName`, `firstName`, and `email` are required
- `email` should have basic format validation
- `dateOfBirth` should use a date input on the UI
- `postalCode` and `phoneNumber` should be stored as strings
- Enable `timestamps: true`
