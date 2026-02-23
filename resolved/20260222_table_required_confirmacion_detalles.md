ID: ERR-20260222-TABLE-REQUIRED-DETALLES
FECHA: 2026-02-22
PROYECTO: pronto-client, pronto-api, pronto-libs
SEVERIDAD: alta
TITULO: Mesa obligatoria faltante al confirmar orden en tab Detalles
DESCRIPCION: Actualmente el flujo permite llegar a confirmacion sin enforcement robusto de mesa en tab Detalles. Se requiere resolver y bloquear server-side cuando no exista table_id y aplicar lock cuando la mesa proviene de QR.
PASOS_REPRODUCIR:
1. Entrar a clientes sin QR.
2. Ir a tab Detalles.
3. Intentar confirmar orden sin mesa resuelta.
RESULTADO_ACTUAL:
La validacion de mesa es inconsistente y no garantiza table_id canonico en el payload final.
RESULTADO_ESPERADO:
No debe crearse orden sin table_id. Debe responder TABLE_REQUIRED y bloquear override de QR con TABLE_LOCKED_BY_QR.
UBICACION:
- pronto-client/src/pronto_clients/routes/api/orders.py
- pronto-client/src/pronto_clients/templates/base.html
- pronto-client/src/pronto_clients/templates/index.html
- pronto-api/src/api_app/routes/customers/orders.py
- pronto-libs/src/pronto_shared/services/orders/session_manager.py
EVIDENCIA:
- Flujo actual usa table_number en UI y no persiste lock server-side de QR.
- SessionManager contiene fallback implicito de mesa al crear sesion.
HIPOTESIS_CAUSA:
No existe una autoridad unica de resolucion de mesa en confirmacion + persistencia de source (kiosk|qr|manual) antes de crear orden.
ESTADO: RESUELTO
SOLUCION:
- Se implemento resolucion canonica de mesa en `pronto-client` con prioridad `kiosk > qr > manual` y persistencia en `customer_session_store` (`table_id`, `table_code`, `table_source`) sin usar `flask.session`.
- Se agrego gate server-side en `POST /api/orders` (BFF) y refuerzo en `POST /api/customer/orders` (API) para bloquear ordenes sin mesa (`TABLE_REQUIRED`) y sobrescritura de QR (`TABLE_LOCKED_BY_QR`).
- Se actualizo UI de Tab Detalles para mostrar combo de mesa, estados lock (`qr|kiosk`) y validacion visual previa a confirmar.
- Se removio fallback implicito de "primera mesa activa" en `SessionManager` para evitar asignaciones silenciosas.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-22
