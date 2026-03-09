
# Summary of Rules and Workflows (Chunk 3)

This document summarizes the key business, technical, and security rules extracted from the files in `pronto-docs-checklist-chunk-3.md`.

## 1. Core Architectural & Business Rules

*   **Canonical Roles:** The system must strictly use a defined set of user roles: `waiter`, `chef`, `cashier`, `admin`, `system`. The role `staff` is invalid and must be purged. The `system` role is a singleton for superuser access and not for regular application functions.
*   **No Runtime DDL:** Services **must not** alter the database schema (e.g., `CREATE/ALTER TABLE`) at runtime. All schema changes must be managed via pre-boot scripts (`pronto-init`, `pronto-migrate`).
*   **API Contract Parity:** A CI gate (`pronto-api-parity-check`) is required to ensure frontend API consumption matches the actual backend route implementations, preventing drift.
*   **Order Payment Integrity:** An order cannot be transitioned to `paid` if other orders in the same session are in a non-terminal state. This enforces that a session is fully resolved before payment.
*   **Timestamp Invariants:**
    *   Any order with `workflow_status='paid'` **must** have a non-null `paid_at` timestamp.
    *   Every change in an order's status must be recorded in `OrderStatusHistory` with an accurate `changed_at` timestamp.

## 2. Application-Specific Workflows

*   **Employee Order Actions:** The employee UI must support actions like `accept`, `kitchen/start`, `kitchen/ready`, and `deliver`, which map to specific state transitions in the order workflow.
*   **Table Transfers:** Waiters can request to transfer a table to another waiter. The recipient must be able to `accept` or `reject` the transfer via the UI.
*   **Cashier Payment Flow:** Cashiers must have a complete UI flow to fetch a session's ticket, apply payments, add tips, and close the session.
*   **Customer Ticket Download:** Customers must be able to download a PDF of their ticket from the active orders screen.

## 3. Technical & Implementation Rules

*   **API Endpoints:** A large number of missing API endpoints were identified and required implementation in their respective BFFs (`pronto-client` or `pronto-employees`). This includes routes for:
    *   Sessions (`/api/sessions/*`)
    *   Order actions (`/api/orders/<id>/...`)
    *   Analytics (`/api/analytics/*`)
    *   Admin shortcuts (`/api/admin/shortcuts`)
    *   Promotions, tables, and areas (`/api/promotions`, `/api/areas`, `/api/tables`)
*   **API Response Envelope:** All API endpoints must use the canonical `success_response` and `error_response` JSON envelopes for all responses, including validation errors.
*   **Frontend HTTP Wrappers:**
    *   API calls must **not** be rewritten with a scope prefix (e.g., `/waiter/api/*`).
    *   All `fetch` requests must use `credentials: 'include'` to ensure cookie-based authentication works correctly.
    *   The `requestJSON` function must be backward compatible, providing both flattened and nested (`.data`) access to the response payload.
*   **Database Idempotency:** The `init_db` function must be tolerant of pre-existing indexes and other database objects to prevent startup crashes.
*   **Build & CI Scripts:**
    *   All CI scripts must correctly propagate exit codes to ensure build failures are detected.
    *   Build scripts must use correct paths and service names (e.g., `pronto-static` for frontend builds, `employees` for the Docker service).
*   **Realtime Services:** The Redis stream name (`REDIS_EVENTS_STREAM`) must be correctly defined and accessible to the realtime services to prevent `NameError` crashes.

## 4. Security Rules

*   **CSRF Protection:** All state-changing (`PUT`, `POST`, `DELETE`) requests from web templates to the API must include an `X-CSRFToken` header.
*   **Role Enforcement:** The default role for new employees must be a canonical one (`waiter`), and the creation of users with invalid roles (`staff`) must be prevented.
*   **No Hardcoded `localhost`:** Frontend code must not contain hardcoded fallbacks to `localhost` for asset URLs, as this can leak configuration and break in production.
*   **Contract Change Control:** Changes to critical contract files (in `pronto-ai/` or `pronto-docs/`) must be blocked by pre-commit hooks unless explicitly bypassed with an environment variable (`PRONTO_ALLOW_CONTRACT_CHANGES=1`).

## 5. Documentation & Developer Experience

*   **Accurate Documentation:** All `README` files must be updated to remove references to legacy or non-existent API endpoints.
*   **Pre-commit Hook Stability:** Local pre-commit hooks must be functional and not block developers due to configuration errors (e.g., missing files or incorrect function names).
*   **Test Runner Authentication:** The API test runner must use the correct authentication endpoint (`/system/login`) and properly manage JWT cookies to run authenticated tests.
