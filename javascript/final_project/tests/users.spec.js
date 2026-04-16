const { test, expect } = require("@playwright/test");

function uniqueEmail(prefix) {
  return `${prefix}-${Date.now()}@example.com`;
}

async function signIn(page) {
  await page.goto("/");
  await page.getByRole("button", { name: "Sign In" }).click();
  await expect(page.getByRole("heading", { name: "Directory Table" })).toBeVisible();
}

test.describe("React MERN user manager", () => {
  test("renders login, table, and add pages", async ({ page }) => {
    await page.goto("/");
    await expect(page.getByRole("heading", { name: "Qi Chen User Directory" })).toBeVisible();

    await signIn(page);
    await page.getByRole("button", { name: "Add" }).click();

    await expect(page.getByRole("heading", { name: "Add User" })).toBeVisible();
    await expect(page.getByLabel("First name")).toBeVisible();
    await expect(page.getByLabel("Email")).toBeVisible();
  });

  test("adds, updates, and deletes a user through the React UI", async ({ page }) => {
    const createEmail = uniqueEmail("create");
    const updatedEmail = uniqueEmail("update");

    await signIn(page);
    await page.getByRole("button", { name: "Add" }).click();

    await page.getByLabel("First name").fill("Taylor");
    await page.getByLabel("Last name").fill("Jordan");
    await page.getByLabel("Email").fill(createEmail);
    await page.getByLabel("City").fill("Toronto");
    await page.getByLabel("Country").fill("Canada");
    await page.getByRole("button", { name: "Create User" }).click();

    await expect(page.getByText("User created successfully.")).toBeVisible();
    await expect(page.getByText(createEmail)).toBeVisible();

    await page.getByRole("button", { name: "Edit" }).first().click();
    await expect(page.getByRole("heading", { name: "Update User" })).toBeVisible();

    await page.getByLabel("City").fill("Montreal");
    await page.getByLabel("Email").fill(updatedEmail);
    await page.getByRole("button", { name: "Save Changes" }).click();

    await expect(page.getByText("User updated successfully.")).toBeVisible();
    await expect(page.getByText(updatedEmail)).toBeVisible();

    await page.getByRole("button", { name: "Edit" }).first().click();
    await page.getByRole("button", { name: /Delete/ }).click();

    await expect(page.getByText("User deleted successfully.")).toBeVisible();
    await expect(page.getByText(updatedEmail)).not.toBeVisible();
  });
});
