## CSRF Canon (Employees/Admin)

- Todas las mutaciones `POST|PUT|PATCH|DELETE` a `/api/*` requieren header `X-CSRFToken`.
- El token fuente es `<meta name="csrf-token" content="...">`.
- El wrapper canónico en frontend empleados es:
  - `pronto-static/src/vue/employees/shared/core/http.ts`
- Excepciones permitidas (login scopes) se mantienen en AGENTS.md.
- Endpoints nuevos de menú (`menu-categories`, `menu-subcategories`, `menu-labels`, `menu-home-modules`, `publish`, `reorder`) están sujetos a CSRF obligatorio.
