| Path | Purpose |
|---|---|
| `README.md` | Contexto operativo del servicio Redis |
| `Makefile` | Automatización local asociada al módulo |

### Notas
- Redis se usa para streams, sesiones TTL, notificaciones y cache/locks ligeros según guardrails.
- El inventario contractual de keys vive en `pronto-docs/contracts/pronto-redis/redis-keys.md`.
