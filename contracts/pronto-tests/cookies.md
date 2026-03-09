## Cookies en `pronto-tests`

`pronto-tests` no define cookies canónicas propias; interactúa con cookies reales emitidas por las aplicaciones bajo prueba.

| Cookie | Owned by | Uso en pruebas |
|---|---|---|
| `session` | `pronto-client` / SSR | Contexto browser del cliente |
| `access_token_{scope}` | `pronto-employees` | Auth namespaced por consola |
| `refresh_token_{scope}` | `pronto-employees` | Renovación / persistencia en consolas |

### Regla
- Las pruebas deben consumir cookies reales del flujo autenticado; no inventar bypasses de sesión.
