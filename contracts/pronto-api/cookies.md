| Cookie | HttpOnly | Secure | SameSite | Path | Purpose |
|---|---|---|---|---|---|
| `access_token_{scope}` | true | true | Lax | `/<scope>` | JWT de consola empleados (`waiter|chef|cashier|admin|system`) |
| `refresh_token_{scope}` | true | true | Lax | `/<scope>` | Renovación JWT por scope |
| `session` | true | true | Lax | `/` | Sesión técnica SSR; no contiene PII de empleados |
