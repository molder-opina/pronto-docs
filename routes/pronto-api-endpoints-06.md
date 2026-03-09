## Rutas endpoint por endpoint de `pronto-api` (parte 6)

Parte 6 del inventario crudo generado desde `app.url_map`.

| Ruta | Métodos | Endpoint Flask | Módulo | Función |
|---|---|---|---|---|
| `/api/sessions/table-context` | `POST` | `api.client_sessions.set_table_context` | `api_app.routes.client_sessions` | `set_table_context` |
| `/api/sessions/validate` | `POST` | `api.client_sessions.validate` | `api_app.routes.client_sessions` | `validate` |
| `/api/settings/public/<key>` | `GET` | `api.settings.get_public_setting` | `api_app.routes.settings` | `get_public_setting` |
| `/api/settings/public/waiter_notification_sound` | `GET` | `api.settings.get_waiter_notification_sound` | `api_app.routes.settings` | `get_waiter_notification_sound` |
| `/api/shortcuts` | `GET` | `api.menu.get_enabled_shortcuts` | `api_app.routes.menu` | `get_enabled_shortcuts` |
| `/api/shortcuts` | `GET` | `api.shortcuts.get_shortcuts` | `api_app.routes.shortcuts` | `get_shortcuts` |
| `/api/split-bills/people/<person_id>/pay` | `POST` | `api.employees.split_bills.pay_person` | `api_app.routes.employees.split_bills` | `pay_person` |
| `/api/split-bills/sessions/<session_id>` | `GET` | `api.employees.split_bills.get_split` | `api_app.routes.employees.split_bills` | `get_split` |
| `/api/split-bills/sessions/<session_id>/calculate` | `POST` | `api.employees.split_bills.calculate_split` | `api_app.routes.employees.split_bills` | `calculate_split` |
| `/api/split-bills/sessions/<session_id>/create` | `POST` | `api.employees.split_bills.create_split` | `api_app.routes.employees.split_bills` | `create_split` |
| `/api/stats/public` | `GET` | `api.employees.employees_stats.get_public_stats` | `api_app.routes.employees.stats` | `get_public_stats` |
| `/api/support-tickets` | `POST` | `api.support.create_support_ticket` | `api_app.routes.support` | `create_support_ticket` |
| `/api/table-assignments/assign` | `POST` | `api.employees.employees_table_assignments.assign_table` | `api_app.routes.employees.table_assignments` | `assign_table` |
| `/api/table-assignments/check-conflicts` | `POST` | `api.employees.employees_table_assignments.check_conflicts` | `api_app.routes.employees.table_assignments` | `check_conflicts` |
| `/api/table-assignments/my-tables` | `GET` | `api.employees.employees_table_assignments.get_my_tables` | `api_app.routes.employees.table_assignments` | `get_my_tables` |
| `/api/table-assignments/transfer-request` | `POST` | `api.employees.employees_table_assignments.create_transfer` | `api_app.routes.employees.table_assignments` | `create_transfer` |
| `/api/table-assignments/transfer-request/<int:request_id>/accept` | `POST` | `api.employees.employees_table_assignments.accept_transfer_request_route` | `api_app.routes.employees.table_assignments` | `accept_transfer_request_route` |
| `/api/table-assignments/transfer-request/<int:request_id>/reject` | `POST` | `api.employees.employees_table_assignments.reject_transfer_request_route` | `api_app.routes.employees.table_assignments` | `reject_transfer_request_route` |
| `/api/table-assignments/transfer-requests` | `GET` | `api.employees.employees_table_assignments.get_transfer_requests` | `api_app.routes.employees.table_assignments` | `get_transfer_requests` |
| `/api/table-assignments/unassign/<uuid:table_id>` | `DELETE` | `api.employees.employees_table_assignments.unassign_table` | `api_app.routes.employees.table_assignments` | `unassign_table` |
| `/api/tables` | `GET` | `api.employees.employees_tables.list_tables` | `api_app.routes.employees.tables` | `list_tables` |
| `/api/tables` | `POST` | `api.employees.employees_tables.create_table` | `api_app.routes.employees.tables` | `create_table` |
| `/api/tables/<uuid:table_id>` | `DELETE` | `api.employees.employees_tables.delete_table` | `api_app.routes.employees.tables` | `delete_table` |
| `/api/tables/<uuid:table_id>` | `GET` | `api.employees.employees_tables.get_table` | `api_app.routes.employees.tables` | `get_table` |
| `/api/tables/<uuid:table_id>` | `PUT` | `api.employees.employees_tables.update_table` | `api_app.routes.employees.tables` | `update_table` |
| `/api/tables/tables` | `GET` | `api.tables_api.list_tables` | `api_app.routes.tables` | `list_tables` |
| `/api/tables/tables` | `POST` | `api.tables_api.create_table` | `api_app.routes.tables` | `create_table` |
| `/api/tables/tables/<uuid:table_id>` | `DELETE` | `api.tables_api.delete_table` | `api_app.routes.tables` | `delete_table` |
| `/api/tables/tables/<uuid:table_id>` | `GET` | `api.tables_api.get_table` | `api_app.routes.tables` | `get_table` |
| `/api/tables/tables/<uuid:table_id>` | `PUT` | `api.tables_api.update_table` | `api_app.routes.tables` | `update_table` |
| `/api/tables/tables/<uuid:table_id>/qr` | `GET` | `api.tables_api.table_qr` | `api_app.routes.tables` | `table_qr` |
| `/health` | `GET` | `health` | `api_app.app` | `health` |
| `/static/<path:filename>` | `GET` | `static` | `flask.app` | `<lambda>` |
