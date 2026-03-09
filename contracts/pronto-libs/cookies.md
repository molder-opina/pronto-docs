## Cookies en `pronto-libs`

`pronto-libs` no es owner directo de cookies de navegador; provee utilidades compartidas usadas por otras superficies.

| Cookie | Owner real | Relación con `pronto-libs` |
|---|---|---|
| `session` | `pronto-client` / SSR | Puede usar helpers/servicios shared alrededor del contexto cliente |
| `access_token_{scope}` | `pronto-employees` | JWT y helpers relacionados viven en código shared |
| `refresh_token_{scope}` | `pronto-employees` | Renovación/validación reutiliza componentes shared |

### Regla
- La autoridad contractual de cookies sigue estando en las superficies web/API que las emiten, no en la librería compartida.
