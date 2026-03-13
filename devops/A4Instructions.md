# Week 7 – Assignment 4: Flask App Deployment with Docker & GitHub Actions

This assignment focuses on developing and deploying a Python Flask application using Docker, environment variables, GitHub Actions, and Dependabot. You will create the full application and associated configuration files, test the application locally, and publish your work to GitHub.

---

## Learning Objectives

- Build a Python Flask application with multiple routes.
- Use environment variables securely via `.env` files and GitHub Secrets.
- Containerize an application using Docker.
- Use Docker Compose for local multi-file configuration.
- Automate builds using GitHub Actions.
- Enable automated dependency updates with Dependabot.

---

## Tasks

### 1. Create a Python Flask Application

Your Flask app must include:

- A home route (`/`) that returns the value of the environment variable `APP_MESSAGE`.
- A `/health` route that returns the value of the environment variable `APP_HEALTH`.

### 2. Create the Required Supporting Files

You must create and commit the following files:

| File | Description |
|------|-------------|
| `requirements.txt` | Must include Flask. |
| `Dockerfile` | Containerizes the application. |
| `docker-compose.yml` | Runs the application locally using environment variables. |
| `.env` | Used locally only (do not commit). |
| `.env.example` | Must include `APP_MESSAGE` and `APP_HEALTH` with example values. |
| `.gitignore` | Must exclude `.env` and `__pycache__/`. |

### 3. Configure GitHub Actions Workflow

- Trigger the workflow on `push` and `pull_request`.
- Create a `.env` file during workflow execution using GitHub Secrets (`APP_MESSAGE` and `APP_HEALTH`).
- Build or run the Docker container within the workflow.
- Include a step confirming that the `.env` file was created.

### 4. Add Dependabot Configuration

Create a `dependabot.yml` file that enables weekly updates for:

- pip
- Docker
- GitHub Actions

### 5. Test Your Application Locally

Run the following command to build and test your application:

```bash
docker compose up --build
```

Ensure that:

- The home route (`/`) displays the `APP_MESSAGE` value.
- The `/health` route displays the `APP_HEALTH` value.

### 6. Publish Your Code to GitHub

Push your completed project to GitHub, then add the GitHub Secrets:

- `APP_MESSAGE`
- `APP_HEALTH`

---

## Submission Instructions

Submit this document with your GitHub repository URL:

```
https://github.com/<your-username>/<your-repo-name>
```