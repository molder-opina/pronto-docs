## Rutas endpoint por endpoint de `pronto-api` (parte 4)

Parte 4 del inventario crudo generado desde `app.url_map`.

| Ruta | Métodos | Endpoint Flask | Módulo | Función |
|---|---|---|---|---|
| `/api/menu-home-modules/preview` | `GET` | `api.employees.employees_menu_home_modules.preview_modules` | `api_app.routes.employees.menu_home_modules` | `preview_modules` |
| `/api/menu-home-modules/publish` | `POST` | `api.employees.employees_menu_home_modules.publish_modules_snapshot` | `api_app.routes.employees.menu_home_modules` | `publish_modules_snapshot` |
| `/api/menu-home-modules/published` | `GET` | `api.employees.employees_menu_home_modules.published_snapshot` | `api_app.routes.employees.menu_home_modules` | `published_snapshot` |
| `/api/menu-home-modules/reorder` | `PUT` | `api.employees.employees_menu_home_modules.reorder_modules` | `api_app.routes.employees.menu_home_modules` | `reorder_modules` |
| `/api/menu-items` | `GET` | `api.menu.get_menu` | `api_app.routes.menu` | `get_menu` |
| `/api/menu-items` | `POST` | `api.employees.employees_menu_items.create_menu_item` | `api_app.routes.employees.menu_items` | `create_menu_item` |
| `/api/menu-items/<uuid:item_id>` | `DELETE` | `api.employees.employees_menu_items.delete_menu_item` | `api_app.routes.employees.menu_items` | `delete_menu_item` |
| `/api/menu-items/<uuid:item_id>` | `GET` | `api.menu.get_item_detail` | `api_app.routes.menu` | `get_item_detail` |
| `/api/menu-items/<uuid:item_id>` | `PUT` | `api.employees.employees_menu_items.update_menu_item` | `api_app.routes.employees.menu_items` | `update_menu_item` |
| `/api/menu-items/<uuid:item_id>/preparation-time` | `PATCH` | `api.employees.employees_menu_items.update_preparation_time` | `api_app.routes.employees.menu_items` | `update_preparation_time` |
| `/api/menu-items/<uuid:item_id>/recommendations` | `PATCH` | `api.employees.employees_menu_items.update_recommendations` | `api_app.routes.employees.menu_items` | `update_recommendations` |
| `/api/menu-items/<uuid:item_id>/schedules` | `GET` | `api.employees.employees_menu_items.get_item_schedules` | `api_app.routes.employees.menu_items` | `get_item_schedules` |
| `/api/menu-items/popular` | `GET` | `api.menu.get_popular_items` | `api_app.routes.menu` | `get_popular_items` |
| `/api/menu-items/recommendations` | `GET` | `api.menu.get_recommendations` | `api_app.routes.menu` | `get_recommendations` |
| `/api/menu-labels` | `GET` | `api.employees.employees_menu_labels.list_labels` | `api_app.routes.employees.menu_labels` | `list_labels` |
| `/api/menu-labels` | `POST` | `api.employees.employees_menu_labels.create_label` | `api_app.routes.employees.menu_labels` | `create_label` |
| `/api/menu-labels/<uuid:label_id>` | `DELETE` | `api.employees.employees_menu_labels.delete_label` | `api_app.routes.employees.menu_labels` | `delete_label` |
| `/api/menu-labels/<uuid:label_id>` | `PUT` | `api.employees.employees_menu_labels.update_label` | `api_app.routes.employees.menu_labels` | `update_label` |
| `/api/menu-subcategories` | `GET` | `api.employees.employees_menu_subcategories.list_subcategories` | `api_app.routes.employees.menu_subcategories` | `list_subcategories` |
| `/api/menu-subcategories` | `POST` | `api.employees.employees_menu_subcategories.create_subcategory` | `api_app.routes.employees.menu_subcategories` | `create_subcategory` |
| `/api/menu-subcategories/<uuid:subcategory_id>` | `DELETE` | `api.employees.employees_menu_subcategories.delete_subcategory` | `api_app.routes.employees.menu_subcategories` | `delete_subcategory` |
| `/api/menu-subcategories/<uuid:subcategory_id>` | `PUT` | `api.employees.employees_menu_subcategories.update_subcategory` | `api_app.routes.employees.menu_subcategories` | `update_subcategory` |
| `/api/modifications/<int:modification_id>` | `GET` | `api.orders.get_modification_endpoint` | `api_app.routes.orders` | `get_modification_endpoint` |
| `/api/modifications/<int:modification_id>/approve` | `POST` | `api.orders.approve_modification_endpoint` | `api_app.routes.orders` | `approve_modification_endpoint` |
| `/api/modifications/<int:modification_id>/reject` | `POST` | `api.orders.reject_modification_endpoint` | `api_app.routes.orders` | `reject_modification_endpoint` |
| `/api/modifiers` | `GET` | `api.employees.employees_modifiers.list_modifiers` | `api_app.routes.employees.modifiers` | `list_modifiers` |
| `/api/modifiers` | `POST` | `api.employees.employees_modifiers.create_modifier` | `api_app.routes.employees.modifiers` | `create_modifier` |
| `/api/modifiers/<uuid:modifier_id>` | `DELETE` | `api.employees.employees_modifiers.delete_modifier` | `api_app.routes.employees.modifiers` | `delete_modifier` |
| `/api/modifiers/<uuid:modifier_id>` | `PUT` | `api.employees.employees_modifiers.update_modifier` | `api_app.routes.employees.modifiers` | `update_modifier` |
| `/api/modifiers/groups` | `GET` | `api.employees.employees_modifiers.list_modifier_groups` | `api_app.routes.employees.modifiers` | `list_modifier_groups` |
| `/api/modifiers/groups` | `POST` | `api.employees.employees_modifiers.create_modifier_group` | `api_app.routes.employees.modifiers` | `create_modifier_group` |
| `/api/modifiers/groups/<uuid:group_id>` | `DELETE` | `api.employees.employees_modifiers.delete_modifier_group` | `api_app.routes.employees.modifiers` | `delete_modifier_group` |
| `/api/modifiers/groups/<uuid:group_id>` | `GET` | `api.employees.employees_modifiers.get_modifier_group` | `api_app.routes.employees.modifiers` | `get_modifier_group` |
| `/api/modifiers/groups/<uuid:group_id>` | `PUT` | `api.employees.employees_modifiers.update_modifier_group` | `api_app.routes.employees.modifiers` | `update_modifier_group` |
| `/api/notifications/admin/call` | `POST` | `api.employees.employees_notifications.admin_call` | `api_app.routes.employees.notifications` | `admin_call` |
| `/api/notifications/admin/confirm/<int:notification_id>` | `POST` | `api.employees.employees_notifications.confirm_admin_call` | `api_app.routes.employees.notifications` | `confirm_admin_call` |
| `/api/notifications/admin/pending` | `GET` | `api.employees.employees_notifications.list_admin_calls_pending` | `api_app.routes.employees.notifications` | `list_admin_calls_pending` |
| `/api/notifications/waiter/call` | `POST` | `api.notifications.notification_waiter_call` | `api_app.routes.notifications` | `notification_waiter_call` |
| `/api/notifications/waiter/confirm/<int:call_id>` | `POST` | `api.employees.employees_notifications.confirm_waiter_call_route` | `api_app.routes.employees.notifications` | `confirm_waiter_call_route` |
| `/api/notifications/waiter/pending` | `GET` | `api.employees.employees_notifications.get_pending_notifications` | `api_app.routes.employees.notifications` | `get_pending_notifications` |
| `/api/orders` | `GET` | `api.employees.employees_orders.list_orders` | `api_app.routes.employees.orders` | `list_orders` |
| `/api/orders` | `POST` | `api.employees.employees_orders.create_order` | `api_app.routes.employees.orders` | `create_order` |
| `/api/orders/<order_id>` | `GET` | `api.employees.employees_orders.get_order_detail` | `api_app.routes.employees.orders` | `get_order_detail` |
| `/api/orders/<order_id>/accept` | `POST` | `api.employees.employees_orders.accept_order` | `api_app.routes.employees.orders` | `accept_order` |
| `/api/orders/<order_id>/cancel` | `POST` | `api.employees.employees_orders.cancel_order_endpoint` | `api_app.routes.employees.orders` | `cancel_order_endpoint` |
| `/api/orders/<order_id>/deliver` | `POST` | `api.employees.employees_orders.deliver_order_endpoint` | `api_app.routes.employees.orders` | `deliver_order_endpoint` |
| `/api/orders/<order_id>/deliver-items` | `POST` | `api.employees.employees_orders.deliver_items` | `api_app.routes.employees.orders` | `deliver_items` |
| `/api/orders/<order_id>/kitchen-ready` | `POST` | `api.employees.employees_orders.kitchen_ready` | `api_app.routes.employees.orders` | `kitchen_ready` |
| `/api/orders/<order_id>/kitchen-start` | `POST` | `api.employees.employees_orders.kitchen_start` | `api_app.routes.employees.orders` | `kitchen_start` |
| `/api/orders/<order_id>/modify` | `POST` | `api.employees.employees_orders.modify_order_endpoint` | `api_app.routes.employees.orders` | `modify_order_endpoint` |
| `/api/orders/<order_id>/notes` | `POST` | `api.employees.employees_orders.add_notes` | `api_app.routes.employees.orders` | `add_notes` |
| `/api/orders/<order_id>/request-check` | `POST` | `api.employees.employees_orders.request_check` | `api_app.routes.employees.orders` | `request_check` |
