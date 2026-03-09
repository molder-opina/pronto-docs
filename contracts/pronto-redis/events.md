| Event / Artifact | Producer | Consumers | Notes |
|---|---|---|---|
| `pronto:events:stream` | servicios app/shared | consumers operativos | Stream general de eventos |
| `pronto:notifications:stream` | servicios app/shared | employees / notificaciones | Stream de notificaciones |
| `customer_ref_ttl` | flujo cliente/shared | API/client flow | Referencia técnica con expiración controlada |

### Notas
- Redis actúa como backing store de streams, TTL y cache; no reemplaza la autoridad de negocio persistente en PostgreSQL.
