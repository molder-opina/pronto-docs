## CSRF en `pronto-static`

- `pronto-static` no es autoridad de CSRF por sí mismo; publica frontend compilado.
- Los módulos Vue que mutan `/api/*` deben usar los wrappers oficiales y propagar `X-CSRFToken`.
- El token fuente canónico sigue siendo `<meta name="csrf-token">` en las superficies SSR que montan los assets.

### Referencias canónicas
- Cliente: `../pronto-client/csrf.md`
- Employees: `../pronto-employees/csrf.md`
- API: `../pronto-api/csrf.md`
