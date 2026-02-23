# Mesa Obligatoria en Confirmacion (Tab Detalles)

## Objetivo

Hacer obligatoria la mesa solo al confirmar la orden en el tab `Detalles`, manteniendo el sitio agnostico de mesa hasta ese momento.

## Reglas aplicadas

- `table_id` no se guarda en `flask.session`.
- Persistencia de mesa en `customer_session_store` (Redis payload de sesion cliente).
- Prioridad de resolucion: `kiosk > qr > manual`.
- Gate server-side obligatorio antes de crear orden.

## Cambios principales

- Nuevo resolver compartido de contexto de mesa en BFF:
  - `pronto-client/src/pronto_clients/routes/api/table_context.py`
- Gate de mesa en `POST /api/orders` (BFF cliente).
- Nuevo endpoint de contexto:
  - `GET /api/sessions/table-context`
  - `POST /api/sessions/table-context`
- Refuerzo de validacion en `POST /api/customer/orders` (pronto-api).
- UI del tab `Detalles` con combo de mesa y lock por origen (`qr|kiosk`).
- Eliminacion de fallback implicito de primera mesa activa en `SessionManager`.

## Codigos de error

- `TABLE_REQUIRED`
- `TABLE_LOCKED_BY_QR`
- `KIOSK_TABLE_NOT_CONFIGURED`

## Resultado

La orden no se crea sin `table_id`, y toda orden confirmada envia `table_id` canonico al API.
