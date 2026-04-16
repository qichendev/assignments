const { defineConfig } = require("@playwright/test");

const baseURL = process.env.PLAYWRIGHT_BASE_URL || "http://127.0.0.1:3200";

module.exports = defineConfig({
  testDir: "./tests",
  timeout: 30 * 1000,
  use: {
    baseURL,
    headless: true
  },
  webServer: {
    command: "PORT=3200 npm start",
    url: baseURL,
    reuseExistingServer: true,
    timeout: 120 * 1000
  }
});
