# azure-static-web-demo

qi's azure static web demo

# Azure Static Web App Demo (Starter)

## Goal

Deploy this static site template using **Azure Static Web Apps** and **GitHub Actions**. Update the content with your information, then submit your **repository URL**.

## Steps (High Level)

1. Clone this repo to your own GitHub account
2. Edit the files listed below to add your details.
3. Create an Azure Static Web App (Free plan) and connect it to this repo.
4. Wait for the workflow to appear and run. Make one more commit to trigger another run.
5. Confirm the site is live, then fill `grading.json` with the live URL.

## Files to Edit

- `index.html` — Update the title, your name, course, and keep the required string.
- `style.css` — You may personalize styles.
- `grading.json` — Fill out your name, course, GitHub username, and the live site URL.

## Required HTML Elements

- Your **full name** and **course code** must be visible on the page.
- Include this exact text somewhere on the page:

```
Azure Static Web Apps Deployment Successful
```

- Include this meta tag with your GitHub username:

```html
<meta name="github-username" content="YOUR_GITHUB_USERNAME">
```

## Notes

- Do **not** rename the repository. It must be `azure-static-web-demo`.
- Do **not** remove the required text string; the grader looks for it.
- Screenshots are **not** required; the grader uses your repo and live site.
