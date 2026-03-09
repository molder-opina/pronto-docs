## Especificación de rutas del sistema PRONTO

### Objetivo
Este documento consolida las rutas web, API y proxy activas del sistema PRONTO y explica para qué se usa cada familia de rutas.

### Fuentes de verdad usadas
- `pronto-api` `url_map` en modo `PRONTO_ROUTES_ONLY=1`
- `pronto-client` `url_map` en modo `PRONTO_ROUTES_ONLY=1`
- `pronto-employees` `url_map` en modo `PRONTO_ROUTES_ONLY=1`
- `pronto-docs/contracts/pronto-api/openapi.yaml`

### Topología de rutas
- `pronto-api` (`:6082`) expone la API canónica en `/api/*` y `GET /health`.
- `pronto-client` (`:6080`) expone páginas SSR y un BFF cliente en `/api/*`.
- `pronto-employees` (`:6081`) expone páginas SSR por consola y un proxy transport-only `/<scope>/api/*`.

### Reglas de consumo
- Público permitido: `GET /health`, páginas de login/registro y `POST /api/sessions/open` con `table_id` válido.
- Mutaciones suelen requerir `X-CSRFToken`.
- Cliente directo contra `pronto-api`: usar `X-PRONTO-CUSTOMER-REF` cuando aplique.
- Employees navegador: usar `/<scope>/api/*` con scope en `waiter|chef|cashier|admin|system`.

## 1) Rutas SSR y web de `pronto-client`

### Páginas principales
- `GET /` — home SSR del cliente; entrada principal del flujo cliente autenticado.
- `GET /checkout` — pantalla SSR de checkout y pago de sesión.
- `GET /feedback` — pantalla SSR para captura de feedback.
- `GET /menu-alt` — variante SSR alternativa del menú cliente.
- `GET /kiosk/<location>` — pantalla SSR del kiosko por ubicación.
- `POST /kiosk/<location>/start` — arranca flujo de kiosko para una ubicación.
- `GET /login` — página de login cliente.
- `GET /register` — página de registro cliente.
- `GET /health` — health check del servicio cliente.

### API/BFF cliente en `pronto-client`
Estas rutas existen para SSR/browser y reenvían o encapsulan consumo hacia `pronto-api`.

#### Auth cliente
- `GET /api/client-auth/csrf` — obtiene token CSRF para formularios y fetch mutantes.
- `POST /api/client-auth/login` — login de cliente.
- `POST /api/client-auth/logout` — logout de cliente.
- `GET /api/client-auth/me` — perfil actual del cliente.
- `PUT /api/client-auth/me` — actualización del perfil actual.
- `POST /api/client-auth/register` — registro de cliente.

#### Config y bootstrap cliente
- `GET /api/config/public` — configuración pública para bootstrap UI cliente.
- `GET /api/public/config` — alias de configuración pública.
- `GET /api/config/store_cancel_reason` — configuración visible en cancelaciones.
- `GET /api/config/client_session_validation_interval_minutes` — intervalo de validación de sesión cliente.
- `GET /api/business-info` — nombre del negocio, horario y estado abierto/cerrado.

#### Menú y catálogo cliente
- `GET /api/menu` — menú completo runtime para cliente.
- `GET /api/menu/categories` — categorías del menú.
- `GET /api/menu/items` — items del menú.
- `GET /api/shortcuts` — shortcuts visibles en home/menú.
- `GET /api/tables` — mesas disponibles.
- `GET /api/tables/<uuid:table_id>` — detalle de mesa.

#### Sesiones cliente
- `POST /api/sessions/open` — abre sesión de mesa usando `table_id` válido.
- `GET /api/sessions/me` — obtiene sesión cliente actual.
- `GET /api/sessions/<uuid:session_id>/timeout` — timeout/config de expiración.
- `GET /api/sessions/table-context` — contexto de mesa persistido en sesión técnica.
- `POST /api/sessions/table-context` — guarda contexto de mesa del cliente.

#### Órdenes cliente
- `GET /api/customer/orders` — lista órdenes del cliente actual.
- `POST /api/customer/orders` — crea orden cliente por flujo canónico.
- `POST /api/customer/orders/session/<session_id>/request-check` — solicita la cuenta de la sesión.
- `POST /api/orders` — alias/compat para creación de orden.
- `GET /api/orders/<uuid:order_id>` — detalle de orden.
- `POST /api/orders/<uuid:order_id>/items` — agrega item a orden.
- `DELETE /api/orders/<uuid:order_id>/items/<uuid:item_id>` — elimina item de orden.
- `POST /api/orders/send-confirmation` — envía confirmación al cliente.

#### Feedback y notificaciones cliente
- `POST /api/feedback/questions` — obtiene preguntas de feedback a responder.
- `POST /api/feedback/bulk` — envía feedback en lote.
- `POST /api/feedback/email/<token>/submit` — envía feedback usando token de correo.
- `POST /api/orders/<uuid:order_id>/feedback/email-trigger` — dispara correo de feedback de orden.
- `GET /api/notifications` — lista notificaciones del cliente.
- `POST /api/notifications/<int:notification>/read` — marca notificación como leída.

#### Waiter calls y soporte cliente
- `POST /api/call-waiter` — levanta llamado de mesero desde cliente.
- `POST /api/cancel` — cancela llamado de mesero activo.
- `GET /api/status/<int:call>` — estado del waiter call.
- `POST /api` — crea ticket de soporte desde cliente.
- `POST /api/webhooks/stripe` — proxy técnico temporal para webhook de Stripe del lado cliente.

#### Pagos y split bills cliente
- `GET /api/methods` — métodos de pago disponibles.
- `POST /api/sessions/<uuid:session_id>/pay` — pago genérico de sesión.
- `POST /api/sessions/<uuid:session_id>/pay/cash` — pago en efectivo.
- `POST /api/sessions/<uuid:session_id>/pay/clip` — pago con Clip.
- `POST /api/sessions/<uuid:session_id>/pay/stripe` — pago con Stripe.
- `POST /api/sessions/<uuid:session_id>/split-bill` — crea división de cuenta.
- `GET /api/split-bills/<uuid:split_id>` — detalle de split bill.
- `POST /api/split-bills/<uuid:split_id>/assign` — asigna items a persona.
- `POST /api/split-bills/<uuid:split_id>/calculate` — recalcula totales del split.
- `POST /api/split-bills/<uuid:split_id>/people/<uuid:person_id>/pay` — paga parte individual.
- `GET /api/split-bills/<uuid:split_id>/summary` — resumen del split.

## 2) Rutas SSR y proxy de `pronto-employees`

### Rutas globales del portal employees
- `GET /` — landing/index del portal employees.
- `GET /login` — acceso SPA/login genérico.
- `GET /authorization-error` — pantalla de error de autorización.
- `GET /health` — health check del servicio employees.
- `GET /assets/<path:asset_path>` — passthrough de assets.
- `GET /employees` — alias SPA employees.
- `GET /employees/<path:subpath>` — alias SPA employees para subrutas.
- `GET /employees/assets/<path:asset_path>` — assets del shell employees.
- `GET /favicon.ico` — favicon.

### Rutas por consola `/{scope}`
Scopes soportados: `waiter`, `chef`, `cashier`, `admin`, `system`.

Para cada scope existen estas rutas:
- `GET /<scope>` y `GET /<scope>/` — raíz de consola, redirige/abre shell del scope.
- `GET /<scope>/login` — página de login del scope.
- `POST /<scope>/login` — login del scope.
- `GET|POST /<scope>/logout` — logout del scope.
- `GET /<scope>/dashboard` — dashboard principal del scope.
- `GET /<scope>/dashboard/<path:subpath>` — subrutas SSR/SPA del dashboard.
- `GET /<scope>/authorization-error` — error de permisos del scope.
- `DELETE|GET|PATCH|POST|PUT /<scope>/api`
- `DELETE|GET|PATCH|POST|PUT /<scope>/api/`
- `DELETE|GET|PATCH|POST|PUT /<scope>/api/<path:subpath>`

### Uso del proxy `/<scope>/api/*`
El proxy de employees se usa para:
- mantener cookies JWT namespaced por scope,
- reenviar headers de seguridad/CSRF,
- impedir escalación horizontal entre scopes,
- transportar requests hacia `pronto-api:/api/*` sin lógica de negocio.

## 3) API canónica de `pronto-api`

### Salud y bootstrap
- `GET /health` — health check canónico del backend.
- `GET /api/public/config` — configuración pública mínima para bootstrap.
- `GET /api/public/settings/<key>` — lectura pública de setting puntual.
- `GET /api/public/settings/waiter_notification_sound` — setting público de audio waiter.
- `GET /api/public/stats` — estadísticas públicas resumidas.
- `GET /api/stats/public` — alias/resumen público de stats.
- `GET /api/settings/public/<key>` — alias de settings públicos.
- `GET /api/settings/public/waiter_notification_sound` — alias de sonido waiter.

### Auth empleados
- `POST /api/auth/login` — login employee canónico por scope.
- `POST /api/auth/logout` — logout employee.
- `GET /api/auth/me` — perfil employee autenticado.
- `POST /api/auth/refresh` — refresh de token employee.
- `POST /api/auth/revoke` — revocación de token.
- `POST /api/auth/forgot-password` — recuperación de contraseña employee.
- `POST /api/auth/reset-password` — reset de contraseña employee.

### Aliases legacy de auth empleados
- `POST /api/login`
- `POST /api/logout`
- `POST /api/refresh`
- `POST /api/revoke`
- `POST /api/forgot-password`
- `POST /api/reset-password`
- `GET /api/me`
- `PUT /api/me/password`
- `GET /api/me/preferences`
- `PUT /api/me/preferences`

Se usan para compatibilidad con clientes legacy o shells antiguos.

### Auth clientes
- `POST /api/client-auth/login` — login cliente.
- `POST /api/client-auth/logout` — logout cliente.
- `GET /api/client-auth/me` — perfil actual del cliente.
- `PUT /api/client-auth/me` — actualización de perfil del cliente.
- `POST /api/client-auth/register` — registro cliente.
- `POST /api/client-auth/forgot-password` — recuperación de contraseña cliente.
- `POST /api/client-auth/reset-password` — reset de contraseña cliente.

### Configuración y parámetros
- `GET /api/config` — lista configuración del sistema.
- `PUT /api/config/<string:config_id>` — actualiza configuración por id.
- `GET /api/config/<string:config_key>` — consulta una config puntual.
- `GET /api/config/public` — configuración pública.
- `GET /api/config/store_cancel_reason` — motivo de cancelación visible en tienda.
- `GET /api/config/client_session_validation_interval_minutes` — intervalo de validación cliente.

### Constantes canónicas
- `GET /api/constants/payment/methods` — catálogo de métodos de pago.
- `GET /api/constants/payment/statuses` — catálogo de estados de pago.
- `GET /api/constants/workflow/statuses` — catálogo de estados de orden.
- `GET /api/constants/workflow/transitions` — transiciones permitidas del workflow.

### Business info y branding
- `GET /api/business-info` — datos del negocio para UI/operación.
- `POST /api/business-info` — actualiza datos del negocio.
- `POST /api/business-info/schedule` — actualiza horarios.
- `GET /api/branding/config` — configuración visual/branding.
- `PUT /api/branding/config` — actualiza branding.
- `GET /api/branding/logo` — obtiene logo actual.
- `POST /api/branding/logo` — sube logo.
- `POST /api/branding/upload/<string:asset_type>` — sube asset de branding.
- `POST /api/branding/generate/<string:asset_type>` — genera asset por IA/plantilla.
- `POST /api/branding/generate-products` — genera recursos asociados a productos.

### Menú y catálogo
- `GET /api/menu` — menú runtime completo.
- `GET /api/products` — alias del catálogo de productos.
- `GET /api/menu-items` — lista items de menú.
- `POST /api/menu-items` — crea item de menú.
- `GET /api/menu-items/<uuid:item_id>` — detalle de item.
- `PUT /api/menu-items/<uuid:item_id>` — actualiza item.
- `DELETE /api/menu-items/<uuid:item_id>` — elimina item.
- `PATCH /api/menu-items/<uuid:item_id>/preparation-time` — cambia tiempo preparación.
- `PATCH /api/menu-items/<uuid:item_id>/recommendations` — actualiza recomendación del item.
- `GET /api/menu-items/<uuid:item_id>/schedules` — horarios del item.
- `GET /api/menu-items/popular` — items populares.
- `GET /api/menu-items/recommendations` — recomendaciones.

### Taxonomía del menú
- `GET|POST /api/menu-categories` — lista/crea categorías.
- `PUT|DELETE /api/menu-categories/<uuid:category_id>` — actualiza/elimina categoría.
- `GET|POST /api/menu-subcategories` — lista/crea subcategorías.
- `PUT|DELETE /api/menu-subcategories/<uuid:subcategory_id>` — actualiza/elimina subcategoría.
- `GET|POST /api/menu-labels` — lista/crea labels.
- `PUT|DELETE /api/menu-labels/<uuid:label_id>` — actualiza/elimina label.

### Home de menú publicada
- `GET|POST /api/menu-home-modules` — lista/crea módulos de home.
- `PUT|DELETE /api/menu-home-modules/<uuid:module_id>` — actualiza/elimina módulo.
- `PUT /api/menu-home-modules/<uuid:module_id>/products` — fija productos manuales.
- `GET /api/menu-home-modules/preview` — preview de módulos no publicados.
- `GET /api/menu-home-modules/published` — snapshot publicado vigente.
- `POST /api/menu-home-modules/publish` — publica snapshot de módulos.
- `PUT /api/menu-home-modules/reorder` — reordena módulos.

### Modifiers y schedules de producto
- `GET|POST /api/modifiers` — lista/crea modifiers.
- `PUT|DELETE /api/modifiers/<uuid:modifier_id>` — actualiza/elimina modifier.
- `GET|POST /api/modifiers/groups` — lista/crea grupos de modifiers.
- `GET|PUT|DELETE /api/modifiers/groups/<uuid:group_id>` — detalle/actualización/eliminación de grupo.
- `POST /api/product-schedules` — crea schedule de producto.
- `DELETE /api/product-schedules/<int:schedule_id>` — elimina schedule.

### Órdenes employees
- `GET /api/orders` — lista órdenes operativas.
- `POST /api/orders` — crea orden desde operación.
- `GET /api/orders/<order_id>` — detalle de orden.
- `POST /api/orders/<order_id>/accept` — mesero acepta orden.
- `POST /api/orders/<order_id>/cancel` — cancela orden.
- `POST /api/orders/<order_id>/modify` — crea solicitud de modificación.
- `POST /api/orders/<order_id>/notes` — agrega notas operativas.
- `POST /api/orders/<order_id>/request-check` — solicita cuenta.
- `POST /api/orders/<order_id>/serve` — marca orden servida.
- `POST /api/orders/<order_id>/deliver` — entrega orden.
- `POST /api/orders/<order_id>/deliver-items` — entrega parcial por items.
- `POST /api/orders/<order_id>/kitchen-start` — cocina inicia preparación.
- `POST /api/orders/<order_id>/kitchen-ready` — cocina marca orden lista.
- `POST /api/orders/<order_id>/track` — seguimiento/telemetría de orden.
- `GET /api/orders/search` — búsqueda de órdenes.
- `GET /api/orders/table-rows` — vista de órdenes agregada por mesa.

### Modificaciones de orden
- `GET /api/modifications/<int:modification_id>` — consulta modificación.
- `POST /api/modifications/<int:modification_id>/approve` — aprueba modificación.
- `POST /api/modifications/<int:modification_id>/reject` — rechaza modificación.

### Órdenes y pagos cliente
- `GET|POST /api/customer/orders` — consulta/crea órdenes del cliente.
- `GET /api/customer/orders/<path:order_id>` — detalle de orden cliente.
- `GET /api/customer/orders/session/<session_id>` — detalle agregado por sesión.
- `POST /api/customer/orders/session/<session_id>/feedback` — feedback de sesión.
- `POST /api/customer/orders/session/<session_id>/request-check` — solicita cuenta.
- `POST /api/customer/orders/session/<session_id>/send-ticket-email` — envía ticket por correo.
- `GET /api/customer/orders/session/<session_id>/ticket` — ticket JSON/HTML.
- `GET /api/customer/orders/session/<session_id>/ticket.pdf` — ticket PDF.
- `GET /api/customer/payments/sessions/<uuid:session_id>/checkout` — resumen para checkout.
- `GET /api/customer/payments/sessions/<uuid:session_id>/orders` — órdenes de la sesión.
- `POST /api/customer/payments/sessions/<uuid:session_id>/request-payment` — solicita cobro.
- `POST /api/customer/payments/sessions/<uuid:session_id>/pay` — cobra sesión.
- `POST /api/customer/payments/sessions/<uuid:session_id>/confirm-tip` — confirma propina.
- `POST /api/customer/payments/sessions/<uuid:session_id>/stripe/intent` — crea intent de Stripe.
- `GET /api/customer/payments/sessions/<uuid:session_id>/timeout` — timeout del flujo pago.
- `GET /api/customer/payments/sessions/<uuid:session_id>/validate` — valida sesión antes de pagar.

### Sesiones
- `POST /api/sessions/open` — abre dining session con mesa válida.
- `GET /api/sessions/me` — sesión cliente activa.
- `GET|POST /api/sessions/table-context` — obtiene/guarda contexto de mesa.
- `POST /api/sessions/validate` — valida sesión.
- `POST /api/sessions/close` — cierre de sesión cliente/BFF.
- `GET /api/sessions/all` — lista sesiones.
- `GET /api/sessions/closed` — lista sesiones cerradas.
- `GET /api/sessions/anonymous` — sesiones anónimas/temporales aún visibles en operación.
- `POST /api/sessions/merge` — fusiona sesiones.
- `GET /api/sessions/<session_id>` — detalle de sesión.
- `DELETE /api/sessions/<session_id>/anonymous` — elimina identidad anónima asociada.
- `POST /api/sessions/<session_id>/checkout` — inicia checkout.
- `POST /api/sessions/<session_id>/close` — cierra sesión por id.
- `POST /api/sessions/<session_id>/confirm-payment` — confirma pago.
- `POST /api/sessions/<session_id>/move-to-table` — mueve sesión de mesa.
- `POST /api/sessions/<session_id>/pay` — pago administrativo/operativo.
- `POST /api/sessions/<session_id>/tip` — agrega propina.
- `POST /api/sessions/<session_id>/regenerate-anonymous` — regenera identidad anónima.
- `POST /api/sessions/<session_id>/reprint` — reimprime ticket.
- `POST /api/sessions/<session_id>/resend` — reenvía ticket.
- `POST /api/sessions/<session_id>/send-ticket-email` — envía ticket por correo.
- `GET /api/sessions/<session_id>/ticket` — ticket de sesión.
- `GET /api/sessions/<session_id>/ticket.pdf` — ticket PDF.

### Split bills
- `POST /api/split-bills/sessions/<uuid:session_id>/split-bill` — crea split desde flujo cliente.
- `GET /api/split-bills/split-bills/<uuid:split_id>` — consulta split cliente.
- `POST /api/split-bills/split-bills/<uuid:split_id>/assign` — asigna items por persona.
- `POST /api/split-bills/split-bills/<uuid:split_id>/calculate` — calcula totales cliente.
- `POST /api/split-bills/split-bills/<uuid:split_id>/people/<uuid:person_id>/pay` — pago individual cliente.
- `GET /api/split-bills/split-bills/<uuid:split_id>/summary` — resumen cliente.
- `GET /api/split-bills/sessions/<session_id>` — split operativo por sesión.
- `POST /api/split-bills/sessions/<session_id>/create` — crea split operativo.
- `POST /api/split-bills/sessions/<session_id>/calculate` — recalcula split operativo.
- `POST /api/split-bills/people/<person_id>/pay` — pago individual operativo.

### Invoices y facturación
- `GET /api/client/invoices` — lista facturas del cliente.
- `GET /api/client/invoices/<invoice_id>` — detalle de factura.
- `GET /api/client/invoices/<invoice_id>/pdf` — PDF de factura.
- `GET /api/client/invoices/<invoice_id>/xml` — XML de factura.
- `POST /api/client/invoices/<invoice_id>/cancel` — cancela factura.
- `POST /api/client/invoices/<invoice_id>/email` — envía factura por correo.
- `POST /api/client/invoices/request` — solicita factura.
- `GET /api/client/invoices/sat-catalogs` — catálogos SAT requeridos.
- `GET /api/admin/invoices` — listado admin de facturas.
- `GET /api/admin/invoices/<invoice_id>` — detalle admin de factura.
- `GET /api/admin/invoices/stats` — métricas de facturación.

### Customers, kiosks y waiter calls
- `GET /api/customers/<customer_id>` — detalle customer.
- `GET /api/customers/<customer_id>/coupons` — cupones del customer.
- `GET /api/customers/<customer_id>/orders` — órdenes del customer.
- `GET /api/customers/search` — búsqueda de customers.
- `GET /api/customers/stats` — estadísticas de customers.
- `GET|POST /api/customers/kiosks` — lista/crea customers tipo kiosko.
- `DELETE /api/customers/kiosks/<uuid:customer_id>` — elimina kiosko.
- `POST /api/waiter-calls/call-waiter` — llamado de mesero.
- `POST /api/waiter-calls/cancel` — cancelación de waiter call.
- `GET /api/waiter-calls/status/<int:call>` — estado del waiter call.

### Tables, areas y asignaciones
- `GET|POST /api/tables` — lista/crea mesas.
- `GET|PUT|DELETE /api/tables/<uuid:table_id>` — detalle/actualización/eliminación de mesa.
- `GET|POST /api/tables/tables` — alias/compat de mesas.
- `GET|PUT|DELETE /api/tables/tables/<uuid:table_id>` — alias/compat por mesa.
- `GET /api/tables/tables/<uuid:table_id>/qr` — QR de mesa.
- `GET|POST /api/areas` — lista/crea áreas.
- `PUT|DELETE /api/areas/<int:area_id>` — actualiza/elimina área integer legacy.
- `GET|POST /api/areas/areas` — alias/compat de áreas UUID.
- `PUT|DELETE /api/areas/areas/<uuid:area_id>` — detalle alias/compat de áreas.
- `POST /api/table-assignments/assign` — asigna mesa a mesero.
- `DELETE /api/table-assignments/unassign/<uuid:table_id>` — desasigna mesa.
- `GET /api/table-assignments/my-tables` — mesas del employee actual.
- `POST /api/table-assignments/check-conflicts` — valida conflictos de asignación.
- `POST /api/table-assignments/transfer-request` — crea transferencia de mesa.
- `GET /api/table-assignments/transfer-requests` — lista transferencias.
- `POST /api/table-assignments/transfer-request/<int:request_id>/accept` — acepta transferencia.
- `POST /api/table-assignments/transfer-request/<int:request_id>/reject` — rechaza transferencia.

### Employees, RBAC y administración
- `GET|POST /api/employees` — lista/crea employees.
- `GET|PUT|DELETE /api/employees/<employee_id>` — detalle/actualización/eliminación employee.
- `GET /api/employees/search` — búsqueda de employees.
- `GET|POST /api/employees/roles` — lista/crea roles.
- `GET|PUT|DELETE /api/employees/roles/<int:role_id>` — detalle/actualización/eliminación de rol.
- `PUT /api/employees/roles/<int:role_id>/permissions/bulk` — actualiza permisos en lote.
- `POST /api/employees/roles/employees/<employee_id>/revoke` — revoca rol de employee.
- `POST /api/employees/auth/login|logout|refresh|revoke` — aliases namespaced de auth employee.
- `GET /api/employees/auth/me` — alias de perfil employee.
- `GET /api/admin/permissions/system` — árbol canónico de permisos.
- `POST /api/admin/permissions/roles/<string:role_key>/add` — añade permiso a rol.
- `POST /api/admin/permissions/roles/<string:role_key>/remove` — quita permiso a rol.
- `POST /api/admin/permissions/roles/<string:role_key>/reset` — resetea permisos de rol.
- `POST /api/admin/orders/<order_id>/force-cancel` — cancelación forzada administrativa.
- `GET|POST /api/admin/shortcuts` — lista/crea shortcuts admin.
- `PUT|DELETE /api/admin/shortcuts/<int:shortcut_id>` — actualiza/elimina shortcut.

### Reports, analytics y realtime
- `GET /api/reports` — índice de reportes.
- `GET /api/reports/sales` — ventas.
- `GET /api/reports/top-products` — productos top.
- `GET /api/reports/peak-hours` — horas pico.
- `GET /api/reports/kpis` — KPIs.
- `GET /api/reports/category-performance` — desempeño por categoría.
- `GET /api/reports/customer-segments` — segmentos de clientes.
- `GET /api/reports/operational-metrics` — métricas operativas.
- `GET /api/reports/waiter-performance` — desempeño de meseros.
- `GET /api/reports/waiter-tips` — propinas de meseros.
- `GET /api/analytics/kpis|comparison|revenue-trends|operational-metrics|category-performance|customer-segments|waiter-performance` — analítica agregada.
- `GET /api/realtime/orders` — stream/long-poll de eventos de órdenes.
- `GET /api/realtime/notifications` — stream/long-poll de notificaciones.

### Notifications, feedback y soporte
- `POST /api/notifications/waiter/call` — crea waiter call desde operación.
- `GET /api/notifications/waiter/pending` — llamadas waiter pendientes.
- `POST /api/notifications/waiter/confirm/<int:call_id>` — confirma waiter call.
- `POST /api/notifications/admin/call` — crea llamado admin.
- `GET /api/notifications/admin/pending` — llamados admin pendientes.
- `POST /api/notifications/admin/confirm/<int:notification_id>` — confirma llamado admin.
- `POST /api/feedback/bulk` — feedback masivo.
- `POST /api/feedback/questions` — catálogo/preguntas de feedback.
- `GET /api/feedback/stats/overall` — resumen general de feedback.
- `GET /api/feedback/stats/top-employees` — ranking por employee.
- `POST /api/support-tickets` — crea ticket de soporte.

### Promotions, discount codes y shortcuts
- `GET|POST /api/promotions` — lista/crea promociones.
- `PUT|DELETE /api/promotions/<int:promo_id>` — actualiza/elimina promoción.
- `GET /api/discount-codes` — lista códigos de descuento.
- `DELETE /api/discount-codes/<int:code_id>` — elimina código.
- `GET /api/shortcuts` — shortcuts habilitados/operativos.

### Maintenance y debug
- `POST /api/maintenance/sessions/clean-all` — limpieza global de sesiones.
- `POST /api/maintenance/sessions/clean-inactive` — limpieza de sesiones inactivas.
- `POST /api/debug/orders/<order_id>/advance` — avanzar orden en entorno debug.
- `POST /api/debug/sessions/<uuid:session_id>/request-checkout` — simular request checkout.
- `POST /api/debug/sessions/<uuid:session_id>/simulate-payment` — simular pago.

## 4) Notas de diseño importantes

### Autoridad canónica
- La API de negocio canónica vive en `pronto-api:/api/*`.
- `pronto-client` y `pronto-employees` exponen rutas web y transporte, no autoridad de negocio.

### Duplicados y aliases presentes
El `url_map` actual expone algunas rutas duplicadas o alias por compatibilidad:
- `GET /api/menu` aparece desde dos blueprints.
- `GET /api/config*` aparece en más de una capa.
- `GET /api/shortcuts` tiene más de una implementación registrada.
- Auth employee mantiene aliases legacy (`/api/login`, `/api/logout`, etc.).

### Rutas públicas permitidas
- `GET /health`
- `POST /api/sessions/open` con `table_id` válido
- páginas `/login` y `/register` del cliente
- páginas `/<scope>/login` de employees

## 5) Recomendación de uso documental
- Usa este documento para ubicar rápidamente dónde vive una ruta y para qué existe.
- Para request/response exactos, usa `pronto-docs/contracts/pronto-api/openapi.yaml`.
- Para consumo práctico con `curl`, usa `pronto-docs/pronto-api/API_CONSUMPTION_EXAMPLES.md`.