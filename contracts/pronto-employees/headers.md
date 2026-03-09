## Headers canónicos para `pronto-employees`

| Header | Cuándo aplica | Obligatorio | Propósito |
|---|---|---|---|
| `Content-Type: application/json` | Requests JSON | sí para body JSON | Payload JSON |
| `X-CSRFToken` | Mutaciones web/proxy | sí en la mayoría de mutaciones | Protección CSRF |
| `X-Correlation-ID` | Requests operativos | recomendado / obligatorio operativo | Trazabilidad |

### Notas
- El proxy `/<scope>/api/*` propaga headers relevantes hacia `pronto-api`.
- La validación de scope protege contra escalación horizontal entre consolas.