# Prompts for Waiter and Table Management - Chunk 9

This file contains prompts related to the Waiter and Table Management views, based on the findings from the audit.

---

### Waiter Dashboard

-   **Prompt**: The employee dashboard at `/waiter/dashboard` is showing console errors related to Tailwind CSS directives (`@tailwind`, `@apply`) being present in the runtime CSS. Refactor the build process for `pronto-static` to ensure that all pre-processor directives are compiled into standard CSS for the final build.
-   **Prompt**: The waiter's product menu is showing "OpaqueResponseBlocking" warnings for images because they are loaded from a different origin. Normalize all asset URLs in the `config.ts` store to be same-origin relative paths (e.g., `/assets/...`) to resolve this.
-   **Prompt**: When navigating between modules in the waiter dashboard (e.g., from 'Meseros' to 'Aditamientos'), the 'Meseros' tab remains highlighted due to partial route matching. Modify the `Sidebar.vue` and `DashboardView.vue` components to use `exact-active-class` for navigation links to ensure only the currently active module is highlighted.

### Product and Menu Management (Waiter)

-   **Prompt**: Waiters are unable to toggle the availability of menu items from the `/waiter/dashboard/products` view. The `PUT /api/menu-items/<id>` endpoint is incorrectly restricted to the 'admin' scope. Modify the API to allow the 'waiter' scope for this endpoint, but restrict the request payload to only allow changes to the `is_available` field.

### System and Architecture (Waiter Context)

-   **Prompt**: The waiter dashboard experiences duplicate real-time polling requests, causing unnecessary network traffic. Refactor the real-time client implementation in `realtime.ts` to ensure it is a singleton, preventing multiple initializations. Use unique storage keys for each real-time endpoint to further isolate them.
-   **Prompt**: The system is vulnerable to cross-scope session leakage. When a user logs into `/waiter` and then `/chef` in another tab, the sessions overwrite each other. Implement namespaced JWT cookies for each console scope (e.g., `access_token_waiter`, `access_token_chef`) and update the authentication service to prioritize these namespaced cookies.
