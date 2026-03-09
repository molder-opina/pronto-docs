## Índice por dominio de APIs de PRONTO

### Objetivo
Este documento organiza la documentación HTTP de PRONTO por dominios funcionales para facilitar navegación, testing manual e integración.

### Cómo leer este índice
- **Superficie principal** = servicio recomendado para consumir ese dominio.
- **Rutas clave** = ejemplos representativos, no inventario exhaustivo.
- **Apoyos** = documentos y colecciones ya disponibles.

### Dominios principales

| Dominio | Superficie principal | Rutas clave | Apoyos |
|---|---|---|---|
| `Auth` | `pronto-api`, `pronto-client`, `pronto-employees` | `/api/auth/login`, `/api/auth/me`, `/api/client-auth/login`, `/<scope>/login` | `pronto-api/POSTMAN_USAGE.md`, `pronto-api/INSOMNIA_USAGE.md`, `SYSTEM_ROUTES_SPEC.md` |
| `Menu` | `pronto-api`, `pronto-client` | `/api/menu`, `/api/menu-items/<id>`, `/api/menu-items/popular`, `/api/menu/categories` | `pronto-api/API_CONSUMPTION_EXAMPLES.md`, `SYSTEM_ROUTES_CATALOG.md` |
| `Orders` | `pronto-api`, `pronto-client`, `pronto-employees` | `/api/orders`, `/api/customer/orders`, `/api/orders/<id>/accept`, `/api/orders/<id>/kitchen-start` | `SYSTEM_ROUTES_MATRIX.md`, `SYSTEM_ROUTES_ENDPOINTS.md` |
| `Sessions` | `pronto-api`, `pronto-client`, `pronto-employees` | `/api/sessions/open`, `/api/sessions/me`, `/api/sessions/<id>/pay`, `/api/sessions/all` | `API_CONSUMPTION_MASTER.md`, `SYSTEM_ROUTES_SPEC.md` |
| `Payments` | `pronto-api`, `pronto-client` | `/api/customer/payments/sessions/<id>/checkout`, `/api/customer/payments/sessions/<id>/pay`, `/api/sessions/<id>/pay/stripe` | `pronto-api/POSTMAN_USAGE.md`, `pronto-api/INSOMNIA_USAGE.md` |
| `Invoices` | `pronto-api` | `/api/client/invoices`, `/api/client/invoices/request`, `/api/admin/invoices` | `SYSTEM_ROUTES_CATALOG.md`, `SYSTEM_ROUTES_ENDPOINTS.md` |
| `Reports` | `pronto-api`, `pronto-employees` | `/api/reports/kpis`, `/api/reports/sales`, `/api/reports/top-products` | `pronto-api/POSTMAN_USAGE.md`, `SYSTEM_ROUTES_MATRIX.md` |

### Dominios operativos complementarios

| Dominio | Superficie principal | Rutas clave | Apoyos |
|---|---|---|---|
| `Admin / RBAC` | `pronto-api`, `pronto-employees` | `/api/admin/permissions/system`, `/api/employees`, `/api/employees/roles`, `/admin/api/*` | `SYSTEM_ROUTES_CATALOG.md`, `SYSTEM_ROUTES_ENDPOINTS.md` |
| `Tables / Areas` | `pronto-api`, `pronto-employees` | `/api/tables`, `/api/table-assignments/*`, `/api/areas` | `SYSTEM_ROUTES_SPEC.md`, `SYSTEM_ROUTES_MATRIX.md` |
| `Notifications / Realtime` | `pronto-api` | `/api/notifications/waiter/pending`, `/api/realtime/orders`, `/api/realtime/notifications` | `SYSTEM_ROUTES_ENDPOINTS.md` |
| `Branding / Config` | `pronto-api` | `/api/branding/config`, `/api/config/public`, `/api/public/settings/<key>` | `SYSTEM_ROUTES_CATALOG.md` |

### Atajos por necesidad

| Necesidad | Documento recomendado |
|---|---|
| ver ejemplos rápidos de consumo | `pronto-api/API_CONSUMPTION_EXAMPLES.md` |
| usar Postman | `pronto-api/POSTMAN_USAGE.md` |
| usar Insomnia | `pronto-api/INSOMNIA_USAGE.md` |
| entender familias de rutas | `SYSTEM_ROUTES_SPEC.md` |
| ver auth/CSRF/actor por ruta | `SYSTEM_ROUTES_MATRIX.md` |
| ubicar módulo Python origen | `SYSTEM_ROUTES_CATALOG.md` |
| ir endpoint por endpoint | `SYSTEM_ROUTES_ENDPOINTS.md` |
| visión general de consumo | `API_CONSUMPTION_MASTER.md` |
| ver contratos de cookies/csrf/headers por dominio | `contracts/pronto-api/domain_contracts.md` |

### Fichas detalladas por dominio
- `domains/auth.md`
- `domains/menu.md`
- `domains/orders.md`
- `domains/sessions.md`
- `domains/payments.md`
- `domains/invoices.md`
- `domains/reports.md`
- `domains/admin-rbac.md`
- `domains/tables-areas.md`
- `domains/notifications-realtime.md`
- `domains/branding-config.md`

### Recomendación de uso

#### Si estás integrando backend o automatizando
- Empieza por `pronto-api`.
- Usa este índice para elegir dominio.
- Luego baja a `SYSTEM_ROUTES_SPEC.md` o `SYSTEM_ROUTES_ENDPOINTS.md` según el nivel de detalle que necesites.

#### Si estás reproduciendo el flujo del navegador
- Cliente: usa `pronto-client`.
- Employees: usa `pronto-employees` con `/<scope>/api/*`.

### Relación con las colecciones
- **Postman** e **Insomnia** ya están agrupados por: `Auth`, `Menu`, `Orders`, `Sessions`, `Payments`, `Invoices`, `Reports`, `Admin / RBAC`, `Tables / Areas`, `Notifications / Realtime`, `Branding / Config`.
- Este índice sirve como mapa documental para navegar esas agrupaciones; el inventario de `pronto-docs/routes/` sigue siendo más amplio y exhaustivo que las colecciones manuales.

### Estado actual
Este índice resume la documentación y los ejemplos ya generados en el workspace actual y debe leerse junto con `API_CONSUMPTION_MASTER.md`.