## Contratos resumidos por dominio para `pronto-client`

| Dominio | Auth principal | CSRF | Contexto | Headers clave |
|---|---|---|---|---|
| `Auth` | sesión cliente/BFF | sí en mutaciones | cookies + sesión SSR | `X-CSRFToken` |
| `Menu` | lectura browser | no en GET | sesión opcional | `X-Correlation-ID` |
| `Sessions` | contexto de mesa y sesión activa | sí en mutaciones | `session` + table context | `X-CSRFToken` |
| `Orders` | cliente autenticado | sí | sesión activa + mesa | `X-CSRFToken` |
| `Payments` | cliente autenticado | sí | sesión checkout | `X-CSRFToken` |

### Referencia
- Para contratos canónicos de negocio: `../pronto-api/domain_contracts.md`