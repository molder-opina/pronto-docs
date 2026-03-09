## Rutas endpoint por endpoint de `pronto-api` (parte 1)

Parte 1 del inventario crudo generado desde `app.url_map`.

| Ruta | Métodos | Endpoint Flask | Módulo | Función |
|---|---|---|---|---|
| `/api/admin/invoices` | `GET` | `api.admin_invoices.admin_list_invoices` | `api_app.routes.invoices` | `admin_list_invoices` |
| `/api/admin/invoices/<invoice_id>` | `GET` | `api.admin_invoices.admin_get_invoice` | `api_app.routes.invoices` | `admin_get_invoice` |
| `/api/admin/invoices/stats` | `GET` | `api.admin_invoices.admin_invoice_stats` | `api_app.routes.invoices` | `admin_invoice_stats` |
| `/api/admin/orders/<order_id>/force-cancel` | `POST` | `api.employees.employees_admin.force_cancel_order` | `api_app.routes.employees.admin` | `force_cancel_order` |
| `/api/admin/permissions/roles/<string:role_key>/add` | `POST` | `api.employees.employees_admin.add_role_permission` | `api_app.routes.employees.admin` | `add_role_permission` |
| `/api/admin/permissions/roles/<string:role_key>/remove` | `POST` | `api.employees.employees_admin.remove_role_permission` | `api_app.routes.employees.admin` | `remove_role_permission` |
| `/api/admin/permissions/roles/<string:role_key>/reset` | `POST` | `api.employees.employees_admin.reset_role_permissions` | `api_app.routes.employees.admin` | `reset_role_permissions` |
| `/api/admin/permissions/system` | `GET` | `api.employees.employees_admin.get_system_permissions` | `api_app.routes.employees.admin` | `get_system_permissions` |
| `/api/admin/shortcuts` | `GET` | `api.employees.employees_admin.list_shortcuts` | `api_app.routes.employees.admin` | `list_shortcuts` |
| `/api/admin/shortcuts` | `POST` | `api.employees.employees_admin.create_shortcut` | `api_app.routes.employees.admin` | `create_shortcut` |
| `/api/admin/shortcuts/<int:shortcut_id>` | `DELETE` | `api.employees.employees_admin.delete_shortcut` | `api_app.routes.employees.admin` | `delete_shortcut` |
| `/api/admin/shortcuts/<int:shortcut_id>` | `PUT` | `api.employees.employees_admin.update_shortcut` | `api_app.routes.employees.admin` | `update_shortcut` |
| `/api/analytics/category-performance` | `GET` | `api.employees.employees_analytics.get_category_performance` | `api_app.routes.employees.analytics` | `get_category_performance` |
| `/api/analytics/comparison` | `GET` | `api.employees.employees_analytics.get_comparison` | `api_app.routes.employees.analytics` | `get_comparison` |
| `/api/analytics/customer-segments` | `GET` | `api.employees.employees_analytics.get_customer_segments` | `api_app.routes.employees.analytics` | `get_customer_segments` |
| `/api/analytics/kpis` | `GET` | `api.employees.employees_analytics.get_kpis` | `api_app.routes.employees.analytics` | `get_kpis` |
| `/api/analytics/operational-metrics` | `GET` | `api.employees.employees_analytics.get_operational_metrics` | `api_app.routes.employees.analytics` | `get_operational_metrics` |
| `/api/analytics/revenue-trends` | `GET` | `api.employees.employees_analytics.get_revenue_trends` | `api_app.routes.employees.analytics` | `get_revenue_trends` |
| `/api/analytics/waiter-performance` | `GET` | `api.employees.employees_analytics.get_waiter_performance` | `api_app.routes.employees.analytics` | `get_waiter_performance` |
| `/api/areas` | `GET` | `api.employees.employees_areas.list_areas` | `api_app.routes.employees.areas` | `list_areas` |
| `/api/areas` | `POST` | `api.employees.employees_areas.create_area` | `api_app.routes.employees.areas` | `create_area` |
| `/api/areas/<int:area_id>` | `DELETE` | `api.employees.employees_areas.delete_area` | `api_app.routes.employees.areas` | `delete_area` |
| `/api/areas/<int:area_id>` | `PUT` | `api.employees.employees_areas.update_area` | `api_app.routes.employees.areas` | `update_area` |
| `/api/areas/areas` | `GET` | `api.areas_api.list_areas` | `api_app.routes.areas` | `list_areas` |
| `/api/areas/areas` | `POST` | `api.areas_api.create_area` | `api_app.routes.areas` | `create_area` |
| `/api/areas/areas/<uuid:area_id>` | `DELETE` | `api.areas_api.delete_area` | `api_app.routes.areas` | `delete_area` |
| `/api/areas/areas/<uuid:area_id>` | `PUT` | `api.areas_api.update_area` | `api_app.routes.areas` | `update_area` |
| `/api/auth/forgot-password` | `POST` | `api.employees.employees_auth.forgot_password` | `api_app.routes.employees.auth` | `forgot_password` |
| `/api/auth/login` | `POST` | `api.employees.employees_auth.login` | `api_app.routes.employees.auth` | `login` |
| `/api/auth/logout` | `POST` | `api.employees.employees_auth.logout` | `api_app.routes.employees.auth` | `logout` |
| `/api/auth/me` | `GET` | `api.employees.employees_auth.me` | `api_app.routes.employees.auth` | `me` |
| `/api/auth/refresh` | `POST` | `api.employees.employees_auth.refresh` | `api_app.routes.employees.auth` | `refresh` |
| `/api/auth/reset-password` | `POST` | `api.employees.employees_auth.reset_password` | `api_app.routes.employees.auth` | `reset_password` |
| `/api/auth/revoke` | `POST` | `api.employees.employees_auth.revoke` | `api_app.routes.employees.auth` | `revoke` |
| `/api/branding/config` | `GET` | `api.employees.employees_branding.get_branding_config` | `api_app.routes.employees.api_branding` | `get_branding_config` |
| `/api/branding/config` | `PUT` | `api.employees.employees_branding.update_branding_config` | `api_app.routes.employees.api_branding` | `update_branding_config` |
| `/api/branding/generate-products` | `POST` | `api.employees.employees_branding.generate_products` | `api_app.routes.employees.api_branding` | `generate_products` |
| `/api/branding/generate/<string:asset_type>` | `POST` | `api.employees.employees_branding.generate_asset` | `api_app.routes.employees.api_branding` | `generate_asset` |
| `/api/branding/logo` | `GET` | `api.employees.employees_branding.get_logo` | `api_app.routes.employees.api_branding` | `get_logo` |
| `/api/branding/logo` | `POST` | `api.employees.employees_branding.upload_logo` | `api_app.routes.employees.api_branding` | `upload_logo` |
| `/api/branding/upload/<string:asset_type>` | `POST` | `api.employees.employees_branding.upload_asset` | `api_app.routes.employees.api_branding` | `upload_asset` |
| `/api/business-info` | `GET` | `api.employees.employees_business_info.get_business_info` | `api_app.routes.employees.business_info` | `get_business_info` |
| `/api/business-info` | `POST` | `api.employees.employees_business_info.update_business_info` | `api_app.routes.employees.business_info` | `update_business_info` |
| `/api/business-info/schedule` | `POST` | `api.employees.employees_business_info.update_business_schedule` | `api_app.routes.employees.business_info` | `update_business_schedule` |
| `/api/client-auth/forgot-password` | `POST` | `api.client_auth.forgot_password` | `api_app.routes.client_auth` | `forgot_password` |
| `/api/client-auth/login` | `POST` | `api.client_auth.login` | `api_app.routes.client_auth` | `login` |
| `/api/client-auth/logout` | `POST` | `api.client_auth.logout` | `api_app.routes.client_auth` | `logout` |
| `/api/client-auth/me` | `GET` | `api.client_auth.get_current_customer_profile` | `api_app.routes.client_auth` | `get_current_customer_profile` |
| `/api/client-auth/me` | `PUT` | `api.client_auth.update_current_customer_profile` | `api_app.routes.client_auth` | `update_current_customer_profile` |
| `/api/client-auth/register` | `POST` | `api.client_auth.register` | `api_app.routes.client_auth` | `register` |
| `/api/client-auth/reset-password` | `POST` | `api.client_auth.reset_password` | `api_app.routes.client_auth` | `reset_password` |
| `/api/client/invoices` | `GET` | `api.invoices.list_invoices` | `api_app.routes.invoices` | `list_invoices` |
