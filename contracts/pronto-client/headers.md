## Headers canónicos para `pronto-client`

| Header | Cuándo aplica | Obligatorio | Propósito |
|---|---|---|---|
| `Content-Type: application/json` | Requests JSON | sí para body JSON | Payload JSON |
| `X-CSRFToken` | Mutaciones BFF cliente | sí en la mayoría de mutaciones | Protección CSRF |
| `X-Correlation-ID` | Trazabilidad operativa | recomendado | Observabilidad |

### Notas
- `pronto-client` actúa como SSR/BFF para flujos browser del cliente.
- Cuando el flujo termina en `pronto-api`, puede además propagar `X-PRONTO-CUSTOMER-REF` en la capa downstream.