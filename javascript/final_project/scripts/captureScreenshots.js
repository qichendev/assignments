const { chromium } = require("@playwright/test");

const baseUrl = process.env.SCREENSHOT_BASE_URL || "http://127.0.0.1:3300";

async function captureScreenshots() {
  const browser = await chromium.launch();
  const page = await browser.newPage({ viewport: { width: 1920, height: 1080 } });

  await page.goto(baseUrl, { waitUntil: "networkidle" });
  await page.screenshot({ path: "screenshots/login-page.png", fullPage: false });

  await page.getByRole("button", { name: "Sign In" }).click();
  await page.waitForLoadState("networkidle");
  await page.screenshot({ path: "screenshots/table-page.png", fullPage: false });

  await page.getByRole("button", { name: "Add" }).click();
  await page.screenshot({ path: "screenshots/add-page.png", fullPage: false });

  await page.getByRole("button", { name: "Table" }).click();
  await page.getByRole("button", { name: "Edit" }).first().click();
  await page.waitForLoadState("networkidle");
  await page.screenshot({ path: "screenshots/update-page.png", fullPage: false });

  await browser.close();
}

captureScreenshots().catch(async (error) => {
  console.error(error);
  process.exit(1);
});
