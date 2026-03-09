## Rutas endpoint por endpoint de `pronto-api` (parte 5)

Parte 5 del inventario crudo generado desde `app.url_map`.

| Ruta | Métodos | Endpoint Flask | Módulo | Función |
|---|---|---|---|---|
| `/api/orders/<order_id>/serve` | `POST` | `api.employees.employees_orders.serve_order` | `api_app.routes.employees.orders` | `serve_order` |
| `/api/orders/<order_id>/track` | `POST` | `api.employees.employees_orders.track_order` | `api_app.routes.employees.orders` | `track_order` |
| `/api/orders/search` | `GET` | `api.employees.employees_orders.search_orders` | `api_app.routes.employees.orders` | `search_orders` |
| `/api/orders/table-rows` | `GET` | `api.employees.employees_orders.table_rows` | `api_app.routes.employees.orders` | `table_rows` |
| `/api/product-schedules` | `POST` | `api.employees.employees_product_schedules.create_schedule` | `api_app.routes.employees.product_schedules` | `create_schedule` |
| `/api/product-schedules/<int:schedule_id>` | `DELETE` | `api.employees.employees_product_schedules.delete_schedule` | `api_app.routes.employees.product_schedules` | `delete_schedule` |
| `/api/products` | `GET` | `api.menu.get_menu` | `api_app.routes.menu` | `get_menu` |
| `/api/promotions` | `GET` | `api.promotions.get_all_promotions` | `api_app.routes.promotions` | `get_all_promotions` |
| `/api/promotions` | `POST` | `api.promotions.create_promotion` | `api_app.routes.promotions` | `create_promotion` |
| `/api/promotions/<int:promo_id>` | `DELETE` | `api.promotions.delete_promotion` | `api_app.routes.promotions` | `delete_promotion` |
| `/api/promotions/<int:promo_id>` | `PUT` | `api.promotions.update_promotion` | `api_app.routes.promotions` | `update_promotion` |
| `/api/public/config` | `GET` | `api.employees.employees_config.get_public_config` | `api_app.routes.employees.config` | `get_public_config` |
| `/api/public/settings/<key>` | `GET` | `api.settings.get_public_setting` | `api_app.routes.settings` | `get_public_setting` |
| `/api/public/settings/waiter_notification_sound` | `GET` | `api.settings.get_waiter_notification_sound` | `api_app.routes.settings` | `get_waiter_notification_sound` |
| `/api/public/stats` | `GET` | `api.employees.employees_stats.get_public_stats` | `api_app.routes.employees.stats` | `get_public_stats` |
| `/api/realtime/notifications` | `GET` | `api.realtime.realtime_notifications` | `api_app.routes.realtime` | `realtime_notifications` |
| `/api/realtime/orders` | `GET` | `api.realtime.realtime_orders` | `api_app.routes.realtime` | `realtime_orders` |
| `/api/refresh` | `POST` | `api.employees.employees_auth.refresh` | `api_app.routes.employees.auth` | `refresh` |
| `/api/reports` | `GET` | `api.reports.reports_list` | `api_app.routes.reports` | `reports_list` |
| `/api/reports/category-performance` | `GET` | `api.reports.report_category_performance` | `api_app.routes.reports` | `report_category_performance` |
| `/api/reports/customer-segments` | `GET` | `api.reports.report_customer_segments` | `api_app.routes.reports` | `report_customer_segments` |
| `/api/reports/kpis` | `GET` | `api.reports.report_kpis` | `api_app.routes.reports` | `report_kpis` |
| `/api/reports/operational-metrics` | `GET` | `api.reports.report_operational_metrics` | `api_app.routes.reports` | `report_operational_metrics` |
| `/api/reports/peak-hours` | `GET` | `api.reports.report_peak_hours` | `api_app.routes.reports` | `report_peak_hours` |
| `/api/reports/sales` | `GET` | `api.reports.report_sales` | `api_app.routes.reports` | `report_sales` |
| `/api/reports/top-products` | `GET` | `api.reports.report_top_products` | `api_app.routes.reports` | `report_top_products` |
| `/api/reports/waiter-performance` | `GET` | `api.reports.report_waiter_performance` | `api_app.routes.reports` | `report_waiter_performance` |
| `/api/reports/waiter-tips` | `GET` | `api.reports.report_waiter_tips` | `api_app.routes.reports` | `report_waiter_tips` |
| `/api/reset-password` | `POST` | `api.employees.employees_auth.reset_password` | `api_app.routes.employees.auth` | `reset_password` |
| `/api/revoke` | `POST` | `api.employees.employees_auth.revoke` | `api_app.routes.employees.auth` | `revoke` |
| `/api/sessions/<session_id>` | `GET` | `api.employees.employees_sessions.get_session` | `api_app.routes.employees.sessions` | `get_session` |
| `/api/sessions/<session_id>/anonymous` | `DELETE` | `api.employees.employees_sessions.delete_anonymous` | `api_app.routes.employees.sessions` | `delete_anonymous` |
| `/api/sessions/<session_id>/checkout` | `POST` | `api.employees.employees_sessions.checkout` | `api_app.routes.employees.sessions` | `checkout` |
| `/api/sessions/<session_id>/close` | `POST` | `api.employees.employees_sessions.close_session` | `api_app.routes.employees.sessions` | `close_session` |
| `/api/sessions/<session_id>/confirm-payment` | `POST` | `api.employees.employees_sessions.confirm_payment` | `api_app.routes.employees.sessions` | `confirm_payment` |
| `/api/sessions/<session_id>/move-to-table` | `POST` | `api.employees.employees_sessions.move_session_to_table` | `api_app.routes.employees.sessions` | `move_session_to_table` |
| `/api/sessions/<session_id>/pay` | `POST` | `api.employees.employees_sessions.session_pay` | `api_app.routes.employees.sessions` | `session_pay` |
| `/api/sessions/<session_id>/regenerate-anonymous` | `POST` | `api.employees.employees_sessions.regenerate_anonymous` | `api_app.routes.employees.sessions` | `regenerate_anonymous` |
| `/api/sessions/<session_id>/reprint` | `POST` | `api.employees.employees_sessions.reprint_ticket` | `api_app.routes.employees.sessions` | `reprint_ticket` |
| `/api/sessions/<session_id>/resend` | `POST` | `api.employees.employees_sessions.resend_ticket` | `api_app.routes.employees.sessions` | `resend_ticket` |
| `/api/sessions/<session_id>/send-ticket-email` | `POST` | `api.employees.employees_sessions.send_ticket_email` | `api_app.routes.employees.sessions` | `send_ticket_email` |
| `/api/sessions/<session_id>/ticket` | `GET` | `api.employees.employees_sessions.get_ticket` | `api_app.routes.employees.sessions` | `get_ticket` |
| `/api/sessions/<session_id>/ticket.pdf` | `GET` | `api.employees.employees_sessions.get_session_ticket_pdf` | `api_app.routes.employees.sessions` | `get_session_ticket_pdf` |
| `/api/sessions/<session_id>/tip` | `POST` | `api.employees.employees_sessions.add_tip` | `api_app.routes.employees.sessions` | `add_tip` |
| `/api/sessions/all` | `GET` | `api.employees.employees_sessions.sessions_all` | `api_app.routes.employees.sessions` | `sessions_all` |
| `/api/sessions/anonymous` | `GET` | `api.employees.employees_sessions.list_anonymous_sessions` | `api_app.routes.employees.sessions` | `list_anonymous_sessions` |
| `/api/sessions/close` | `POST` | `api.client_sessions.close` | `api_app.routes.client_sessions` | `close` |
| `/api/sessions/closed` | `GET` | `api.employees.employees_sessions.sessions_closed` | `api_app.routes.employees.sessions` | `sessions_closed` |
| `/api/sessions/me` | `GET` | `api.client_sessions.me` | `api_app.routes.client_sessions` | `me` |
| `/api/sessions/merge` | `POST` | `api.employees.employees_sessions.merge_sessions` | `api_app.routes.employees.sessions` | `merge_sessions` |
| `/api/sessions/open` | `POST` | `api.client_sessions.open_session` | `api_app.routes.client_sessions` | `open_session` |
| `/api/sessions/table-context` | `GET` | `api.client_sessions.get_table_context` | `api_app.routes.client_sessions` | `get_table_context` |
