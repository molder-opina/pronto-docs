| Event / Artifact | Producer | Consumers | Notes |
|---|---|---|---|
| `proxy:scope-request` | SSR/proxy employees | `pronto-api` | Reenvío técnico `/<scope>/api/*` sin transformación semántica |
| `scope_mismatch:403` | proxy employees | browser / observabilidad | Protección contra escalación horizontal (`jwt_role != scope`) |
| `realtime:orders` | `pronto-api` vía proxy | consolas employees | Feed realtime de órdenes consumido por la UI |
| `reports:kpis` | `pronto-api` vía proxy | consolas admin/system | KPIs operativos vía proxy scope-aware |

### Notas
- `pronto-employees` no es autoridad de negocio; documenta la capa SSR y proxy técnico hacia `pronto-api`.
- La semántica de negocio downstream sigue viviendo en `pronto-api` y `pronto-libs`.
