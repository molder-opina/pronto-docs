# Summary of Rules and Workflows (Chunk 1)

This document summarizes the business rules, technical rules, security rules, and workflows extracted from the first chunk of documentation.

## Business Rules

### Ordering
*   **Order Creation:** Orders can be created by both customers and employees.
*   **Order State Machine:** Orders progress through a defined lifecycle: `new` -> `queued` -> `preparing` -> `ready` -> `delivered` -> `paid` -> `cancelled`.
*   **Required Modifiers:** Some menu items require customers to select mandatory options (modifiers).
*   **Session Requirement:** Customers must have an active session to place an order.
*   **Table Assignment:** A table must be assigned to a customer's session before an order can be confirmed. The table location is locked for the duration of the active session.
*   **Combos/Packages:** Combo meals are dynamically constructed from existing, available products.

### Payments
*   **Payment Methods:** Accepted payment methods include cash, card, Clip, and Stripe.
*   **Requesting Bill:** Customers can initiate a "request to pay" workflow.
*   **Tip Policy:** Tips are capped at a maximum of 50% of the total bill.

### Authentication & Authorization
*   **Customer Sessions:** Customer sessions are managed in Redis and identified by a `customer_ref`.
*   **Employee Access:** Employees use JWT-based sessions with role-based scopes (`waiter`, `chef`, `cashier`, `admin`, `system`).
*   **Password Security:** Passwords are required to be hashed using PBKDF2.
*   **Rate Limiting:** Login endpoints are protected by rate limiting to prevent brute-force attacks.
*   **CSRF Protection:** Most endpoints that change state are protected against Cross-Site Request Forgery.

### Kiosk
*   **Session Duration:** Kiosk sessions are configured to be non-expiring.

### Menu
*   **Item Availability:** Menu items can be marked as "unavailable" by authorized staff.
*   **Categorization:** Menu categories are identified by a `slug` and a `revision` number for versioning.

### Invoicing
*   **Customer Invoices:** Customers can request an invoice for their orders.
*   **Invoicing Provider:** The system integrates with Facturapi for generating invoices.

## Technical Rules

### Architecture
*   **Single Source of Truth:** The `pronto-api` service is the definitive authority for all business logic.
*   **BFF Pattern:** The `pronto-client` and `pronto-employees` applications act as Backend-for-Frontend (BFF) proxies and are not supposed to contain business logic.
*   **Static Assets:** All static content (CSS, JS, images) is served from the `pronto-static` service.

### API
*   **API Contract:** All APIs must adhere to a consistent and well-defined contract.
*   **Entity IDs:** Most entities in the system are identified using UUIDs.
*   **Timestamps:** All timestamps must be timezone-aware and stored in UTC.

### Database
*   **Migrations:** Changes to the database schema must be managed through a formal migration process.
*   **Schema-Model Consistency:** The database schema must remain consistent with the ORM (Object-Relational Mapping) models defined in the code.

### Frontend
*   **Logic Separation:** Frontend applications should be responsible for presentation only and must not contain business logic.
*   **Responsiveness:** Frontend interfaces must be responsive and adapt to different screen sizes.
*   **Globals:** The use of global variables should be minimized to avoid side effects.

### Logging
*   **Structured Logging:** All services should use structured logging for better observability.
*   **PII Masking:** Personally Identifiable Information (PII) must be masked in all application logs.

## Security Rules

### Authentication
*   **Password Hashing:** Strong password hashing (PBKDF2) is mandatory.
*   **JWT Validation:** JWTs must be validated for their issuer (`iss`) and audience (`aud`).
*   **Token Rotation:** Refresh tokens must be rotated upon use.
*   **JWT Payload:** No Personally Identifiable Information (PII) should be stored in JWT payloads.

### Authorization
*   **RBAC:** Role-Based Access Control (RBAC) is the standard for restricting access to resources based on employee roles.
*   **Ownership Checks:** The system must verify resource ownership (e.g., a customer can only view their own orders).

### CSRF
*   **CSRF Enforcement:** CSRF protection is mandatory for all state-changing endpoints, with a few explicitly documented exceptions for stateless clients.

### API Security
*   **Rate Limiting:** Sensitive endpoints, such as login, must be protected with rate limiting.
*   **BFF-API Communication:** HMAC authentication can be used to secure communication between BFFs and the main API.

### Data Security
*   **No Hardcoded Secrets:** Sensitive data like passwords and API keys must not be hardcoded in the source code.
*   **PII Handling:** All PII must be handled with care and masked when logged.

## Workflows

### Customer Ordering Workflow
1.  **Authentication:** The customer authenticates or registers for a new account.
2.  **Add to Cart:** The customer selects menu items and adds them to their shopping cart.
3.  **Checkout:** The customer proceeds to the checkout process.
4.  **Table Selection:** The customer selects their table.
5.  **Order Confirmation:** The customer confirms the order.
6.  **Kitchen:** The order is sent to the kitchen for preparation.
7.  **Status Updates:** The order status is updated as it moves through the `preparing` -> `ready` -> `delivered` lifecycle.
8.  **Payment Request:** The customer requests to pay the bill.
9.  **Payment Processing:** The payment is processed.
10. **Order Paid:** The order is marked as paid.

### Employee Login Workflow
1.  **Enter Credentials:** The employee enters their credentials into the login form.
2.  **Validation:** The server validates the credentials and the employee's role.
3.  **JWT Issuance:** The server issues a JWT with the appropriate scope for the employee's role.
4.  **Redirection:** The employee is redirected to their role-specific dashboard.
