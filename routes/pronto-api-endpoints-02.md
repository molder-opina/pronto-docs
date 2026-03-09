## Rutas endpoint por endpoint de `pronto-api` (parte 2)

Parte 2 del inventario crudo generado desde `app.url_map`.

| Ruta | Métodos | Endpoint Flask | Módulo | Función |
|---|---|---|---|---|
| `/api/client/invoices/<invoice_id>` | `GET` | `api.invoices.get_invoice` | `api_app.routes.invoices` | `get_invoice` |
| `/api/client/invoices/<invoice_id>/cancel` | `POST` | `api.invoices.cancel_invoice` | `api_app.routes.invoices` | `cancel_invoice` |
| `/api/client/invoices/<invoice_id>/email` | `POST` | `api.invoices.send_invoice_email` | `api_app.routes.invoices` | `send_invoice_email` |
| `/api/client/invoices/<invoice_id>/pdf` | `GET` | `api.invoices.download_invoice_pdf` | `api_app.routes.invoices` | `download_invoice_pdf` |
| `/api/client/invoices/<invoice_id>/xml` | `GET` | `api.invoices.download_invoice_xml` | `api_app.routes.invoices` | `download_invoice_xml` |
| `/api/client/invoices/request` | `POST` | `api.invoices.request_invoice` | `api_app.routes.invoices` | `request_invoice` |
| `/api/client/invoices/sat-catalogs` | `GET` | `api.invoices.get_sat_catalogs` | `api_app.routes.invoices` | `get_sat_catalogs` |
| `/api/config` | `GET` | `api.config_api.list_config` | `api_app.routes.config` | `list_config` |
| `/api/config` | `GET` | `api.employees.employees_config.get_config` | `api_app.routes.employees.config` | `get_config` |
| `/api/config/<string:config_id>` | `PUT` | `api.config_api.update_config` | `api_app.routes.config` | `update_config` |
| `/api/config/<string:config_id>` | `PUT` | `api.employees.employees_config.update_config` | `api_app.routes.employees.config` | `update_config` |
| `/api/config/<string:config_key>` | `GET` | `api.config_api.get_config_key` | `api_app.routes.config` | `get_config_key` |
| `/api/config/<string:config_key>` | `GET` | `api.employees.employees_config.get_config_key` | `api_app.routes.employees.config` | `get_config_key` |
| `/api/config/client_session_validation_interval_minutes` | `GET` | `api.config_api.client_session_validation_interval_minutes` | `api_app.routes.config` | `client_session_validation_interval_minutes` |
| `/api/config/client_session_validation_interval_minutes` | `GET` | `api.employees.employees_config.client_session_validation_interval_minutes` | `api_app.routes.employees.config` | `client_session_validation_interval_minutes` |
| `/api/config/public` | `GET` | `api.config_api.get_public_config` | `api_app.routes.config` | `get_public_config` |
| `/api/config/public` | `GET` | `api.employees.employees_config.get_public_config` | `api_app.routes.employees.config` | `get_public_config` |
| `/api/config/store_cancel_reason` | `GET` | `api.config_api.store_cancel_reason` | `api_app.routes.config` | `store_cancel_reason` |
| `/api/config/store_cancel_reason` | `GET` | `api.employees.employees_config.store_cancel_reason` | `api_app.routes.employees.config` | `store_cancel_reason` |
| `/api/constants/payment/methods` | `GET` | `api.constants.get_payment_methods` | `api_app.routes.constants` | `get_payment_methods` |
| `/api/constants/payment/statuses` | `GET` | `api.constants.get_payment_statuses` | `api_app.routes.constants` | `get_payment_statuses` |
| `/api/constants/workflow/statuses` | `GET` | `api.constants.get_workflow_statuses` | `api_app.routes.constants` | `get_workflow_statuses` |
| `/api/constants/workflow/transitions` | `GET` | `api.constants.get_workflow_transitions` | `api_app.routes.constants` | `get_workflow_transitions` |
| `/api/customer/orders` | `GET` | `api.customers_root.customer_orders.list_customer_orders` | `api_app.routes.customers.orders` | `list_customer_orders` |
| `/api/customer/orders` | `POST` | `api.customers_root.customer_orders.create_customer_order` | `api_app.routes.customers.orders` | `create_customer_order` |
| `/api/customer/orders/<path:order_id>` | `GET` | `api.customers_root.customer_orders.get_customer_order` | `api_app.routes.customers.orders` | `get_customer_order` |
| `/api/customer/orders/session/<session_id>` | `GET` | `api.customers_root.customer_orders.get_session_details` | `api_app.routes.customers.orders` | `get_session_details` |
| `/api/customer/orders/session/<session_id>/feedback` | `POST` | `api.customers_root.customer_orders.submit_feedback` | `api_app.routes.customers.orders` | `submit_feedback` |
| `/api/customer/orders/session/<session_id>/request-check` | `POST` | `api.customers_root.customer_orders.request_check` | `api_app.routes.customers.orders` | `request_check` |
| `/api/customer/orders/session/<session_id>/send-ticket-email` | `POST` | `api.customers_root.customer_orders.send_ticket_email` | `api_app.routes.customers.orders` | `send_ticket_email` |
| `/api/customer/orders/session/<session_id>/ticket` | `GET` | `api.customers_root.customer_orders.get_session_ticket` | `api_app.routes.customers.orders` | `get_session_ticket` |
| `/api/customer/orders/session/<session_id>/ticket.pdf` | `GET` | `api.customers_root.customer_orders.get_session_ticket_pdf` | `api_app.routes.customers.orders` | `get_session_ticket_pdf` |
| `/api/customer/payments/sessions/<uuid:session_id>/checkout` | `GET` | `api.customer_payments.get_checkout` | `api_app.routes.payments` | `get_checkout` |
| `/api/customer/payments/sessions/<uuid:session_id>/confirm-tip` | `POST` | `api.customer_payments.confirm_tip` | `api_app.routes.payments` | `confirm_tip` |
| `/api/customer/payments/sessions/<uuid:session_id>/orders` | `GET` | `api.customer_payments.get_session_orders` | `api_app.routes.payments` | `get_session_orders` |
| `/api/customer/payments/sessions/<uuid:session_id>/pay` | `POST` | `api.customer_payments.pay_session` | `api_app.routes.payments` | `pay_session` |
| `/api/customer/payments/sessions/<uuid:session_id>/request-payment` | `POST` | `api.customer_payments.request_payment` | `api_app.routes.payments` | `request_payment` |
| `/api/customer/payments/sessions/<uuid:session_id>/stripe/intent` | `POST` | `api.customer_payments.create_stripe_intent` | `api_app.routes.payments` | `create_stripe_intent` |
| `/api/customer/payments/sessions/<uuid:session_id>/timeout` | `GET` | `api.customer_payments.get_session_timeout` | `api_app.routes.payments` | `get_session_timeout` |
| `/api/customer/payments/sessions/<uuid:session_id>/validate` | `GET` | `api.customer_payments.validate_session` | `api_app.routes.payments` | `validate_session` |
| `/api/customers/<customer_id>` | `GET` | `api.customers_root.customers.customer_detail` | `api_app.routes.customers.admin` | `customer_detail` |
| `/api/customers/<customer_id>/coupons` | `GET` | `api.customers_root.customers.customer_coupons` | `api_app.routes.customers.admin` | `customer_coupons` |
| `/api/customers/<customer_id>/orders` | `GET` | `api.customers_root.customers.customer_orders` | `api_app.routes.customers.admin` | `customer_orders` |
| `/api/customers/kiosks` | `GET` | `api.customers_root.customers.kiosks_list` | `api_app.routes.customers.admin` | `kiosks_list` |
| `/api/customers/kiosks` | `POST` | `api.customers_root.customers.kiosks_create` | `api_app.routes.customers.admin` | `kiosks_create` |
| `/api/customers/kiosks/<uuid:customer_id>` | `DELETE` | `api.customers_root.customers.kiosks_delete` | `api_app.routes.customers.admin` | `kiosks_delete` |
| `/api/customers/search` | `GET` | `api.customers_root.customers.customers_search` | `api_app.routes.customers.admin` | `customers_search` |
| `/api/split-bills/sessions/<uuid:session_id>/split-bill` | `POST` | `api.customers.customer_split_bills.create_split_bill` | `api_app.routes.customers.split_bills` | `create_split_bill` |
| `/api/split-bills/split-bills/<uuid:split_id>` | `GET` | `api.customers.customer_split_bills.get_split_bill` | `api_app.routes.customers.split_bills` | `get_split_bill` |
| `/api/split-bills/split-bills/<uuid:split_id>/assign` | `POST` | `api.customers.customer_split_bills.assign_item_to_person` | `api_app.routes.customers.split_bills` | `assign_item_to_person` |
| `/api/split-bills/split-bills/<uuid:split_id>/calculate` | `POST` | `api.customers.customer_split_bills.calculate_split_totals` | `api_app.routes.customers.split_bills` | `calculate_split_totals` |
| `/api/split-bills/split-bills/<uuid:split_id>/people/<uuid:person_id>/pay` | `POST` | `api.customers.customer_split_bills.pay_split_person` | `api_app.routes.customers.split_bills` | `pay_split_person` |
