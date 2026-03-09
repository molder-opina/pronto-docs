# Summary of Extracted Rules and Workflows (Chunk 2)

This document summarizes the key business, technical, and security rules extracted from the audit and resolution files from `business/pronto-docs-checklist-chunk-2.md`.

## Business Rules & Workflows

*   **Order Management:**
    *   The kitchen board should display pending orders by filtering for `status=queued` from the main `/api/orders` endpoint.
    *   Paid sessions are determined from orders with `workflow_status=paid`.
    *   Closed sessions are determined from orders with `workflow_status` as `paid` or `cancelled`.
    *   The waiter board should derive recently paid sessions from `/api/orders` with `workflow_status=paid` and a UI-side date filter.
    *   Cashiers view closed sessions by grouping orders from `/api/orders` by `session_id` where `workflow_status` is `paid` or `cancelled`.
*   **Roles & Permissions:**
    *   The canonical roles are: `waiter`, `chef`, `cashier`, `admin`, `system`.
    *   Non-canonical roles like `cook`, `kitchen`, `manager`, `supervisor`, `guest`, and `staff` should not be used in the UI or for permission checks.
    *   The `system` role should be used for system-level operations.
*   **Notifications:**
    *   Administrative calls should be registered via the `/api/notifications/admin/call` endpoint.
    *   The waiter call panel should use `/api/notifications/waiter/pending` to fetch pending calls and `/api/notifications/waiter/confirm/{callId}` to confirm them.
*   **Session Management:**
    *   The client session should only contain `dining_session_id` and `customer_ref`. No PII should be stored in the Flask session.
    *   PII (customer name, email, phone) should be stored in Redis with a TTL.

## Technical Rules

*   **API Endpoints:**
    *   All API calls from the frontend should have corresponding backend implementations. Missing endpoints for features like real-time notifications, admin calls, waiter board, kitchen board actions, and session management must be implemented.
    *   Avoid using legacy endpoints. UI should be updated to use the current, consolidated endpoints (e.g., using `/api/orders` with filters instead of specialized session status endpoints).
    *   The `/api/orders` endpoint in the employees' BFF is the source of truth for order information.
*   **Static Assets:**
    *   All static assets (images, CSS, JS) must be served from `pronto-static`.
    *   Frontend applications should not use hardcoded `/static/*` paths. They should use the `static_host_url` and the appropriate asset path variables (`assets_images`, `assets_js`, etc.).
    *   Placeholders for images (like `placeholder-food.png`) must exist in the `pronto-static` assets.
*   **Frontend Development:**
    *   Avoid inline JavaScript. All frontend logic should be encapsulated in Vue components.
    *   Use the provided `useFetch` wrapper for API calls and ensure `credentials: 'include'` is set.
    *   Do not hardcode hostnames or ports in the frontend code. Use environment variables.
*   **Backend Development:**
    *   Do not duplicate constants. Shared constants (like `_NON_TERMINAL` order statuses) should be defined in `pronto-libs`.
    *   Do not hardcode passwords (like the kiosk password). Use environment variables.
    *   Use the `OrderStatusWorkflow` from `pronto_shared` for all order state transitions.

## Security Rules

*   **Authentication & Authorization:**
    *   JWT (JSON Web Tokens) should be used for authentication.
    *   CSRF protection should be implemented for all state-mutating operations.
    *   The `/system_login` handoff endpoint must only be available under the `/system` scope.
*   **Data Privacy:**
    *   PII should not be included in JWT payloads.
    *   Do not store PII in the client-side Flask session. Use Redis with a TTL for temporary PII storage.
*   **Dependencies & Versions:**
    *   Use `postgres:16-alpine` for the database.
    *   The required Python version is 3.11+.
