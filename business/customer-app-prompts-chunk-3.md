
## Customer Application Prompts (Chunk 3)

### Business Rules & Workflows

1.  **Active Promotions Display:**
    *   **Prompt:** "Create a user story for displaying active promotions to a customer. The application should fetch a list of currently active promotions and display them in a dedicated section of the UI. The user should be able to view details for each promotion."

2.  **Table & Area Information:**
    *   **Prompt:** "Develop a feature that allows a customer to view information about restaurant tables and areas. The app needs to display a list of available areas and the tables within them. The user should also be able to view a QR code for a specific table."

3.  **Session Ticket Download:**
    *   **Prompt:** "Implement a 'Download Ticket' feature for customers. In the 'Active Orders' view, a customer must be able to click a button to download a PDF representation of their current session ticket (bill)."

### Technical Rules

1.  **API Endpoint Implementation (Client BFF):**
    *   **Prompt:** "Implement the following missing backend endpoints in the `pronto-client` BFF to support the UI. Ensure they are public-facing or properly authenticated if necessary.
        *   `GET /api/promotions/active` (aliased also at `GET /api/promotions` for the debug panel).
        *   `GET /api/areas`
        *   `GET /api/tables/<id>` and `GET /api/tables/<id>/qr`
        *   `GET /api/sessions/<id>/ticket.pdf`"

2.  **API Blueprint Registration:**
    *   **Prompt:** "Fix the critical startup error in `pronto-api`. The main application factory (`create_app`) must register the `api_bp` blueprint with the URL prefix `/api`. This is required to expose all notification and realtime endpoints (e.g., `/api/realtime/notifications`) to the frontend applications."

3.  **Realtime Event Stream Stability:**
    *   **Prompt:** "Stabilize the `/api/realtime/orders` endpoint. The `read_events_from_stream` function is failing due to a `NameError` for the `REDIS_EVENTS_STREAM` constant. Define and centralize this constant so it's correctly resolved at runtime, preventing the HTTP 500 error."

### Security Rules

1.  **Static Asset Host URL:**
    *   **Prompt:** "Harden the client-side code that resolves static asset URLs. Remove the hardcoded fallback to `http://localhost:9088`. If `APP_CONFIG.static_host_url` is not defined, the path should resolve as a relative URL (e.g., `/assets/default-avatar.png`) to prevent requests to `localhost` in production environments."

2.  **Frontend HTTP Credentials Policy:**
    *   **Prompt:** "Standardize the credentials policy in the client application's HTTP wrapper (`core/http.ts`). All `fetch` requests to the backend API must use the `credentials: 'include'` option to ensure that authentication cookies are sent correctly across all deployment scenarios (including those with different subdomains for frontend and backend)."
