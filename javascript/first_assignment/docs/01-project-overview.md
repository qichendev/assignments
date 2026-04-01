# Project Overview

## Project Goal

Build a user management CRUD website that satisfies the assignment requirements and uses the following stack:

- Server framework: `Node.js + Express`
- Template engine: `Pug`
- UI framework: `Bootstrap 5`
- Database: local `MongoDB` in Docker
- ODM: `Mongoose`
- Automated testing: `Playwright`
- Runtime platform: local `Node.js`

The application must support:

- Collecting user data through web forms
- Using `POST` for form submissions
- Providing 3 pages:
  - Add User page
  - Edit User page
  - User List page
- Providing a delete button on the Edit User page

## Overall Technical Approach

Selected stack:

- Web framework: `Express`
- Template engine: `Pug`
- Styling: `Bootstrap 5`
- Database: local `MongoDB` in Docker
- ODM: `Mongoose`
- Test framework: `@playwright/test`
- Environment configuration:
  - Local development: `.env`

Implementation strategy:

- Build the app locally first as a standard Express application
- Render all pages with `Pug`
- Use `Bootstrap` components for a consistent UI
- Use `Mongoose` for schema definition, validation, and database access
- Cover critical user flows with `Playwright`
- Run the Express app locally against the Docker-hosted MongoDB instance

## Runtime Notes

This runtime approach has been selected:

- The application runs locally with `Node.js + Express`
- The database runs locally with Dockerized `MongoDB`
- `Mongoose` is used as the ODM layer for schema modeling and validation
- Playwright is used to verify the main CRUD flows

Runtime summary:

- Application server: local `Node.js + Express`
- Database server: local Docker `MongoDB`
- Primary usage mode: local development and local testing
