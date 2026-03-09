## Headers canónicos de integración para `pronto-api`

| Header | Cuándo aplica | Superficie típica | Obligatorio | Propósito |
|---|---|---|---|---|
| `Content-Type: application/json` | Requests JSON | todas | sí para body JSON | Semántica de payload |
| `X-CSRFToken` | Mutaciones desde browser/BFF/proxy | `pronto-client`, `pronto-employees` | sí en la mayoría de mutaciones | Protección CSRF |
| `X-Correlation-ID` | Requests operativos y trazabilidad | todas | recomendado / obligatorio operativo | Observabilidad y correlación de logs |
| `X-PRONTO-CUSTOMER-REF` | Consumo directo cliente contra `pronto-api` | `pronto-client` o herramientas API | sí cuando aplica | Identidad técnica de cliente |
| `Authorization: Bearer <jwt>` | Consumo directo employee contra `pronto-api` | herramientas API / integraciones internas | sí para rutas protegidas employee | Auth JWT |

### Notas por dominio
- `Auth`: employees directos suelen usar `Authorization`; clientes browser pasan por login/session.
- `Sessions`: `X-PRONTO-CUSTOMER-REF` es frecuente en flujos cliente directos.
- `Orders`: mutaciones browser requieren `X-CSRFToken`; operación employee directa usa JWT.
- `Payments` / `Invoices`: suelen combinar `X-PRONTO-CUSTOMER-REF` + `X-CSRFToken`.
- `Reports` / `Admin`: priorizar `Authorization` o proxy scope-aware + `X-Correlation-ID`.