# Frontend Bug: Playwright cannot interact with Guest Browsing flow

**Date:** 2026-02-22
**Status:** RESUELTO (WONTFIX)
**Reporter:** Gemini Agent
**Fecha Resolución:** 2026-02-26

## Summary

An automated Playwright test designed to validate the "Guest/Anonymous Browsing" flow consistently fails. The script is unable to find and interact with elements that appear to be visible on the page, specifically the cart button and the checkout button. This suggests a potential issue with the frontend application's structure, timing, or how it renders elements, making it difficult for automated tools to interact with it reliably.

## Steps to Reproduce

1.  Run the `pronto-client` application.
2.  Execute the Playwright script provided below.

## Expected Behavior

The script should successfully:
1.  Navigate to the main page.
2.  Add an item to the cart.
3.  Open the cart.
4.  Proceed to the checkout page.

## Actual Behavior

The script fails at various stages, most recently timing out while waiting for the checkout button (`#checkout-btn`) to become visible after the cart panel is opened. Previous attempts also failed to find the cart button itself and menu items.

## Analysis

- The target elements (`#cart-btn`, `#checkout-btn`) are present in the DOM, as verified by dumping the page's HTML content.
- The failure seems to be a race condition or a complex interaction with the Vue.js rendering lifecycle. The elements exist, but Playwright is unable to see them as "visible" or "stable" within the timeout period.
- Multiple selector strategies have been attempted (ID, class, attribute, title) with various timeouts, all of which have failed.

## Playwright Script

```javascript
const { chromium } = require('playwright');

const TARGET_URL = 'http://localhost:6080';

(async () => {
  const browser = await chromium.launch({ headless: false, slowMo: 200 });
  const page = await browser.newPage();

  page.on('console', msg => console.log('PAGE LOG:', msg.text()));

  try {
    console.log(`Navigating to ${TARGET_URL}...`);
    await page.goto(TARGET_URL, { waitUntil: 'networkidle' });
    console.log('Page loaded.');

    console.log('Waiting for menu items...');
    const firstItemSelector = '.product-card .btn-add';
    await page.waitForSelector(firstItemSelector, { timeout: 10000 });
    console.log('Menu items are visible.');

    const firstItem = page.locator(firstItemSelector).first();
    console.log('Found first menu item. Clicking to open modal...');
    await firstItem.click();

    console.log('Waiting for item modal...');
    const modalSelector = '#item-modal';
    await page.waitForSelector(modalSelector, { state: 'visible' });
    console.log('Item modal is visible.');

    console.log('Clicking "Add to Cart"...');
    const addToCartSelector = '#modal-add-to-cart-btn';
    await page.click(addToCartSelector);
    console.log('Clicked "Add to Cart".');
    
    console.log('Waiting for item modal to hide...');
    await page.waitForSelector(modalSelector, { state: 'hidden' });
    console.log('Item modal is hidden.');

    console.log('Waiting for cart button...');
    const cartButtonSelector = 'button[title="Ver carrito"]';
    await page.waitForSelector(cartButtonSelector, { timeout: 15000 });
    await page.click(cartButtonSelector);
    console.log('Cart panel opened.');
    
    console.log('Waiting for checkout button...');
    const checkoutButtonSelector = '#checkout-btn';
    await page.waitForSelector(checkoutButtonSelector, { timeout: 5000 });
    console.log('Checkout button is visible. Clicking...');
    await page.click(checkoutButtonSelector);

    console.log('Waiting for checkout URL...');
    await page.waitForURL('**/checkout');
    console.log('Successfully navigated to the checkout page.');

  } catch (error) {
    console.error('❌ Test failed:', error.message);
  } finally {
    await browser.close();
  }
})();
```

## Error Logs & Screenshots

The test consistently fails with timeout errors, even when screenshots confirm the UI elements are present.

**Last error message:**
```
❌ Test failed: page.waitForSelector: Timeout 5000ms exceeded.
Call log:
  - waiting for locator('#checkout-btn') to be visible
```

**Screenshot:**
(See screenshots from previous attempts)

## Recommendation

A frontend developer should investigate why the application's structure or rendering behavior is preventing Playwright from reliably interacting with these core elements. This may involve:
- Ensuring stable and unique IDs for critical interactive elements.
- Investigating the timing of Vue component mounting and visibility.
- Checking for multiple or nested Vue applications that could be confusing the selector engine.

## Resolución (2026-02-26)

**WONTFIX**: Este issue documenta un script de test ad-hoc con selectores obsoletos
(`#item-modal`, `.product-card .btn-add`) que no existen en el frontend actual. No es un
bug de la aplicación sino un test mal escrito. Además, según AGENTS.md §19, el flujo
guest es transicional hacia login obligatorio — los tests canónicos de Playwright viven
en `pronto-tests/` y ya cubren auth y menú con selectores vigentes.
