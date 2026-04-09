const { chromium } = require('playwright');
const path = require('path');

const BASE_URL = 'http://host.docker.internal:8080';
const OUTPUT_DIR = '/screenshots';

async function takeScreenshots() {
  const browser = await chromium.launch({ args: ['--no-sandbox', '--disable-dev-shm-usage'] });
  const page = await browser.newPage();
  await page.setViewportSize({ width: 1280, height: 800 });

  console.log('Starting screenshots...');

  // 1. Home page
  await page.goto(`${BASE_URL}/`);
  await page.waitForLoadState('networkidle');
  await page.screenshot({ path: `${OUTPUT_DIR}/01-home.png`, fullPage: true });
  console.log('1. Home page captured');

  // 2. Movies list
  await page.goto(`${BASE_URL}/Movie`);
  await page.waitForLoadState('networkidle');
  await page.screenshot({ path: `${OUTPUT_DIR}/02-movies-list.png`, fullPage: true });
  console.log('2. Movies list captured');

  // 3. Create movie page
  await page.goto(`${BASE_URL}/Movie/Create`);
  await page.waitForLoadState('networkidle');
  await page.screenshot({ path: `${OUTPUT_DIR}/03-create-form.png`, fullPage: true });
  console.log('3. Create form captured');

  // 4. Fill in create form
  await page.fill('input[name="Title"]', 'Interstellar');
  await page.fill('input[name="Director"]', 'Christopher Nolan');
  await page.fill('input[name="Genre"]', 'Sci-Fi');
  await page.fill('input[name="Year"]', '2014');
  await page.fill('input[name="Rating"]', '8.6');
  await page.screenshot({ path: `${OUTPUT_DIR}/04-create-filled.png`, fullPage: true });
  console.log('4. Create form filled captured');

  await page.click('button[type="submit"]');
  await page.waitForLoadState('networkidle');
  await page.screenshot({ path: `${OUTPUT_DIR}/05-after-create.png`, fullPage: true });
  console.log('5. After create captured');

  // 5. Edit page (movie id=1)
  await page.goto(`${BASE_URL}/Movie/Edit/1`);
  await page.waitForLoadState('networkidle');
  await page.screenshot({ path: `${OUTPUT_DIR}/06-edit-form.png`, fullPage: true });
  console.log('6. Edit form captured');

  // 6. Delete confirmation page (movie id=2)
  await page.goto(`${BASE_URL}/Movie/Delete/2`);
  await page.waitForLoadState('networkidle');
  await page.screenshot({ path: `${OUTPUT_DIR}/07-delete-confirm.png`, fullPage: true });
  console.log('7. Delete confirmation captured');

  // 7. Validation errors - submit empty form
  await page.goto(`${BASE_URL}/Movie/Create`);
  await page.waitForLoadState('networkidle');
  await page.click('button[type="submit"]');
  await page.waitForLoadState('networkidle');
  await page.screenshot({ path: `${OUTPUT_DIR}/08-validation-errors.png`, fullPage: true });
  console.log('8. Validation errors captured');

  // 8. Swagger UI
  await page.goto(`${BASE_URL}/swagger`);
  await page.waitForLoadState('networkidle');
  await page.screenshot({ path: `${OUTPUT_DIR}/09-swagger.png`, fullPage: true });
  console.log('9. Swagger UI captured');

  await browser.close();
  console.log(`\nAll screenshots saved to ${OUTPUT_DIR}`);
}

takeScreenshots().catch(err => {
  console.error('Error:', err);
  process.exit(1);
});
