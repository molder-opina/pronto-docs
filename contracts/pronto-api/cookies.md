## Cookies observadas en flujos relacionados con `pronto-api`

| Cookie | Superficie origen | HttpOnly | Secure | SameSite | Path | Purpose |
|---|---|---|---|---|---|---|
| `access_token_{scope}` | `pronto-employees` | true | true | Lax | `/<scope>` | JWT de consola empleados (`waiter|chef|cashier|admin|system`) |
| `refresh_token_{scope}` | `pronto-employees` | true | true | Lax | `/<scope>` | Renovación JWT por scope |
| `session` | SSR/BFF | true | true | Lax | `/` | Sesión técnica SSR; no debe contener PII sensible de empleados |

### Lectura por dominio
- `Auth`: login employees y sesión SSR/BFF.
- `Sessions`: la sesión técnica puede coexistir con el contexto de mesa/cliente.
- `Payments` / `Invoices`: dependen del contexto autenticado, no de cookies nuevas específicas en `pronto-api`.

### Notas
- Para clientes, el header `X-PRONTO-CUSTOMER-REF` es más relevante que una cookie dedicada de API.
- Para employees, el proxy scope-aware usa cookies namespaced por scope y las propaga hacia `pronto-api`.
