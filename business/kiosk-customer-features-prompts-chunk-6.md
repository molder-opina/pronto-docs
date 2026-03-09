
# Kiosk & Customer Feature Prompts (Chunk 6)

This file contains prompts for implementing kiosk functionality and improving other customer-facing features.

## Kiosk Implementation

**Prompt:**
"Implement a Kiosk mode for the application. This involves creating new endpoints for both the customer-facing kiosk interface and the admin management panel.

**Frontend (`pronto-client`):**
- Create a `GET /kiosk/<location>` endpoint that renders a welcome screen.
- Create a `POST /kiosk/<location>/start` endpoint that performs an auto-login for a dedicated kiosk account. This endpoint must be secured by a secret (`PRONTO_KIOSK_SECRET`) in production.

**Backend API (`pronto-employees`):**
- Create API endpoints for administrators to manage kiosk accounts:
    - `GET /api/customers/kiosks`: List all kiosk accounts.
    - `POST /api/customers/kiosks`: Create a new kiosk account for a given location.
    - `DELETE /api/customers/kiosks/<id>`: Delete a kiosk account.
- Ensure all customer-related services can filter by `kind='kiosk'`.
"

**Acceptance Criteria:**
- A user can navigate to `/kiosk/lobby` and see a welcome page.
- Sending a POST to `/kiosk/lobby/start` logs in the kiosk.
- An admin can create, list, and delete kiosk accounts via the employee API.
- Customer search in the admin panel can be filtered to show only kiosk accounts.

## Customer Feature Enhancements

**Prompt:**
"Address the authentication and authorization gaps in the following customer-facing features:

1.  **Notifications:** The `/api/notifications` endpoint in `pronto-client` incorrectly uses employee JWT authentication. Refactor it to use the customer's `customer_ref` from the session. Additionally, ensure the endpoint for marking a notification as read (`POST /api/notifications/<id>/read`) verifies that the notification belongs to the authenticated customer.

2.  **Split Bills:** The `split_bills.py` endpoints have no authentication. Secure all endpoints by requiring a valid `customer_ref` and ensuring that the `dining_session_id` associated with the customer matches the bill they are trying to split or pay.

3.  **Waiter Calls:** The `/api/call-waiter` endpoint is open and can be spammed. Secure it by requiring a valid `dining_session_id` in the user's session that corresponds to the `table_number` they are calling from. Implement rate limiting on this feature to prevent abuse.
"

**Acceptance Criteria:**
- `/api/notifications` is only accessible to authenticated customers and shows their own notifications.
- Users cannot split or pay bills for sessions that are not their own.
- The "Call Waiter" button only works for customers with an active dining session at that table.
- Calling the waiter repeatedly from the same session is rate-limited.
