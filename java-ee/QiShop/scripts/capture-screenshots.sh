#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${QISHOP_BASE_URL:-http://127.0.0.1:8080}"
VIEWPORT="1920,1080"

mkdir -p screenshots

npx --yes playwright screenshot --browser=chromium --viewport-size="$VIEWPORT" "$BASE_URL/products" screenshots/01-products-list.png
npx --yes playwright screenshot --browser=chromium --viewport-size="$VIEWPORT" "$BASE_URL/products/new" screenshots/02-product-form.png
npx --yes playwright screenshot --browser=chromium --viewport-size="$VIEWPORT" "$BASE_URL/products?category=Electronics&maxPrice=50" screenshots/03-products-filtered.png
