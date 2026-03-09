# Prompts for Employee Application (Chunk 2)

This file contains prompts for generating code and documentation for the Pronto Employee Application, based on the findings from the chunk 2 audit.

## Waiter Table Management

*   **Prompt:** "The waiter's dashboard is not showing the menu. The `_menu_waiter.html` include is missing from the `dashboard.html` template. Add the include to the template to display the menu."
*   **Prompt:** "The waiter call panel is not working. The frontend is making calls to `/api/notifications/waiter/pending` and `/api/notifications/waiter/confirm/{callId}`, but the endpoints are not implemented in `pronto-employees`. Implement these endpoints in the `pronto-employees` backend."
*   **Prompt:** "The waiter board is trying to get recently paid sessions from a legacy endpoint. Modify the waiter board to derive recently paid sessions from the `/api/orders` endpoint by filtering for orders with `workflow_status=paid` and applying a date filter on the UI."
*   **Prompt:** "The UI is using the non-canonical role 'supervisor' for the waiter's help call feature. Refactor the UI and backend event names (e.g., `supervisor_call`) to use a canonical role like `admin` or `system`."

## Kitchen Order Management

*   **Prompt:** "The kitchen board is failing to load pending orders because the endpoint `/api/orders/kitchen/pending` is missing. Update the `kitchen-board.ts` module to fetch pending orders from the `/api/orders` endpoint with the filter `status=queued`."
*   **Prompt:** "The kitchen board is using the non-canonical role 'cook'. Update the permission checks in `kitchen-board.ts` to use the canonical role `chef`."
*   **Prompt:** "The kitchen board has actions to advance the order status (e.g., 'start', 'ready', 'deliver') that are calling non-existent endpoints. Implement the endpoints `/api/orders/${id}/kitchen/start`, `/api/orders/${id}/kitchen/ready`, and `/api/orders/${id}/deliver` in the `pronto-employees` backend."

## Admin & System Management

*   **Prompt:** "The employee management UI allows the selection of non-canonical roles like 'supervisor'. Remove these non-canonical roles from the UI in `EmployeesManager.vue` and the corresponding templates."
*   **Prompt:** "The employee login page is calling `/api/stats/public`, which does not exist. Remove this call from the `login.html` template in `pronto-employees`."
*   **Prompt:** "The admin shortcuts manager is not working because the `/api/admin/shortcuts` endpoint is not implemented. Implement the CRUD endpoints for admin shortcuts in the `pronto-employees` backend."
*   **Prompt:** "The system login handoff endpoint (`/system_login`) is exposed on non-system blueprints (admin, chef, cashier). Remove these endpoints and centralize the handoff logic under the `/system` blueprint."
*   **Prompt:** "A decorator is using the non-canonical role `system_admin`. Replace this with the canonical `system` role in `pronto-employees/decorators.py`."

## General

*   **Prompt:** "The analytics dashboard is not loading data because the `/api/analytics/*` endpoints are not implemented. Implement the necessary analytics endpoints in the `pronto-employees` backend."
*   **Prompt:** "The branding management page has inline JavaScript. Refactor the `BrandingManager` class from `branding.html` into a Vue component in `pronto-static`."
*   **Prompt:** "The branding logo is not being displayed correctly. The frontend is trying to load it as a static file, but the backend serves it from the `/api/branding/logo` endpoint. Update the frontend to use the correct endpoint to display the logo."
