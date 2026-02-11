
# Assignment 2 (Auto‑Gradable): Deploy a Static Website Using GitHub & Azure Static Web Apps

## Objective
Deploy a static website using Azure Static Web Apps with GitHub Actions and produce verifiable artifacts that can be graded automatically.

## Repository Requirements
Create a **public** GitHub repository named exactly:

```
azure-static-web-demo
```

Your repository **must** contain:

```
/
├─ index.html
├─ style.css
├─ grading.json
└─ .github/
   └─ workflows/
      └─ azure-static-web-apps.yml   (created by Azure during setup)
```

## Required Page Content (index.html)
Your homepage must include:

- A `<title>` tag
- Your **full name** (visible on the page)
- **Course code** (visible on the page)
- The exact text string:

  ```
  Azure Static Web Apps Deployment Successful
  ```
- A `<link>` reference to `style.css`
- A personalization meta tag with your GitHub username:

  ```html
  <meta name="github-username" content="YOUR_GITHUB_USERNAME">
  ```

## Azure Static Web App Setup
- Plan: **Free**
- Source: **GitHub**
- App location: `/`
- API location: *(leave blank)*
- Output location: *(leave blank)*
- Deployment authorization policy: **GitHub**

Azure will create the GitHub Actions workflow automatically after you connect your repo to the Static Web App. Make **at least one additional commit** after the workflow file appears so the pipeline runs again.

## `grading.json` (Required)
Create a file `grading.json` in the **repo root** with:

```json
{
  "studentName": "Your Full Name",
  "course": "COURSE-CODE",
  "assignment": "Assignment 2",
  "githubUsername": "YOUR_GITHUB_USERNAME",
  "staticWebAppUrl": "https://<your-app-name>.azurestaticapps.net"
}
```

## Submission
Submit **only** your GitHub repository URL in the D2L, e.g.

```
https://github.com/USERNAME/azure-static-web-demo
```

As well, you will likely encounter a few errors along the way; you will need to troubleshoot them to successfully get it to work.
If you have any questions, please feel free to ask.
