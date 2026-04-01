const path = require("path");
const { chromium } = require("playwright");

async function run() {
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext({
    viewport: { width: 1440, height: 900 }
  });
  const page = await context.newPage();

  const baseUrl = process.env.APP_BASE_URL || "http://127.0.0.1:3000";
  const screenshotsDir = path.resolve(__dirname, "../../screenshots");
  const uniqueSuffix = Date.now();
  const sampleUser = {
    firstName: "Qi",
    lastName: "Chen",
    email: `qi.chen.${uniqueSuffix}@example.com`,
    phoneNumber: "416-555-0188",
    dateOfBirth: "2000-05-12",
    country: "Canada",
    address1: "123 King Street West",
    address2: "Unit 804",
    city: "Toronto",
    postalCode: "M5H 1J9",
    userNotes: "Assignment screenshot sample user for the CRUD application."
  };

  await page.goto(`${baseUrl}/users/new`, { waitUntil: "networkidle" });
  await page.getByLabel("First Name *").fill(sampleUser.firstName);
  await page.getByLabel("Last Name *").fill(sampleUser.lastName);
  await page.getByLabel("Email *").fill(sampleUser.email);
  await page.getByLabel("Phone Number").fill(sampleUser.phoneNumber);
  await page.getByLabel("Date of Birth").fill(sampleUser.dateOfBirth);
  await page.getByLabel("Country").fill(sampleUser.country);
  await page.getByLabel("Address 1").fill(sampleUser.address1);
  await page.getByLabel("Address 2").fill(sampleUser.address2);
  await page.getByLabel("City").fill(sampleUser.city);
  await page.getByLabel("Postal Code").fill(sampleUser.postalCode);
  await page.getByLabel("User Notes").fill(sampleUser.userNotes);

  await page.screenshot({
    path: path.join(screenshotsDir, "create-page.png")
  });

  await page.getByRole("button", { name: "Create User" }).click();
  await page.waitForURL(`${baseUrl}/users*`);
  await page.waitForLoadState("networkidle");

  await page.screenshot({
    path: path.join(screenshotsDir, "list-page.png")
  });

  await page.getByRole("link", { name: "Edit" }).first().click();
  await page.waitForLoadState("networkidle");

  await page.screenshot({
    path: path.join(screenshotsDir, "edit-page.png")
  });

  await browser.close();
}

run().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
