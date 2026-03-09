| Event | Producer | Consumers | Payload Schema | Version |
|---|---|---|---|---|
| customers.waiter_call | pronto-libs | pronto-employees | JSON (see socketio_manager) | v1 |
| admin.call | pronto-libs | pronto-employees | JSON (see socketio_manager) | v1 |
| orders.new | pronto-libs | pronto-employees | JSON (see socketio_manager) | v1 |
| orders.status_changed | pronto-libs | pronto-employees | JSON (see socketio_manager) | v1 |

### Notas
- `pronto-libs` define y reutiliza contratos de eventos consumidos por aplicaciones superiores.
- Las apps (`pronto-api`, `pronto-employees`, etc.) son las que disparan y consumen estos eventos a nivel de runtime; la librería compartida provee utilidades y contratos.
