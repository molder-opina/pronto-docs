
## System Administration & Configuration Prompts (Chunk 3)

### Business Rules & Workflows

1.  **System Role Management:**
    *   **Prompt:** "Generate a playbook for auditing and correcting user roles. The system must only use canonical roles ('system', 'admin', 'cashier', 'chef', 'waiter'). The role 'staff' is invalid and must be migrated. The 'system' role is reserved for a single superuser account and should not be used for application-level access in the `/system` console."

2.  **Order Status Label Configuration:**
    *   **Prompt:** "Create a user guide for the '/system/config/order-status-labels' view. Explain how an admin can customize the text labels for each order status that appears in the customer and employee applications. Emphasize that these labels are for display only and do not change the underlying status workflow."

3.  **Database Schema Management:**
    *   **Prompt:** "Document the canonical workflow for database schema management. Services **must not** perform DDL operations (like `CREATE TABLE` or `ALTER TABLE`) at runtime. All schema changes must be prepared and applied before service startup using the `pronto-scripts/init` and `pronto-migrate` tools. Services should validate the schema on startup and fail if it doesn't match the expected structure."

### Technical Rules

1.  **System Console Authentication:**
    *   **Prompt:** "Review the authentication guard for the `/system` console. The guard must enforce that only users with the canonical 'system' role can access these routes. Refactor any code that incorrectly checks for a non-canonical 'system' scope or role."

2.  **Configuration View Accessibility (A11y):**
    *   **Prompt:** "Analyze the `/system/config/order-status-labels` view for accessibility compliance. All form inputs must have an associated `<label>` tag or an `aria-label`/`aria-labelledby` attribute to ensure they are usable with screen readers. Generate the necessary HTML changes to fix any unlabeled inputs."

3.  **Database Bootstrapping Idempotency:**
    *   **Prompt:** "Update the `init_db` function to be fully idempotent. The function should tolerate pre-existing database objects, such as indexes (`ix_handoff_expires_at`, `ix_handoff_token_hash`). If a `DuplicateTable` error (Postgres code `42P07`) occurs during index creation, the error should be caught and logged, but the application startup must continue without crashing."

### Security Rules

1.  **Role Canonization:**
    *   **Prompt:** "Implement a validation rule that prevents the creation or persistence of employees with non-canonical roles. The default role for a new employee should be 'waiter'. The role 'staff' is deprecated and should be removed from all models, schemas, and services. The system must strictly adhere to the defined role list: `waiter`, `chef`, `cashier`, `admin`, `system`."
