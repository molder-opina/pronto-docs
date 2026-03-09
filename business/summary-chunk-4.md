
# Summary of Extracted Rules - Chunk 4

This document summarizes business rules, technical rules, security rules, and workflows extracted from the files listed in `business/pronto-docs-checklist-chunk-4.md`.

## System-Wide / Developer Experience Rules

-   **Technical Rule:** The `create_app()` function, when `PRONTO_ROUTES_ONLY=1` is set, should only register routes and blueprints. Side-effects (DB init, env validation, CORS, etc.) must be deferred to a separate `init_runtime(app)` function, executed only when `PRONTO_ROUTES_ONLY` is not `1`. This ensures deterministic and efficient route introspection for development and CI/CD.
-   **Technical Rule:** There must be a 1:1 correspondence between API endpoints consumed by the frontend and those implemented in the backend. An automated "API parity check" must be implemented in the CI/CD pipeline to enforce this, preventing broken features from reaching production.
-   **Technical Rule:** All image and static assets referenced in the frontend must exist at their specified canonical path (e.g., `/assets/`). Broken links and placeholder issues must be addressed to maintain UI integrity.
-   **Technical Rule:** The application must use consistent and correct paths for all static assets. The canonical prefix is `/assets/`. All references to incorrect paths like `/static/` must be updated, and any hardcoded URLs for assets must be replaced with dynamic and correct paths.
-   **Technical Rule:** All API calls from the `pronto-static` frontend (both employee and customer applications) must use the designated `http.ts` wrapper. Direct use of `fetch` or `axios` for mutating operations is prohibited to ensure consistent handling of authentication, CSRF tokens, and errors.
-   **Technical Rule:** Do not place API calls (e.g., `fetch`) directly within HTML templates (inline JavaScript). All API communication must be centralized in dedicated JavaScript/TypeScript modules.
-   **Technical Rule:** For consistency in handling authenticated sessions, all `fetch` requests across the application should use `credentials: 'include'` rather than `'same-origin'`.
-   **Technical Rule:** The application's global configuration object (`window.APP_CONFIG`) must have a robust and predictable initialization process. It should be treated as stable after initial setup, and patching it via inline scripts in HTML templates is prohibited.
-   **Technical Rule:** Avoid using inline `<style>` blocks in HTML templates to fix styling issues. All CSS should reside in dedicated `.css` files.
-   **Technical Rule:** The `!important` directive in CSS should be avoided. Styling conflicts must be resolved by improving CSS specificity, structure, and order, rather than by force-overriding rules.
-   **Technical Rule:** The `deriveSessionsFromOrders` function should return a data structure consistent with its usage (e.g., converting an array to a Map if a Map is expected). Data transformations must be explicit to avoid runtime errors.
-   **Business Rule:** The user interface should be visually complete and free of broken elements. Placeholders should be used when specific content (like an icon) is not yet available.
-   **Business Rule (Implicit):** The application's core functionalities, such as customer management, table management, reporting, employee management, and session management, must be fully functional and supported by corresponding backend APIs.
-   **Workflow:** Development and CI/CD processes rely on deterministic application initialization, free from side-effects during route introspection.

## Authentication and Access Control Rules

-   **Security Rule:** A user authenticated in the `/system` context cannot automatically gain access to other contexts (e.g., waiter, chef). Each context requires its own separate and explicit login. Re-authentication/handoff functionality from the `/system` scope is prohibited.
-   **Security Rule:** All system login handoffs must use the `POST /system/login` endpoint. The `/system/system_login` endpoint is deprecated and should not exist. All authentication handoffs must be consolidated into the single, correct `/system/login` route.
-   **Security Rule:** The highest privilege administrative role in the system is named "system". All code, documentation, tests, and scripts must use this canonical name, replacing legacy names like "super admin".
-   **Security Rule:** The `http.ts` wrapper (for both employee and customer frontends) must automatically handle CSRF tokens and authentication (401/403 errors) for all API requests.
-   **Security Rule:** Customer-facing applications (`pronto-client`) are strictly prohibited from performing any table management operations (updating or deleting tables). Corresponding 'dummy' API endpoints and any legacy frontend calls must be removed.
-   **Security Rule:** Personally Identifiable Information (PII) must not be stored in plaintext or exposed through serializers.
-   **Security Rule:** The application must use robust authentication and authorization mechanisms to protect data and ensure only authorized actions are performed.

## Workflow Rules

-   **Workflow:** When navigating from the system administration console to another console (e.g., waiter dashboard), a user must be prompted to log in with credentials specific to that context.
-   **Workflow:** An employee uses the "Customers Manager" in the employee application to view and manage customer data, requiring a functional backend API.
-   **Workflow:** When a cashier opens their dashboard, the `SessionsManager` loads pending sessions, which involves deriving session information from orders.
-   **Workflow:** When viewing menu items in the "Menu Management" section of the employee dashboard, if an item lacks an image, a placeholder image should be displayed.
-   **Workflow:** Any action a customer takes that requires communicating with the backend (e.g., placing an order, viewing the menu, calling a waiter) must be routed through the central API wrapper.
-   **Workflow:** When the customer-facing application needs to load initial data (like the list of tables), this logic should be handled by the main application's JavaScript code, not by scripts embedded directly in the HTML.
-   **Workflow:** Employees managing branding assets (upload, generate) must use the centralized API wrapper for these operations.
-   **Workflow:** The application's startup process involves initializing a global configuration object (`APP_CONFIG`) with essential values, and this process must be reliable.
-   **Workflow:** The employee application must correctly handle different workflow statuses, updating legacy status handling to use the new, standardized system.
