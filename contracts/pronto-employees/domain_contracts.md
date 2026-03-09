## Contratos resumidos por dominio para `pronto-employees`

| Dominio | Auth principal | CSRF | Contexto | Headers clave |
|---|---|---|---|---|
| `Auth` | login por scope + cookies namespaced | login scope permitido como excepción controlada | consola SSR | `Content-Type` |
| `Orders` | proxy scope-aware | sí en mutaciones | `access_token_{scope}` | `X-CSRFToken`, `X-Correlation-ID` |
| `Reports` | proxy scope-aware | no suele aplicar en lectura | consola autenticada | `X-Correlation-ID` |
| `Admin / RBAC` | admin/system | sí | consola admin/system | `X-CSRFToken`, `X-Correlation-ID` |
| `Tables / Areas` | employee | sí | consola operativa | `X-CSRFToken`, `X-Correlation-ID` |

### Referencia
- Para negocio canónico downstream: `../pronto-api/domain_contracts.md`