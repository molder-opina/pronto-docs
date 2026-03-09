## CSRF Canon (Employees/Admin)

- Todas las mutaciones `POST|PUT|PATCH|DELETE` a `/api/*` requieren header `X-CSRFToken`.
- El token fuente es `<meta name="csrf-token" content="...">`.
- El wrapper canónico en frontend empleados es:
  - `pronto-static/src/vue/employees/shared/core/http.ts`
- Excepciones permitidas (login scopes) se mantienen en AGENTS.md.
- Endpoints nuevos de menú (`menu-categories`, `menu-subcategories`, `menu-labels`, `menu-home-modules`, `publish`, `reorder`) están sujetos a CSRF obligatorio.

### Lectura por dominio
- `Auth`: los logins scope-aware permitidos son excepción controlada.
- `Sessions`: `POST /api/sessions/open` es excepción pública controlada; otras mutaciones sí deben respetar CSRF cuando pasan por browser/BFF.
- `Orders`: altas y mutaciones desde browser requieren `X-CSRFToken`.
- `Payments`: cobros iniciados desde browser requieren `X-CSRFToken`.
- `Admin / RBAC`, `Tables / Areas`, `Branding / Config`: todas las mutaciones operativas requieren CSRF.

### Header canónico
- `X-CSRFToken`

### Regla operacional
- Si una mutación falla por CSRF, la corrección válida es propagar el token; no se permite resolverlo con `@csrf.exempt` salvo excepciones explícitas del proyecto.
