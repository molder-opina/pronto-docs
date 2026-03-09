
## Employee Application Prompts (Chunk 3)

### Business Rules & Workflows

1.  **Order Workflow Actions:**
    *   **Prompt:** "Document the state transition diagram for an order from a waiter's and chef's perspective. The following actions must be available and trigger the correct status change:
        *   Waiter: `accept` (queued -> preparing), `deliver` (ready -> delivered)
        *   Chef: `kitchen/start` (queued -> preparing), `kitchen/ready` (preparing -> ready)
        *   All roles must be able to `cancel` or `modify` an order under specific conditions."

2.  **Table Transfer Workflow:**
    *   **Prompt:** "Create a sequence diagram for the 'Table Transfer' process.
        1. Waiter A sends a transfer request for a table to Waiter B.
        2. Waiter B receives a notification and can either `accept` or `reject` the transfer.
        3. If accepted, the table and its active orders are reassigned to Waiter B.
        4. If rejected, Waiter A is notified and retains ownership."

3.  **Payment & Session Closing Workflow:**
    *   **Prompt:** "Generate a user guide for the cashier role explaining how to process payments and close sessions. The guide must cover:
        *   Fetching session details and the associated ticket.
        *   Applying payments (`/pay`, `/confirm-payment`).
        *   Adding a tip (`/tip`).
        *   Closing the session (`/close`).
        *   Resending a receipt (`/resend`)."

4.  **Paid Order Filtering:**
    *   **Prompt:** "Design the logic for the 'Paid Recent' filter. When a user selects a time window (e.g., 'last 15 minutes'), the query **must** exclusively filter for orders with `status='paid'` and `paid_at` within that window, overriding any other `status` filters that may have been selected."

### Technical Rules

1.  **API Endpoint Implementation:**
    *   **Prompt:** "Implement the following missing backend endpoints in the `pronto-employees` BFF to support the UI. Ensure all endpoints use the standard `success_response` and `error_response` envelopes and are protected by the appropriate role-based `ScopeGuard`.
        *   `GET /api/sessions/all`
        *   `GET /api/sessions/<id>` and all sub-routes (`/ticket`, `/pay`, etc.)
        *   `POST /api/orders/<id>/[accept|kitchen/start|kitchen/ready|deliver]`
        *   `GET /api/admin/shortcuts` (and other CRUD endpoints)
        *   `GET /api/analytics/*` (with mock/zero-value data initially)
        *   `GET /api/stats/public`"

2.  **API Response Consistency:**
    *   **Prompt:** "Refactor the `GET /api/orders` endpoint in `pronto-employees`. All error responses, including those for invalid query parameters (e.g., `paid_recent_minutes`), must be wrapped in the canonical `error_response` JSON structure, not returned as a simple `{'error': '...'}` object."

3.  **Frontend HTTP Wrapper:**
    *   **Prompt:** "Correct the frontend HTTP wrapper (`core/http.ts`) in `pronto-static` for the employees app.
        *   Remove the logic that incorrectly rewrites `/api/*` calls to `/{scope}/api/*`. All API calls must go to the `/api/*` path directly.
        *   Ensure all `fetch` requests use `credentials: 'include'` to properly handle JWT cookies, especially in cross-domain scenarios.
        *   The `requestJSON` function must maintain backward compatibility by returning both the flattened payload and the original `response.data` structure."

4.  **Table Transfer Service Integration:**
    *   **Prompt:** "Fix the integration bug in the `table_assignments.py` route. The calls to `accept_transfer_request` and `reject_transfer_request` must match the function signatures defined in the shared `waiter_table_assignment_service`, passing the `transfer_request_id` and `waiter_id` in the correct order."

### Security Rules

1.  **CSRF Protection on MUTATE Operations:**
    *   **Prompt:** "Secure the 'Update User Preferences' feature. The `PUT` request to `/api/employees/me/preferences` must include the `X-CSRFToken` header. Update the corresponding template-side JavaScript to fetch the token and include it in the request."

2.  **Order Payment Integrity:**
    *   **Prompt:** "Implement a guardrail in the order service. A transition to the `paid` status for any order must be blocked (return HTTP 409 Conflict) if other orders within the same `session_id` are still in a non-terminal state (e.g., `new`, `queued`, `preparing`). This ensures a session is fully resolved before payment is finalized."

3.  **Order Paid Timestamp Invariant:**
    *   **Prompt:** "Strengthen the `Order.mark_status` model method. Whenever an order's status is set to `paid`, the `paid_at` timestamp **must** be set to the current time if it is not already set. This enforces the invariant that `workflow_status='paid'` implies `paid_at IS NOT NULL`."
