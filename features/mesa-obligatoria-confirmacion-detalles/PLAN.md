# Plan - Mesa Obligatoria en Confirmacion

## Implementation Profile (consolidado)

1. Creacion de orden BFF: `pronto-client/src/pronto_clients/routes/api/orders.py` (`POST /api/orders`).
2. Creacion de orden API: `pronto-api/src/api_app/routes/customers/orders.py` (`POST /api/customer/orders`).
3. Tab Detalles checkout: `pronto-client/src/pronto_clients/templates/base.html` + `index.html`.
4. Persistencia reutilizable: `pronto_shared.services.customer_session_store`.
5. Deteccion kiosko: datos de `kind="kiosk"` y `kiosk_location` en payload de sesion cliente.
6. Riesgo detectado: fallback implicito de mesa en `session_manager` permitia asignacion silenciosa.

## Plan de ejecucion

1. Crear expediente en `pronto-docs/errors/` antes del fix.
2. Implementar resolver compartido de contexto mesa en BFF.
3. Extender `POST /api/orders` con gate y normalizacion de `table_id`.
4. Exponer `GET/POST /api/sessions/table-context` para persistencia de contexto.
5. Ajustar UI de `Detalles` para combo visible y estados locked.
6. Integrar QR para persistir `table_source=qr` y bloquear override.
7. Reforzar validacion server-side en `POST /api/customer/orders`.
8. Remover fallback implicito de primera mesa activa en `SessionManager`.
9. Ejecutar gates/tests disponibles y documentar bloqueantes de entorno.
10. Cerrar expediente, mover a `resolved`, actualizar `resueltos.txt`.
