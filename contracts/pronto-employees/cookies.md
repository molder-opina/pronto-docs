## Cookies observadas en `pronto-employees`

| Cookie | HttpOnly | Secure | SameSite | Path | Purpose |
|---|---|---|---|---|---|
| `access_token_{scope}` | true | true | Lax | `/<scope>` | JWT access namespaced por consola |
| `refresh_token_{scope}` | true | true | Lax | `/<scope>` | Refresh token namespaced por consola |

### Notas
- El namespacing por scope ayuda a aislar `waiter`, `chef`, `cashier`, `admin` y `system`.
- El proxy usa estas cookies para reenviar auth hacia `pronto-api`.
