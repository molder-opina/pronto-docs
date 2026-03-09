This chunk of documents outlines several key business rules and workflows for the Pronto application, focusing on table and session management for waiters and the customer checkout experience.

**Business Rules:**

*   **Table Occupancy:** A session cannot be moved to an already occupied table.
*   **Atomic Session Merges:** Merging multiple dining sessions must be an atomic transaction; failure at any step should roll back all changes.
*   **Auto-Assignment:** Waiters can opt-in to have tables automatically assigned to them when they accept an order from an unassigned table.
*   **Checkout Offers:** Customers should be presented with promotional offers after requesting their bill.
*   **Query Optimization:** Data related to merged sessions (like orders) should be fetched efficiently to prevent database performance issues.
*   **Chef Notifications:** Chefs must receive real-time notifications for new orders.
*   **Timed Feedback:** Customers have a 10-second window to provide feedback after payment.
*   **Account Merging:** Multiple dining sessions can be merged into one.
*   **Table Moving:** A customer's session can be moved to a different table.
*   **Bill Splitting:** Bills can be split by item or into equal parts.
*   **Payment Permissions:** Administrators can globally restrict payment collection to only cashiers and admins, disabling it for waiters.

**Workflows:**

*   **Move Table:** Check destination table occupancy before moving a session.
*   **Merge Sessions:** Use a database transaction to ensure atomicity. Fetch all data efficiently.
*   **Auto-Assign Table:** A waiter enables a preference, accepts an order from an unassigned table, and the system assigns the table to them.
*   **Customer Checkout:** The customer requests checkout, and a modal with offers is displayed while they wait.
*   **Order Creation:** When an order is created, both waiters and chefs are notified.
*   **Post-Payment Feedback:** After payment, a 10-second timer starts for customer feedback.
*   **Split Bill:** A waiter can initiate a bill split by items or into equal parts.

**System & Architectural Rules:**

*   **State Machine Enforcement:** The order lifecycle is strictly controlled by a state machine (`new` -> `queued` -> `preparing` -> `ready` -> `delivered` -> `paid`). Only the `OrderStateMachine` service can modify order or payment statuses.
*   **Automated Gates:** The development process is governed by automated checks that reject code violating architectural, security, or documentation rules.
*   **Security by Default:** All endpoints require authentication, employee authentication uses immutable JWTs (not Flask sessions), and CSRF protection is mandatory.
*   **Infrastructure Integrity:** Direct modification of the database, Redis, or Docker configurations is forbidden. Schema changes are tightly controlled through a migration process.
*   **Automated Versioning:** The system version is automatically incremented with every AI-applied change, and a detailed log is maintained.
*   **Canonical API & Routing:** All APIs must use a `/api/*` path, with routing based on hostname. A specific frontend wrapper must be used for API calls to handle CSRF, and route parameter types must match database model types.
*   **Traceability:** Every request is tagged with a unique `X-Correlation-ID` which must be present in all structured JSON logs.
*   **Audited Bug Fixes:** A "ticket-before-fix" process is mandatory for all bugs to ensure a complete and verifiable audit trail.

These bug reports (`ERR-20260218-EMPLOYEES-ORDERS-500-CUSTOMER-EMAIL`, `ERR-20260218-ENDPOINTS-SIN-JWT`, `ERR-20260218-GATE-VALIDATION-RESOLVED-CONSISTENCY`, `ERR-20260218-MAGIC-STRINGS`, `ERR-20260218-MIGR-20260218-06-NONIDEMPOTENT-INDEX`) serve as concrete examples of how the defined System & Architectural Rules are enforced and how their violations are detected and resolved, reinforcing the system's robustness and adherence to its own high standards.

Further bug fixes (`ERR-20260218-OSM-HANDLERS`, `ERR-20260218-PARITY-ROUTE-ALIGNMENT-P1`, `ERR-20260219-AREA-ID-UUID-INTEGER-MISMATCH`, `ERR-20260219-CHECKOUT-POST-SIN-CSRF`) continued to demonstrate strict adherence to the system's core principles, addressing issues such as the `OrderStateMachine`'s failure to update status, API route desynchronization between frontend and backend, critical data type mismatches in database schemas, and missing CSRF tokens in client-side checkout processes. These resolutions highlight the continuous validation and refinement of the system against its established architectural and security mandates.
