# Summary of Extracted Rules - Chunk 9

This document summarizes the business, technical, and security rules extracted from the files in `pronto-docs-checklist-chunk-9.md`.

## Security Rules

-   **PII Encryption**: Employee Personally Identifiable Information (PII), such as email and phone number, must be encrypted in the database using hybrid properties.
-   **Scope-Based Access Control**: API routes must be protected with `ScopeGuard` to validate the `active_scope` from the JWT, preventing unauthorized access. Redundant API routes in `pronto-employees` that bypass this are a critical vulnerability.
-   **Canonical Roles**: The system must use a set of canonical roles (`waiter`, `chef`, `cashier`, `admin`, `system`). Non-canonical roles (e.g., `super_admin`) must be mapped to a canonical scope during authentication.
-   **Session Isolation**: User sessions must be isolated between different consoles (e.g., `/waiter`, `/chef`). This should be achieved by using namespaced JWT cookies (e.g., `access_token_waiter`, `access_token_chef`).
-   **CSRF Protection**: CSRF validation must be handled correctly for JSON-based API requests, especially for mutating operations like DELETE.
-   **Principle of Least Privilege**: The `admin` scope should not have access to manage `system` accounts or roles. This is reserved for the `system` scope.

## Business Rules

-   **UI Notifications**: Use non-blocking toast notifications instead of `alert()` to avoid interrupting the user's workflow, especially in critical operational environments.
-   **Single Active Tab**: In the employee dashboard, only one module tab should be active at a time to avoid confusion.
-   **Clear UI Actions**: Configuration items in the admin panel should have explicit "Edit" and "Save" buttons to make the user workflow clear.
-   **Role-Based Views**: The UI should adapt based on the user's role. For example, the admin view for employee management should not show system-level accounts.
-   **Consistent Navigation**: The application should provide a consistent navigation experience. For example, tabs and sidebars should behave predictably across different views.
-   **Custom Role Management**: The UI should not expose functionality for creating, editing, or deleting custom roles if the system only operates with a set of canonical roles.

## Technical Rules

-   **CSS Best Practices**: Final CSS builds should not contain pre-processor directives like `@tailwind` or `@apply`.
-   **Asset Loading**: Use same-origin relative paths for assets to avoid issues like Opaque Response Blocking (ORB). Implement fallback handlers for images that fail to load.
-   **API Contract Sync**: The frontend and backend API contracts must be kept in sync. A parity-check system should be used to detect and resolve discrepancies.
-   **Code Maintainability**: Avoid large, monolithic files. Refactor large components and services to follow the Single Responsibility Principle.
-   **Framework-Native Implementation**: Avoid mixing vanilla JavaScript for DOM manipulation within a Vue.js application. Use Vue-native approaches.
-   **Configuration Management**: Centralize application configuration. Avoid hardcoded values in the frontend. Use a consistent naming convention for configuration keys (e.g., lowercase).
-   **API Endpoint Design**: API endpoints should follow a consistent and predictable naming convention.
-   **Error Handling**: The UI should handle API errors gracefully and provide clear feedback to the user. Partial failures in a view that loads data from multiple endpoints should not break the entire view.
-   **Input Validation**: User input should be validated. For example, parameters representing seconds should be validated as integers within a reasonable range.
-   **Component Reusability**: Use reusable components for common UI elements like form inputs, modals, and tables.

## Workflows

-   **Admin Configuration**:
    -   Color parameters should use a color picker.
    -   Currency codes and symbols should be selected from a dropdown list.
    -   Font families should be selected from a static catalog.
    -   Logo URLs should be managed via a file picker that uploads the image.
-   **Employee Management (Admin)**:
    -   The view should list employees and allow for creating, editing, and deleting them.
    -   The list of employees should not include `system` accounts.
    -   The roles available in the "Edit Employee" modal should be filtered based on the current scope (`admin` or `system`).
-   **Role Management (Admin)**:
    -   The view should display the canonical roles and their descriptions.
    -   It should not allow for the creation or modification of custom roles if not supported.
-   **Reports (Admin)**:
    -   The reports view should query the correct, specific API endpoints for different reports (e.g., sales, top products) instead of a single, non-existent endpoint.
