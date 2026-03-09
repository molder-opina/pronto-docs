## Rutas endpoint por endpoint de `pronto-employees`

| Ruta | Métodos | Endpoint Flask | Módulo | Función |
|---|---|---|---|---|
| `/` | `GET` | `index` | `pronto_employees.app` | `index` |
| `/admin` | `GET` | `admin_auth.console_root` | `pronto_employees.routes.admin.auth` | `console_root` |
| `/admin/` | `GET` | `admin_auth.console_root` | `pronto_employees.routes.admin.auth` | `console_root` |
| `/admin/api` | `DELETE, GET, PATCH, POST, PUT` | `api_admin.proxy_request` | `pronto_employees.routes.api.proxy_console_api` | `proxy_request` |
| `/admin/api/` | `DELETE, GET, PATCH, POST, PUT` | `api_admin.proxy_request` | `pronto_employees.routes.api.proxy_console_api` | `proxy_request` |
| `/admin/api/<path:subpath>` | `DELETE, GET, PATCH, POST, PUT` | `api_admin.proxy_request` | `pronto_employees.routes.api.proxy_console_api` | `proxy_request` |
| `/admin/authorization-error` | `GET` | `admin_auth.authorization_error_page` | `pronto_employees.routes.admin.auth` | `authorization_error_page` |
| `/admin/dashboard` | `GET` | `admin_auth.dashboard_page` | `pronto_employees.routes.admin.auth` | `dashboard_page` |
| `/admin/dashboard/<path:subpath>` | `GET` | `admin_auth.dashboard_page` | `pronto_employees.routes.admin.auth` | `dashboard_page` |
| `/admin/login` | `GET` | `admin_auth.login_page` | `pronto_employees.routes.admin.auth` | `login_page` |
| `/admin/login` | `POST` | `admin_auth.login` | `pronto_employees.routes.admin.auth` | `login` |
| `/admin/logout` | `GET, POST` | `admin_auth.logout` | `pronto_employees.routes.admin.auth` | `logout` |
| `/assets/<path:asset_path>` | `GET` | `assets_passthrough` | `pronto_employees.app` | `assets_passthrough` |
| `/authorization-error` | `GET` | `authorization_error` | `pronto_employees.app` | `authorization_error` |
| `/cashier` | `GET` | `cashier_auth.console_root` | `pronto_employees.routes.cashier.auth` | `console_root` |
| `/cashier/` | `GET` | `cashier_auth.console_root` | `pronto_employees.routes.cashier.auth` | `console_root` |
| `/cashier/api` | `DELETE, GET, PATCH, POST, PUT` | `api_cashier.proxy_request` | `pronto_employees.routes.api.proxy_console_api` | `proxy_request` |
| `/cashier/api/` | `DELETE, GET, PATCH, POST, PUT` | `api_cashier.proxy_request` | `pronto_employees.routes.api.proxy_console_api` | `proxy_request` |
| `/cashier/api/<path:subpath>` | `DELETE, GET, PATCH, POST, PUT` | `api_cashier.proxy_request` | `pronto_employees.routes.api.proxy_console_api` | `proxy_request` |
| `/cashier/authorization-error` | `GET` | `cashier_auth.authorization_error_page` | `pronto_employees.routes.cashier.auth` | `authorization_error_page` |
| `/cashier/dashboard` | `GET` | `cashier_auth.dashboard_page` | `pronto_employees.routes.cashier.auth` | `dashboard_page` |
| `/cashier/dashboard/<path:subpath>` | `GET` | `cashier_auth.dashboard_page` | `pronto_employees.routes.cashier.auth` | `dashboard_page` |
| `/cashier/login` | `GET` | `cashier_auth.login_page` | `pronto_employees.routes.cashier.auth` | `login_page` |
| `/cashier/login` | `POST` | `cashier_auth.login` | `pronto_employees.routes.cashier.auth` | `login` |
| `/cashier/logout` | `GET, POST` | `cashier_auth.logout` | `pronto_employees.routes.cashier.auth` | `logout` |
| `/chef` | `GET` | `chef_auth.console_root` | `pronto_employees.routes.chef.auth` | `console_root` |
| `/chef/` | `GET` | `chef_auth.console_root` | `pronto_employees.routes.chef.auth` | `console_root` |
| `/chef/api` | `DELETE, GET, PATCH, POST, PUT` | `api_chef.proxy_request` | `pronto_employees.routes.api.proxy_console_api` | `proxy_request` |
| `/chef/api/` | `DELETE, GET, PATCH, POST, PUT` | `api_chef.proxy_request` | `pronto_employees.routes.api.proxy_console_api` | `proxy_request` |
| `/chef/api/<path:subpath>` | `DELETE, GET, PATCH, POST, PUT` | `api_chef.proxy_request` | `pronto_employees.routes.api.proxy_console_api` | `proxy_request` |
| `/chef/authorization-error` | `GET` | `chef_auth.authorization_error_page` | `pronto_employees.routes.chef.auth` | `authorization_error_page` |
| `/chef/dashboard` | `GET` | `chef_auth.dashboard_page` | `pronto_employees.routes.chef.auth` | `dashboard_page` |
| `/chef/dashboard/<path:subpath>` | `GET` | `chef_auth.dashboard_page` | `pronto_employees.routes.chef.auth` | `dashboard_page` |
| `/chef/login` | `GET` | `chef_auth.login_page` | `pronto_employees.routes.chef.auth` | `login_page` |
| `/chef/login` | `POST` | `chef_auth.login` | `pronto_employees.routes.chef.auth` | `login` |
| `/chef/logout` | `GET, POST` | `chef_auth.logout` | `pronto_employees.routes.chef.auth` | `logout` |
| `/employees` | `GET` | `employees_spa_alias` | `pronto_employees.app` | `employees_spa_alias` |
| `/employees/<path:subpath>` | `GET` | `employees_spa_alias` | `pronto_employees.app` | `employees_spa_alias` |
| `/employees/assets/<path:asset_path>` | `GET` | `assets_passthrough` | `pronto_employees.app` | `assets_passthrough` |
| `/favicon.ico` | `GET` | `favicon` | `pronto_employees.app` | `favicon` |
| `/health` | `GET` | `health` | `pronto_employees.app` | `health` |
| `/login` | `GET` | `spa_login` | `pronto_employees.app` | `spa_login` |
| `/system` | `GET` | `system_auth.console_root` | `pronto_employees.routes.system.auth` | `console_root` |
| `/system/` | `GET` | `system_auth.console_root` | `pronto_employees.routes.system.auth` | `console_root` |
| `/system/api` | `DELETE, GET, PATCH, POST, PUT` | `api_system.proxy_request` | `pronto_employees.routes.api.proxy_console_api` | `proxy_request` |
| `/system/api/` | `DELETE, GET, PATCH, POST, PUT` | `api_system.proxy_request` | `pronto_employees.routes.api.proxy_console_api` | `proxy_request` |
| `/system/api/<path:subpath>` | `DELETE, GET, PATCH, POST, PUT` | `api_system.proxy_request` | `pronto_employees.routes.api.proxy_console_api` | `proxy_request` |
| `/system/authorization-error` | `GET` | `system_auth.authorization_error_page` | `pronto_employees.routes.system.auth` | `authorization_error_page` |
| `/system/dashboard` | `GET` | `system_auth.dashboard_page` | `pronto_employees.routes.system.auth` | `dashboard_page` |
| `/system/dashboard/<path:subpath>` | `GET` | `system_auth.dashboard_page` | `pronto_employees.routes.system.auth` | `dashboard_page` |
| `/system/login` | `GET` | `system_auth.login_page` | `pronto_employees.routes.system.auth` | `login_page` |
| `/system/login` | `POST` | `system_auth.login` | `pronto_employees.routes.system.auth` | `login` |
| `/system/logout` | `GET, POST` | `system_auth.logout` | `pronto_employees.routes.system.auth` | `logout` |
| `/waiter` | `GET` | `waiter_auth.console_root` | `pronto_employees.routes.waiter.auth` | `console_root` |
| `/waiter/` | `GET` | `waiter_auth.console_root` | `pronto_employees.routes.waiter.auth` | `console_root` |
| `/waiter/api` | `DELETE, GET, PATCH, POST, PUT` | `api_waiter.proxy_request` | `pronto_employees.routes.api.proxy_console_api` | `proxy_request` |
| `/waiter/api/` | `DELETE, GET, PATCH, POST, PUT` | `api_waiter.proxy_request` | `pronto_employees.routes.api.proxy_console_api` | `proxy_request` |
| `/waiter/api/<path:subpath>` | `DELETE, GET, PATCH, POST, PUT` | `api_waiter.proxy_request` | `pronto_employees.routes.api.proxy_console_api` | `proxy_request` |
| `/waiter/authorization-error` | `GET` | `waiter_auth.authorization_error_page` | `pronto_employees.routes.waiter.auth` | `authorization_error_page` |
| `/waiter/dashboard` | `GET` | `waiter_auth.dashboard_page` | `pronto_employees.routes.waiter.auth` | `dashboard_page` |
| `/waiter/dashboard/<path:subpath>` | `GET` | `waiter_auth.dashboard_page` | `pronto_employees.routes.waiter.auth` | `dashboard_page` |
| `/waiter/login` | `GET` | `waiter_auth.login_page` | `pronto_employees.routes.waiter.auth` | `login_page` |
| `/waiter/login` | `POST` | `waiter_auth.login` | `pronto_employees.routes.waiter.auth` | `login` |
| `/waiter/logout` | `GET, POST` | `waiter_auth.logout` | `pronto_employees.routes.waiter.auth` | `logout` |
