# Prompts for Kitchen and Cashier Management - Chunk 9

This file contains prompts related to the Kitchen and Cashier management views, based on the findings from the audit.

---

### Kitchen Management

-   **Prompt**: The tabs for 'Productos' and 'Aditamientos' within the `/admin/dashboard/kitchen` view are incorrectly sharing routes with the 'Meseros' view (`/products` and `/modifiers`). This causes the UI shell to lose focus. Create dedicated routes for the kitchen context, such as `kitchen-products` and `kitchen-modifiers`, and update the router and `DashboardView.vue` to use them.
-   **Prompt**: There is a legacy navigation issue where accessing 'Aditamientos' from the kitchen view can still land the user on the shared `/admin/dashboard/modifiers` route. Implement a guard in the Vue router that detects this legacy navigation from the 'Cocina' context and automatically redirects to the correct namespaced route (`kitchen-modifiers`).
-   **Prompt**: The primary navigation for an admin user is cluttered. 'Cocina' and 'Caja' are currently implemented as tabs within the main dashboard. Refactor the navigation so that 'Cocina' and 'Caja' are primary navigation items in the sidebar. When a user navigates to 'Cocina', it should then display its own set of secondary tabs (e.g., 'Cocina', 'Productos', 'Aditamientos').

### Cashier Management

-   **Prompt**: The cashier view at `/admin/dashboard/cashier` is unstyled and appears broken. The `CashierBoard.vue` component is missing its own scoped styles. Rewrite the component with a proper layout and scoped CSS to ensure it renders correctly with a consistent design, including a styled header, metrics, search bar, and orders table.
-   **Prompt**: The session status label in the cashier view (`/waiter/dashboard/sessions`) is displaying "Consumo activo" for sessions that are in an 'open' state. This is confusing. Update the `SessionCard.vue` and `CashierBoard.vue` components to display a more accurate status label, such as "Cuenta abierta" for the 'open' state, and add explicit labels for other statuses like `awaiting_payment_confirmation`.
