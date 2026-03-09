| Event / Artifact | Producer | Consumers | Notes |
|---|---|---|---|
| `build:clients` | Vite / npm scripts | `pronto-client`, browser | Genera assets para superficie cliente |
| `build:employees` | Vite / npm scripts | `pronto-employees`, browser | Genera assets para consolas employees |
| `publish:menu-home` | `pronto-menu-home-publish.sh` / tooling asociado | `pronto-client`, browser | Regenera `home-published.json` |
| `sync:static-content` | scripts de sync/deploy | nginx/static host | Publica artefactos compilados |

### Notas
- `pronto-static` no es la autoridad de negocio; solo compila y publica assets.
- Toda mutación de negocio termina en `:6082/api/*`; esta superficie solo consume wrappers Vue y artefactos build.
