| Key Pattern | TTL | Owner | PII | Fields |
|---|---:|---|---|---|
| pronto:notifications:stream | n/a | pronto-libs | no | payload |
| pronto:events:stream | n/a | pronto-libs | no | payload |
| pronto:client:customer_ref:<uuid> | 60m | pronto-libs / client flow | indirecto controlado | customer_ref indirection |

### Notas
- Redis es backing store; la semántica de cada key la definen los servicios owners correspondientes.
