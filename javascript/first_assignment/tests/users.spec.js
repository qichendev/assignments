const { test, expect } = require("@playwright/test");

function uniqueEmail(prefix) {
  return `${prefix}-${Date.now()}@example.com`;
}

test.describe("User CRUD pages", () => {
  test("renders the list and create page", async ({ page }) => {
    await page.goto("/users");
    await expect(page.getByRole("heading", { name: "User List" })).toBeVisible();
    await expect(page.getByRole("main").getByRole("link", { name: "Add User" })).toBeVisible();

    await page.goto("/users/new");
    await expect(page.getByRole("heading", { name: "Add User" })).toBeVisible();
    await expect(page.getByLabel("First Name *")).toBeVisible();
  });

  test("adds, updates, and deletes a user", async ({ page }) => {
    const createEmail = uniqueEmail("create");
    const updatedEmail = uniqueEmail("update");

    await page.goto("/users/new");
    await page.getByLabel("First Name *").fill("Taylor");
    await page.getByLabel("Last Name *").fill("Jordan");
    await page.getByLabel("Email *").fill(createEmail);
    await page.getByLabel("City").fill("Toronto");
    await page.getByLabel("Country").fill("Canada");
    await page.getByRole("button", { name: "Create User" }).click();

    await expect(page).toHaveURL(/\/users/);
    await expect(page.getByText("User created successfully.")).toBeVisible();
    await expect(page.getByText(createEmail)).toBeVisible();

    await page.getByRole("link", { name: "Edit" }).first().click();
    await expect(page.getByRole("heading", { name: "Edit User" })).toBeVisible();

    await page.getByLabel("City").fill("Montreal");
    await page.getByLabel("Email *").fill(updatedEmail);
    await page.getByRole("button", { name: "Save Changes" }).click();

    await expect(page.getByText("User updated successfully.")).toBeVisible();
    await expect(page.getByLabel("City")).toHaveValue("Montreal");
    await expect(page.getByLabel("Email *")).toHaveValue(updatedEmail);

    page.once("dialog", (dialog) => dialog.accept());
    await page.getByRole("button", { name: "Delete User" }).click();

    await expect(page).toHaveURL(/\/users/);
    await expect(page.getByText("User deleted successfully.")).toBeVisible();
    await expect(page.getByText(updatedEmail)).not.toBeVisible();
  });
});
