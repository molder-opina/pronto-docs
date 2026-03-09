## Matriz operativa de rutas del sistema PRONTO

### Objetivo
Esta matriz resume las rutas más importantes del sistema en formato operativo: quién las usa, qué auth requieren, si exigen CSRF y para qué sirven.

### Lectura rápida
- **Servicio**: dónde vive la ruta (`pronto-api`, `pronto-client`, `pronto-employees`).
- **Tipo**: `web`, `api`, `bff`, `proxy`.
- **Auth**: `pública`, `cliente`, `employee(scope)`, `admin/system`.
- **CSRF**: `sí`, `no`, `según método`.

## 1) Rutas web SSR / UI

| Ruta / patrón | Método | Servicio | Tipo | Auth | CSRF | Actor | Uso |
|---|---|---|---|---|---|---|---|
| `/` | GET | `pronto-client` | web | cliente | no | customer | Home SSR del cliente autenticado |
| `/checkout` | GET | `pronto-client` | web | cliente | no | customer | Pantalla de checkout y pago |
| `/feedback` | GET | `pronto-client` | web | cliente | no | customer | Pantalla SSR de feedback |
| `/menu-alt` | GET | `pronto-client` | web | cliente | no | customer | Variante SSR del menú |
| `/kiosk/<location>` | GET | `pronto-client` | web | kiosko/cliente | no | kiosko | Pantalla de kiosko por ubicación |
| `/kiosk/<location>/start` | POST | `pronto-client` | web | kiosko/cliente | sí | kiosko | Arranque del flujo kiosko |
| `/login` | GET | `pronto-client` | web | pública | no | customer | Página de login cliente |
| `/register` | GET | `pronto-client` | web | pública | no | customer | Página de registro cliente |
| `/<scope>` | GET | `pronto-employees` | web | employee(scope) | no | employee | Entrada a consola por scope |
| `/<scope>/dashboard` | GET | `pronto-employees` | web | employee(scope) | no | employee | Dashboard por rol |
| `/<scope>/dashboard/<path>` | GET | `pronto-employees` | web | employee(scope) | no | employee | Subrutas SSR/SPA del dashboard |
| `/<scope>/login` | GET | `pronto-employees` | web | pública | no | employee | Página de login por scope |
| `/<scope>/login` | POST | `pronto-employees` | web | pública | no* | employee | Login por scope permitido por excepción controlada |
| `/<scope>/logout` | GET,POST | `pronto-employees` | web | employee(scope) | según método | employee | Logout por scope |
| `/authorization-error` | GET | `pronto-employees` | web | pública | no | employee | Error de autorización global |
| `/<scope>/authorization-error` | GET | `pronto-employees` | web | pública | no | employee | Error de autorización por scope |
| `/health` | GET | `pronto-client` / `pronto-employees` / `pronto-api` | web/api | pública | no | ops | Health check |

## 2) Proxy/BFF de transporte

| Ruta / patrón | Método | Servicio | Tipo | Auth | CSRF | Actor | Uso |
|---|---|---|---|---|---|---|---|
| `/<scope>/api` | DELETE,GET,PATCH,POST,PUT | `pronto-employees` | proxy | employee(scope) | sí en mutaciones | employee | Proxy scope-aware hacia `pronto-api:/api/*` |
| `/<scope>/api/<path:subpath>` | DELETE,GET,PATCH,POST,PUT | `pronto-employees` | proxy | employee(scope) | sí en mutaciones | employee | Transporte técnico sin lógica de negocio |
| `/api/business-info` | GET | `pronto-client` | bff | cliente | no | customer | BFF para business info/horario |
| `/api/menu` | GET | `pronto-client` | bff | cliente | no | customer | BFF de menú para UI cliente |
| `/api/customer/orders` | GET,POST | `pronto-client` | bff | cliente | sí en POST | customer | BFF de órdenes cliente |
| `/api/sessions/open` | POST | `pronto-client` | bff | pública controlada | no | customer | Apertura de sesión con `table_id` válido |
| `/api/sessions/<uuid:session_id>/pay/*` | POST | `pronto-client` | bff | cliente | sí | customer | BFF de pagos del cliente |

## 3) API canónica pública y bootstrap

| Ruta / patrón | Método | Servicio | Tipo | Auth | CSRF | Actor | Uso |
|---|---|---|---|---|---|---|---|
| `/health` | GET | `pronto-api` | api | pública | no | ops | Estado/vitalidad del backend |
| `/api/sessions/open` | POST | `pronto-api` | api | pública controlada | no | customer | Abre dining session con mesa válida |
| `/api/public/config` | GET | `pronto-api` | api | pública | no | customer/ui | Configuración pública de bootstrap |
| `/api/public/settings/<key>` | GET | `pronto-api` | api | pública | no | ui | Setting público puntual |
| `/api/public/settings/waiter_notification_sound` | GET | `pronto-api` | api | pública | no | ui | Sonido público waiter |
| `/api/public/stats` | GET | `pronto-api` | api | pública | no | ui | Stats resumidas públicas |
| `/api/stats/public` | GET | `pronto-api` | api | pública | no | ui | Alias de stats públicas |
| `/api/settings/public/<key>` | GET | `pronto-api` | api | pública | no | ui | Alias de settings públicos |

## 4) Auth cliente

| Ruta / patrón | Método | Servicio | Tipo | Auth | CSRF | Actor | Uso |
|---|---|---|---|---|---|---|---|
| `/api/client-auth/csrf` | GET | `pronto-client` | bff | pública | no | customer/browser | Obtener CSRF para mutaciones del cliente |
| `/api/client-auth/login` | POST | `pronto-client` / `pronto-api` | bff/api | pública | sí en BFF | customer | Login cliente |
| `/api/client-auth/logout` | POST | `pronto-client` / `pronto-api` | bff/api | cliente | sí | customer | Logout cliente |
| `/api/client-auth/me` | GET | `pronto-client` / `pronto-api` | bff/api | cliente | no | customer | Perfil actual |
| `/api/client-auth/me` | PUT | `pronto-client` / `pronto-api` | bff/api | cliente | sí | customer | Actualizar perfil |
| `/api/client-auth/register` | POST | `pronto-client` / `pronto-api` | bff/api | pública | sí en BFF | customer | Registro cliente |
| `/api/client-auth/forgot-password` | POST | `pronto-api` | api | pública | según config | customer | Recuperación de contraseña |
| `/api/client-auth/reset-password` | POST | `pronto-api` | api | pública | según config | customer | Reset de contraseña |

## 5) Auth empleados y aliases legacy

| Ruta / patrón | Método | Servicio | Tipo | Auth | CSRF | Actor | Uso |
|---|---|---|---|---|---|---|---|
| `/api/auth/login` | POST | `pronto-api` | api | pública controlada | no* | employee | Login employee por scope |
| `/api/auth/logout` | POST | `pronto-api` | api | employee | sí | employee | Logout employee |
| `/api/auth/me` | GET | `pronto-api` | api | employee | no | employee | Perfil JWT actual |
| `/api/auth/refresh` | POST | `pronto-api` | api | employee | sí | employee | Refresh token |
| `/api/auth/revoke` | POST | `pronto-api` | api | employee | sí | employee | Revocación |
| `/api/auth/forgot-password` | POST | `pronto-api` | api | pública | no/según config | employee | Recuperación de contraseña |
| `/api/auth/reset-password` | POST | `pronto-api` | api | pública | no/según config | employee | Reset de contraseña |
| `/api/login`, `/api/logout`, `/api/refresh`, `/api/revoke` | POST | `pronto-api` | api | employee/compat | según método | employee | Aliases legacy compatibles |
| `/api/me` | GET | `pronto-api` | api | employee | no | employee | Alias de perfil |
| `/api/me/password` | PUT | `pronto-api` | api | employee | sí | employee | Cambio de contraseña propia |
| `/api/me/preferences` | GET,PUT | `pronto-api` | api | employee | PUT sí | employee | Preferencias propias |

## 6) Config, business info y branding

| Ruta / patrón | Método | Servicio | Tipo | Auth | CSRF | Actor | Uso |
|---|---|---|---|---|---|---|---|
| `/api/config` | GET | `pronto-api` | api | employee | no | employee/admin | Listado de configuración |
| `/api/config/<string:key>` | GET | `pronto-api` | api | employee | no | employee/admin | Obtener config puntual |
| `/api/config/<string:id>` | PUT | `pronto-api` | api | admin/system | sí | admin/system | Actualizar configuración |
| `/api/config/public` | GET | `pronto-api` / `pronto-client` | api/bff | pública o cliente | no | ui | Config pública consumible |
| `/api/config/store_cancel_reason` | GET | `pronto-api` / `pronto-client` | api/bff | cliente/employee | no | ui | Motivo de cancelación visible |
| `/api/config/client_session_validation_interval_minutes` | GET | `pronto-api` / `pronto-client` | api/bff | cliente/employee | no | ui | Intervalo de validación sesión |
| `/api/business-info` | GET | `pronto-api` / `pronto-client` | api/bff | employee en API, cliente en BFF | no | customer/employee | Datos del negocio y horario |
| `/api/business-info` | POST | `pronto-api` | api | admin/system | sí | admin/system | Actualizar negocio |
| `/api/business-info/schedule` | POST | `pronto-api` | api | admin/system | sí | admin/system | Actualizar horario |
| `/api/branding/*` | GET,POST,PUT | `pronto-api` | api | admin/system | sí en mutaciones | admin/system | Branding, logos y assets |

## 7) Menú, catálogo y shortcuts

| Ruta / patrón | Método | Servicio | Tipo | Auth | CSRF | Actor | Uso |
|---|---|---|---|---|---|---|---|
| `/api/menu` | GET | `pronto-api` / `pronto-client` | api/bff | cliente o employee | no | customer/employee | Menú runtime |
| `/api/products` | GET | `pronto-api` | api | employee/cliente según flujo | no | ui | Alias de catálogo |
| `/api/menu-items` | GET,POST | `pronto-api` | api | GET cliente/employee, POST employee | POST sí | customer/employee | Listar/crear items |
| `/api/menu-items/<uuid:item_id>` | GET,PUT,DELETE | `pronto-api` | api | employee | mutaciones sí | employee | CRUD de item |
| `/api/menu-items/<uuid:item_id>/preparation-time` | PATCH | `pronto-api` | api | employee | sí | employee | Ajustar tiempo de preparación |
| `/api/menu-items/<uuid:item_id>/recommendations` | PATCH | `pronto-api` | api | employee | sí | employee | Ajustar recomendaciones |
| `/api/menu-items/<uuid:item_id>/schedules` | GET | `pronto-api` | api | employee | no | employee | Horarios del item |
| `/api/menu-items/popular` | GET | `pronto-api` | api | cliente | no | customer | Productos populares |
| `/api/menu-items/recommendations` | GET | `pronto-api` | api | cliente | no | customer | Recomendaciones de menú |
| `/api/menu/categories` | GET | `pronto-client` | bff | cliente | no | customer | Categorías para UI cliente |
| `/api/menu/items` | GET | `pronto-client` | bff | cliente | no | customer | Items para UI cliente |
| `/api/menu-categories` | GET,POST | `pronto-api` | api | employee | POST sí | employee | CRUD categorías |
| `/api/menu-subcategories` | GET,POST | `pronto-api` | api | employee | POST sí | employee | CRUD subcategorías |
| `/api/menu-labels` | GET,POST | `pronto-api` | api | employee | POST sí | employee | CRUD labels |
| `/api/shortcuts` | GET | `pronto-api` / `pronto-client` | api/bff | cliente/employee | no | ui | Shortcuts visibles/habilitados |
| `/api/menu-home-modules*` | GET,POST,PUT,DELETE | `pronto-api` | api | employee/admin | mutaciones sí | admin/content | Home modules del menú |

## 8) Órdenes cliente y employee

| Ruta / patrón | Método | Servicio | Tipo | Auth | CSRF | Actor | Uso |
|---|---|---|---|---|---|---|---|
| `/api/customer/orders` | GET,POST | `pronto-api` / `pronto-client` | api/bff | cliente | POST sí | customer | Listar/crear órdenes cliente |
| `/api/customer/orders/<path:order_id>` | GET | `pronto-api` | api | cliente | no | customer | Detalle de orden cliente |
| `/api/customer/orders/session/<session_id>/request-check` | POST | `pronto-api` / `pronto-client` | api/bff | cliente | sí | customer | Solicitar cuenta |
| `/api/customer/orders/session/<session_id>/feedback` | POST | `pronto-api` | api | cliente | sí | customer | Feedback por sesión |
| `/api/customer/orders/session/<session_id>/ticket` | GET | `pronto-api` | api | cliente | no | customer | Ticket de sesión |
| `/api/customer/orders/session/<session_id>/ticket.pdf` | GET | `pronto-api` | api | cliente | no | customer | Ticket PDF |
| `/api/orders` | GET,POST | `pronto-api` | api | employee | POST sí | employee | Listado/creación operativa |
| `/api/orders/<order_id>` | GET | `pronto-api` | api | employee | no | employee | Detalle de orden |
| `/api/orders/<order_id>/accept` | POST | `pronto-api` | api | waiter/admin | sí | waiter | Aceptar orden |
| `/api/orders/<order_id>/cancel` | POST | `pronto-api` | api | waiter/admin/system | sí | employee | Cancelar orden |
| `/api/orders/<order_id>/kitchen-start` | POST | `pronto-api` | api | chef | sí | chef | Iniciar preparación |
| `/api/orders/<order_id>/kitchen-ready` | POST | `pronto-api` | api | chef | sí | chef | Marcar orden lista |
| `/api/orders/<order_id>/serve` | POST | `pronto-api` | api | waiter | sí | waiter | Marcar orden servida |
| `/api/orders/<order_id>/deliver` | POST | `pronto-api` | api | waiter | sí | waiter | Entregar orden |
| `/api/orders/<order_id>/deliver-items` | POST | `pronto-api` | api | waiter | sí | waiter | Entrega parcial |
| `/api/orders/<order_id>/modify` | POST | `pronto-api` | api | employee | sí | employee | Solicitar modificación |
| `/api/orders/<order_id>/notes` | POST | `pronto-api` | api | employee | sí | employee | Agregar notas |
| `/api/orders/<order_id>/track` | POST | `pronto-api` | api | employee | sí | employee | Seguimiento/telemetría |
| `/api/orders/search` | GET | `pronto-api` | api | employee | no | employee | Búsqueda |
| `/api/orders/table-rows` | GET | `pronto-api` | api | employee | no | employee | Vista agregada por mesa |

## 9) Sesiones, pagos, split bills e invoices

| Ruta / patrón | Método | Servicio | Tipo | Auth | CSRF | Actor | Uso |
|---|---|---|---|---|---|---|---|
| `/api/sessions/open` | POST | `pronto-api` / `pronto-client` | api/bff | pública controlada | no | customer | Abrir sesión de mesa |
| `/api/sessions/me` | GET | `pronto-api` / `pronto-client` | api/bff | cliente | no | customer | Sesión actual |
| `/api/sessions/table-context` | GET,POST | `pronto-api` / `pronto-client` | api/bff | cliente | POST sí | customer | Contexto de mesa |
| `/api/sessions/validate` | POST | `pronto-api` | api | cliente | sí | customer | Validación de sesión |
| `/api/sessions/<session_id>/*` | GET,POST,DELETE | `pronto-api` | api | employee o cliente según endpoint | mutaciones sí | mixed | Gestión completa de sesiones |
| `/api/customer/payments/sessions/<uuid:session_id>/checkout` | GET | `pronto-api` | api | cliente | no | customer | Resumen de checkout |
| `/api/customer/payments/sessions/<uuid:session_id>/pay` | POST | `pronto-api` | api | cliente | sí | customer | Pago de sesión |
| `/api/customer/payments/sessions/<uuid:session_id>/request-payment` | POST | `pronto-api` | api | cliente | sí | customer | Solicitud de cobro |
| `/api/customer/payments/sessions/<uuid:session_id>/confirm-tip` | POST | `pronto-api` | api | cliente | sí | customer | Confirmar propina |
| `/api/customer/payments/sessions/<uuid:session_id>/stripe/intent` | POST | `pronto-api` | api | cliente | sí | customer | Crear payment intent |
| `/api/sessions/<uuid:session_id>/pay` | POST | `pronto-client` | bff | cliente | sí | customer | Pago genérico desde cliente |
| `/api/sessions/<uuid:session_id>/pay/cash` | POST | `pronto-client` | bff | cliente | sí | customer | Pago cash |
| `/api/sessions/<uuid:session_id>/pay/clip` | POST | `pronto-client` | bff | cliente | sí | customer | Pago Clip |
| `/api/sessions/<uuid:session_id>/pay/stripe` | POST | `pronto-client` | bff | cliente | sí | customer | Pago Stripe |
| `/api/split-bills/*` | GET,POST | `pronto-client` / `pronto-api` | bff/api | cliente | POST sí | customer | Flujo de split bills cliente |
| `/api/waiter-calls/*` | GET,POST | `pronto-api` | api | cliente | POST sí | customer | Waiter calls canónico cliente |
| `/api/client/invoices` | GET | `pronto-api` | api | cliente | no | customer | Listar facturas |
| `/api/client/invoices/request` | POST | `pronto-api` | api | cliente | sí | customer | Solicitar factura |
| `/api/client/invoices/<invoice_id>/pdf` | GET | `pronto-api` | api | cliente | no | customer | Descargar PDF |
| `/api/client/invoices/<invoice_id>/xml` | GET | `pronto-api` | api | cliente | no | customer | Descargar XML |
| `/api/client/invoices/<invoice_id>/cancel` | POST | `pronto-api` | api | cliente/admin | sí | customer/admin | Cancelar factura |

## 10) Operación: mesas, áreas, employees, reports, feedback

| Ruta / patrón | Método | Servicio | Tipo | Auth | CSRF | Actor | Uso |
|---|---|---|---|---|---|---|---|
| `/api/tables*` | GET,POST,PUT,DELETE | `pronto-api` | api | employee | mutaciones sí | employee | CRUD y QR de mesas |
| `/api/areas*` | GET,POST,PUT,DELETE | `pronto-api` | api | employee | mutaciones sí | employee | CRUD de áreas |
| `/api/table-assignments/*` | GET,POST,DELETE | `pronto-api` | api | waiter/admin | mutaciones sí | employee | Asignación/transferencia de mesas |
| `/api/employees*` | GET,POST,PUT,DELETE | `pronto-api` | api | admin/system | mutaciones sí | admin/system | CRUD employees y roles |
| `/api/admin/permissions/*` | GET,POST | `pronto-api` | api | admin/system | POST sí | admin/system | Gestión RBAC |
| `/api/admin/shortcuts*` | GET,POST,PUT,DELETE | `pronto-api` | api | admin/system | mutaciones sí | admin/system | Shortcuts administrativos |
| `/api/admin/invoices*` | GET | `pronto-api` | api | admin/system | no | admin/system | Facturación administrativa |
| `/api/analytics/*` | GET | `pronto-api` | api | employee/admin | no | employee/admin | Analítica agregada |
| `/api/reports*` | GET | `pronto-api` | api | employee/admin | no | employee/admin | Reportes operativos y financieros |
| `/api/feedback/questions` | POST | `pronto-api` / `pronto-client` | api/bff | cliente | sí | customer | Preguntas de feedback |
| `/api/feedback/bulk` | POST | `pronto-api` / `pronto-client` | api/bff | cliente | sí | customer | Envío de feedback |
| `/api/feedback/stats/*` | GET | `pronto-api` | api | employee/admin | no | employee/admin | Estadísticas de feedback |
| `/api/notifications/*` | GET,POST | `pronto-api` / `pronto-client` | api/bff | mixed | POST sí | mixed | Notificaciones waiter/admin/cliente |
| `/api/support-tickets` | POST | `pronto-api` | api | cliente | sí | customer | Crear ticket de soporte |
| `/api/promotions*` | GET,POST,PUT,DELETE | `pronto-api` | api | admin/system | mutaciones sí | admin/system | CRUD promociones |
| `/api/discount-codes*` | GET,DELETE | `pronto-api` | api | admin/system | DELETE sí | admin/system | Códigos de descuento |

## 11) Debug, maintenance y compatibilidad

| Ruta / patrón | Método | Servicio | Tipo | Auth | CSRF | Actor | Uso |
|---|---|---|---|---|---|---|---|
| `/api/debug/orders/<order_id>/advance` | POST | `pronto-api` | api | employee dev/test | sí | qa/dev | Avanzar orden en debug |
| `/api/debug/sessions/<uuid:session_id>/request-checkout` | POST | `pronto-api` | api | employee dev/test | sí | qa/dev | Simular request checkout |
| `/api/debug/sessions/<uuid:session_id>/simulate-payment` | POST | `pronto-api` | api | employee dev/test | sí | qa/dev | Simular pago |
| `/api/maintenance/sessions/clean-all` | POST | `pronto-api` | api | admin/system | sí | ops/admin | Limpieza global de sesiones |
| `/api/maintenance/sessions/clean-inactive` | POST | `pronto-api` | api | admin/system | sí | ops/admin | Limpieza de sesiones inactivas |
| `/api/login`, `/api/logout`, `/api/refresh`, `/api/revoke` | POST | `pronto-api` | api | employee/compat | según método | legacy clients | Compatibilidad con clientes viejos |
| `/api/config*`, `/api/menu`, `/api/shortcuts` duplicados | GET | `pronto-api` | api | mixed | no | mixed | Aliases/duplicados aún presentes en `url_map` |

## 12) Reglas de interpretación

### CSRF
- En general, **toda mutación** (`POST`, `PUT`, `PATCH`, `DELETE`) debe enviar `X-CSRFToken`.
- Excepciones controladas: logins de consola por scope y `POST /api/sessions/open`.

### Auth
- `cliente`: sesión cliente válida o `customer_ref` canónico.
- `employee(scope)`: JWT/cookie del scope correspondiente.
- `admin/system`: alcance privilegiado del portal employees/API.

### Uso recomendado junto con otros docs
- Para descripción amplia: `pronto-docs/SYSTEM_ROUTES_SPEC.md`
- Para ejemplos `curl`: `pronto-docs/pronto-api/API_CONSUMPTION_EXAMPLES.md`
- Para contratos detallados: `pronto-docs/contracts/pronto-api/openapi.yaml`