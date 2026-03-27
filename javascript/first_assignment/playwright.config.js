const { defineConfig } = require("@playwright/test");

module.exports = defineConfig({
  testDir: "./tests",
  timeout: 30 * 1000,
  use: {
    baseURL: process.env.PLAYWRIGHT_BASE_URL || "http://127.0.0.1:3000",
    headless: true
  },
  webServer: {
    command: "npm start",
    url: process.env.PLAYWRIGHT_BASE_URL || "http://127.0.0.1:3000",
    reuseExistingServer: true,
    timeout: 120 * 1000
  }
});
