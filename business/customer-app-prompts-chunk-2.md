# Prompts for Customer Application (Chunk 2)

This file contains prompts for generating code and documentation for the Pronto Customer Application, based on the findings from the chunk 2 audit.

## Customer Ordering

*   **Prompt:** "Generate the frontend code for the customer to download a PDF of their ticket. The code should make a `fetch` call to `/api/sessions/<session-id>/ticket.pdf`. Ensure that the frontend gracefully handles the case where the endpoint returns a 404 error."
*   **Prompt:** "Create the backend endpoint in `pronto-client` to handle the PDF ticket download at `/api/sessions/<session-id>/ticket.pdf`. This endpoint should retrieve the session details and generate a PDF ticket."
*   **Prompt:** "The customer's profile picture is not loading correctly. The application is trying to load it from `http://localhost:9088` in production if the `static_host_url` is not available. Modify the `client-profile.ts` file to remove the hardcoded fallback and instead log an error if `static_host_url` is missing."
*   **Prompt:** "The debug panel for the customer application has a mismatch in the promotions endpoint. It calls `/api/promotions` but the backend exposes `/api/promotions/active`. Update the debug panel to call the correct endpoint."
*   **Prompt:** "The customer session is storing PII (name, email, phone). Refactor the session management in `pronto-client` to store PII in Redis with a TTL, and only store a `customer_ref` UUID in the Flask session. Ensure that the `ALLOWED_SESSION_KEYS` are enforced."

## Menu Viewing

*   **Prompt:** "The images for some menu items are not loading, resulting in 404 errors. The cause is an incorrect image name reference in the database seed. Correct the seed file to use the timestamped filenames for the images (e.g., `pollo_parrilla_1769982743280.png`)."
*   **Prompt:** "The product detail modal in the customer app is referencing a placeholder image `/assets/images/placeholder-food.png` that does not exist. Create this placeholder image in `pronto-static`."

## General

*   **Prompt:** "The `base.html` template in `pronto-client` is using hardcoded URLs for assets. Refactor the template to use the `assets_images`, `assets_js_clients`, and `assets_js_shared` context variables instead of `static_host_url`."
*   **Prompt:** "There is inline JavaScript in the `base.html` template of `pronto-client`. Refactor this JavaScript into a dedicated Vue component in `pronto-static`."
