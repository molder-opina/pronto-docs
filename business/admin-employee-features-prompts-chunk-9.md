# Prompts for Admin Employee Management - Chunk 9

This file contains prompts related to the administration of employees, based on the findings from the audit.

---

### Security and Access Control

-   **Prompt**: Implement a security rule in the `EmployeesManager.vue` component to filter out employees with the 'system' role when the current user's scope is 'admin'. The 'system' role and associated accounts should only be visible and manageable within the '/system' console.
-   **Prompt**: Ensure that the role selection dropdown in the employee creation and editing modal is filtered based on the current user's scope. For the 'admin' scope, it should only show 'waiter', 'chef', 'cashier', and 'admin' roles. The 'system' role should only be available in the '/system' console.

### API and Data Handling

-   **Prompt**: The `employee_service.list_employees()` method is causing a 500 error because it tries to sort by a non-existent column (`Employee.name_encrypted`). Modify the service to sort by existing columns: `Employee.first_name`, `Employee.last_name`, and `Employee.id`.
-   **Prompt**: The `DELETE /admin/api/employees/:id` endpoint is failing with a 403 CSRF error. Correct the CSRF validation in `pronto-employees` to properly handle JSON requests from the Vue frontend. It should use the `X-CSRFToken` header instead of looking for a form field.
-   **Prompt**: The endpoint `GET /admin/api/roles/roles` is returning an empty array in some environments, causing the role selection dropdown in the 'Edit Employee' modal to be empty. Harden the `EmployeesManager.vue` component to always merge the canonical roles with the roles received from the API, ensuring the dropdown is always populated.

### UI and User Experience

-   **Prompt**: The employee management view at `/admin/dashboard/employees` is rendering with unstyled HTML because it uses Tailwind CSS utility classes that are not present in the final CSS bundle. Rewrite the `EmployeesManager.vue` component to use the project's actual scoped CSS and reusable components to ensure a consistent look and feel.
-   **Prompt**: The `/admin/dashboard/employees` view should only display the 'Employees' tab. Modify the `DashboardView.vue` component to treat 'employees' as a unitary tab group within the 'admin' and 'system' scopes.
-   **Prompt**: The sidebar in the `/admin/dashboard/employees` view is incorrectly showing the 'Módulos de operación' block. Add a guard to `Sidebar.vue` to explicitly hide this block when the active route is an administrative section like 'employees', 'roles', 'reports', or 'config'.
