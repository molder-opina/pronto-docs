| Event | Producer | Consumers | Payload Schema | Version |
|---|---|---|---|---|
| `orders.new` | `pronto-client` | `pronto-employees` | JSON (order workflow) | v1 |
| `cart.updated` (frontend local) | `pronto-static` client | UI modules cliente | `{count,total}` | v1 |

Notas:
- La homepage cliente publicada se consume como snapshot estático; no depende de eventos runtime.
