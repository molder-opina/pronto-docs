| Key Pattern | TTL | Owner | PII | Fields |
|---|---:|---|---|---|
| pronto:events | n/a | pronto-libs | no | stream payload |
| pronto:events:stream | n/a | pronto-libs | no | event payload |
| pronto:notifications:stream | n/a | pronto-libs | no | notification payload |
| pronto:client:customer_ref:<uuid> | 60m | pronto-libs / client flow | indirecto controlado | customer_ref indirection |

### Notas
- El key `pronto:client:customer_ref:<uuid>` debe contener solo la referencia técnica permitida, no PII arbitraria.
- Los namespaces Redis compartidos deben respetar las reglas de seguridad y TTL documentadas por el proyecto.
