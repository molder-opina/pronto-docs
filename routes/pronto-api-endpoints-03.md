## Rutas endpoint por endpoint de `pronto-api` (parte 3)

Parte 3 del inventario crudo generado desde `app.url_map`.

| Ruta | Métodos | Endpoint Flask | Módulo | Función |
|---|---|---|---|---|
| `/api/split-bills/split-bills/<uuid:split_id>/summary` | `GET` | `api.customers.customer_split_bills.get_split_summary` | `api_app.routes.customers.split_bills` | `get_split_summary` |
| `/api/customers/stats` | `GET` | `api.customers_root.customers.customers_stats` | `api_app.routes.customers.admin` | `customers_stats` |
| `/api/waiter-calls/call-waiter` | `POST` | `api.customers.customer_waiter_calls.call_waiter` | `api_app.routes.customers.waiter_calls` | `call_waiter` |
| `/api/waiter-calls/cancel` | `POST` | `api.customers.customer_waiter_calls.cancel_waiter_call` | `api_app.routes.customers.waiter_calls` | `cancel_waiter_call` |
| `/api/waiter-calls/status/<int:call>` | `GET` | `api.customers.customer_waiter_calls.get_waiter_call_status` | `api_app.routes.customers.waiter_calls` | `get_waiter_call_status` |
| `/api/debug/orders/<order_id>/advance` | `POST` | `api.employees.employees_debug.debug_advance_order` | `api_app.routes.employees.debug` | `debug_advance_order` |
| `/api/debug/sessions/<uuid:session_id>/request-checkout` | `POST` | `api.employees.employees_debug.debug_request_checkout` | `api_app.routes.employees.debug` | `debug_request_checkout` |
| `/api/debug/sessions/<uuid:session_id>/simulate-payment` | `POST` | `api.employees.employees_debug.debug_simulate_payment` | `api_app.routes.employees.debug` | `debug_simulate_payment` |
| `/api/discount-codes` | `GET` | `api.employees.employees_discount_codes.list_discount_codes` | `api_app.routes.employees.discount_codes` | `list_discount_codes` |
| `/api/discount-codes/<int:code_id>` | `DELETE` | `api.employees.employees_discount_codes.delete_discount_code` | `api_app.routes.employees.discount_codes` | `delete_discount_code` |
| `/api/employees` | `GET` | `api.employees.employees_employees.list_employees` | `api_app.routes.employees.employees` | `list_employees` |
| `/api/employees` | `POST` | `api.employees.employees_employees.create_employee` | `api_app.routes.employees.employees` | `create_employee` |
| `/api/employees/<employee_id>` | `DELETE` | `api.employees.employees_employees.delete_employee` | `api_app.routes.employees.employees` | `delete_employee` |
| `/api/employees/<employee_id>` | `GET` | `api.employees.employees_employees.get_employee` | `api_app.routes.employees.employees` | `get_employee` |
| `/api/employees/<employee_id>` | `PUT` | `api.employees.employees_employees.update_employee` | `api_app.routes.employees.employees` | `update_employee` |
| `/api/employees/auth/login` | `POST` | `api.employees.employees_auth.login` | `api_app.routes.employees.auth` | `login` |
| `/api/employees/auth/logout` | `POST` | `api.employees.employees_auth.logout` | `api_app.routes.employees.auth` | `logout` |
| `/api/employees/auth/me` | `GET` | `api.employees.employees_auth.me` | `api_app.routes.employees.auth` | `me` |
| `/api/employees/auth/refresh` | `POST` | `api.employees.employees_auth.refresh` | `api_app.routes.employees.auth` | `refresh` |
| `/api/employees/auth/revoke` | `POST` | `api.employees.employees_auth.revoke` | `api_app.routes.employees.auth` | `revoke` |
| `/api/employees/roles` | `GET` | `api.employees.employees_employees.list_roles` | `api_app.routes.employees.employees` | `list_roles` |
| `/api/employees/roles` | `POST` | `api.employees.employees_employees.create_role` | `api_app.routes.employees.employees` | `create_role` |
| `/api/employees/roles/<int:role_id>` | `DELETE` | `api.employees.employees_employees.delete_role` | `api_app.routes.employees.employees` | `delete_role` |
| `/api/employees/roles/<int:role_id>` | `GET` | `api.employees.employees_employees.get_role` | `api_app.routes.employees.employees` | `get_role` |
| `/api/employees/roles/<int:role_id>` | `PUT` | `api.employees.employees_employees.update_role` | `api_app.routes.employees.employees` | `update_role` |
| `/api/employees/roles/<int:role_id>/permissions/bulk` | `PUT` | `api.employees.employees_employees.bulk_update_role_permissions` | `api_app.routes.employees.employees` | `bulk_update_role_permissions` |
| `/api/employees/roles/employees/<employee_id>/revoke` | `POST` | `api.employees.employees_employees.revoke_employee_role` | `api_app.routes.employees.employees` | `revoke_employee_role` |
| `/api/employees/search` | `GET` | `api.employees.employees_employees.search_employees` | `api_app.routes.employees.employees` | `search_employees` |
| `/api/feedback/bulk` | `POST` | `api.feedback.submit_bulk_feedback` | `api_app.routes.feedback` | `submit_bulk_feedback` |
| `/api/feedback/questions` | `POST` | `api.menu.get_feedback_questions` | `api_app.routes.menu` | `get_feedback_questions` |
| `/api/feedback/stats/overall` | `GET` | `api.feedback.feedback_stats_overall` | `api_app.routes.feedback` | `feedback_stats_overall` |
| `/api/feedback/stats/top-employees` | `GET` | `api.feedback.feedback_stats_top_employees` | `api_app.routes.feedback` | `feedback_stats_top_employees` |
| `/api/forgot-password` | `POST` | `api.employees.employees_auth.forgot_password` | `api_app.routes.employees.auth` | `forgot_password` |
| `/api/login` | `POST` | `api.employees.employees_auth.login` | `api_app.routes.employees.auth` | `login` |
| `/api/logout` | `POST` | `api.employees.employees_auth.logout` | `api_app.routes.employees.auth` | `logout` |
| `/api/maintenance/sessions/clean-all` | `POST` | `api.employees.employees_maintenance.clean_all_sessions` | `api_app.routes.employees.maintenance` | `clean_all_sessions` |
| `/api/maintenance/sessions/clean-inactive` | `POST` | `api.employees.employees_maintenance.clean_inactive_sessions` | `api_app.routes.employees.maintenance` | `clean_inactive_sessions` |
| `/api/me` | `GET` | `api.employees.employees_auth.me` | `api_app.routes.employees.auth` | `me` |
| `/api/me/password` | `PUT` | `api.employees.employees_me.update_my_password` | `api_app.routes.employees.me` | `update_my_password` |
| `/api/me/preferences` | `GET` | `api.employees.employees_me.get_my_preferences` | `api_app.routes.employees.me` | `get_my_preferences` |
| `/api/me/preferences` | `PUT` | `api.employees.employees_me.update_my_preferences` | `api_app.routes.employees.me` | `update_my_preferences` |
| `/api/menu` | `GET` | `api.menu.get_menu` | `api_app.routes.menu` | `get_menu` |
| `/api/menu` | `GET` | `api.employees.employees_menu.get_menu` | `api_app.routes.employees.menu` | `get_menu` |
| `/api/menu-categories` | `GET` | `api.employees.employees_menu_categories.list_categories` | `api_app.routes.employees.menu_categories` | `list_categories` |
| `/api/menu-categories` | `POST` | `api.employees.employees_menu_categories.create_category` | `api_app.routes.employees.menu_categories` | `create_category` |
| `/api/menu-categories/<uuid:category_id>` | `DELETE` | `api.employees.employees_menu_categories.delete_category` | `api_app.routes.employees.menu_categories` | `delete_category` |
| `/api/menu-categories/<uuid:category_id>` | `PUT` | `api.employees.employees_menu_categories.update_category` | `api_app.routes.employees.menu_categories` | `update_category` |
| `/api/menu-home-modules` | `GET` | `api.employees.employees_menu_home_modules.list_modules` | `api_app.routes.employees.menu_home_modules` | `list_modules` |
| `/api/menu-home-modules` | `POST` | `api.employees.employees_menu_home_modules.create_module` | `api_app.routes.employees.menu_home_modules` | `create_module` |
| `/api/menu-home-modules/<uuid:module_id>` | `DELETE` | `api.employees.employees_menu_home_modules.delete_module` | `api_app.routes.employees.menu_home_modules` | `delete_module` |
| `/api/menu-home-modules/<uuid:module_id>` | `PUT` | `api.employees.employees_menu_home_modules.update_module` | `api_app.routes.employees.menu_home_modules` | `update_module` |
| `/api/menu-home-modules/<uuid:module_id>/products` | `PUT` | `api.employees.employees_menu_home_modules.set_manual_products` | `api_app.routes.employees.menu_home_modules` | `set_manual_products` |
