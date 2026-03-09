## Cookies observadas en `pronto-client`

| Cookie | HttpOnly | Secure | SameSite | Path | Purpose |
|---|---|---|---|---|---|
| `access_token` | true | true | Lax | `/` | Token de acceso del flujo cliente si aplica |
| `refresh_token` | true | true | Lax | `/` | Token de refresh del flujo cliente si aplica |
| `session` | true | true | Lax | `/` | Sesión Flask del cliente/BFF |

### Notas
- El flujo cliente depende mucho del contexto SSR/BFF y del `table-context`.
- No almacenar PII sensible arbitraria en sesión; respetar guardrails del proyecto.
