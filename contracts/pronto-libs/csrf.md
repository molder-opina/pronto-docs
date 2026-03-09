## CSRF en `pronto-libs`

- `pronto-libs` contiene utilidades y middleware de seguridad/CSRF reutilizables.
- No define por sí mismo una superficie browser final; el enforcement ocurre en apps consumidoras.
- Las mutaciones deben seguir usando `X-CSRFToken` y el token fuente canónico de las superficies SSR.

### Referencias
- API: `../pronto-api/csrf.md`
- Cliente: `../pronto-client/csrf.md`
- Employees: `../pronto-employees/csrf.md`
