
# Employee App Prompts (Chunk 4)

## Menu Management

- **Prompt:** "As a menu manager, I need the 'Menu Management' section in the employee dashboard to be fully functional. The backend must implement the necessary API endpoints to allow me to create, view, update, and delete menu items and categories."
- **Prompt:** "As a menu manager, I expect to see all menu items with either their specific image or a clear placeholder in the employee dashboard, ensuring the interface is visually complete and error-free. All image assets should adhere to the `/assets/` path convention."

## Customer Management

- **Prompt:** "As an employee with administrative permissions, I need a 'Customer Management' section in the employee application. This section should allow me to view customer statistics and search for specific customers, backed by a robust and functional API at `/api/customers/...`."

## Session and Order Management

- **Prompt:** "As a cashier, when I open my dashboard, I expect to see a list of all pending sessions without any errors, so I can manage my tables and orders efficiently. The data flow between `deriveSessionsFromOrders` and `SessionsManager` must be consistent to prevent runtime errors."
- **Prompt:** "As a waiter or manager, I need the ability to manage orders. This requires the backend to have a complete and functional set of API endpoints for creating, modifying, and viewing orders."

## Branding Management

- **Prompt:** "As an employee managing branding, I expect that when I upload or generate branding assets, the system handles the API communication securely and consistently. All API calls must go through the standardized `http.ts` wrapper to ensure proper handling of authentication and CSRF tokens, instead of using direct, unmanaged `fetch` calls."

## General Employee Functionality

- **Prompt:** "As an employee, I need to be able to manage my work and interact with the system. This requires the backend to have a complete set of APIs for employee-related actions, such as logging in, viewing schedules, and managing tables. An automated 'API parity check' should be in place to guarantee these features work as expected."
- **Prompt:** "As an employee using the system, I expect a visually consistent experience. Hardcoded URLs for assets like placeholders or fonts should be eliminated and replaced with centrally managed, dynamic paths to ensure all resources load correctly."
- **Prompt:** "The employee application must correctly handle different workflow statuses. Legacy status handling should be updated to use the new, standardized system to avoid inconsistencies."
