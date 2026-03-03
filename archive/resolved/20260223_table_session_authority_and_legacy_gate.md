ID: ERR-20260223-TABLE-SESSION-AUTHORITY-AND-LEGACY-GATE
FECHA: 2026-02-23
PROYECTO: pronto-client, pronto-api, pronto-libs, pronto-docs, pronto-static
SEVERIDAD: bloqueante
TITULO: Autoridad de mesa por sesión no aplicada y gate legacy bloqueando rules-check
DESCRIPCION:
La auditoría detectó dos bloqueantes P0: (1) la validación de mesa no estaba anclada a DiningSession para sesiones activas, permitiendo inconsistencias entre payload cliente y mesa real de sesión; (2) pronto-rules-check full falla por referencias legacy detectadas por pronto-no-legacy en pronto-libs static js. Adicionalmente había deuda de contrato OpenAPI (P1) y mapeo UX de errores (P2).
PASOS_REPRODUCIR:
1. Ejecutar ./pronto-scripts/bin/pronto-rules-check full.
2. Observar error "Legacy references found (see pronto-no-legacy)".
3. Ejecutar flujo cliente con sesión movida por empleado y enviar orden con mesa vieja desde cliente.
RESULTADO_ACTUAL:
- Gate full bloqueado por referencias legacy.
- Riesgo de desalineación de mesa entre cliente y sesión activa.
RESULTADO_ESPERADO:
- Gate full en verde sin referencias legacy.
- Si existe DiningSession abierta, mesa de sesión es autoridad y mismatch retorna TABLE_SESSION_MISMATCH.
UBICACION:
- pronto-libs/src/pronto_shared/static/js/src/modules/employee-events.ts
- pronto-libs/src/pronto_shared/static/js/src/modules/waiter-board.ts
- pronto-libs/src/pronto_shared/static/js/src/core/realtime.ts
- pronto-libs/src/pronto_shared/static/js/realtime.js
- pronto-api/src/api_app/routes/customers/orders.py
- pronto-libs/src/pronto_shared/services/orders/session_manager.py
- pronto-client/src/pronto_clients/routes/api/orders.py
- pronto-client/src/pronto_clients/routes/api/table_context.py
- pronto-static/src/vue/clients/views/CheckoutView.vue
- pronto-docs/contracts/pronto-client/openapi.yaml
- pronto-docs/contracts/pronto-api/openapi.yaml
EVIDENCIA:
- ./pronto-scripts/bin/pronto-no-legacy: PASS (0).
- ./pronto-scripts/bin/pronto-api-parity-check employees: ok=true.
- ./pronto-scripts/bin/pronto-api-parity-check clients: ok=true.
- Smoke validado (HTTP real en contenedores):
  - TABLE_REQUIRED (400)
  - TABLE_LOCKED_BY_QR (409)
  - KIOSK_TABLE_NOT_CONFIGURED (409)
  - TABLE_SESSION_MISMATCH (409) + reconciliación de table-context a source=session.
HIPOTESIS_CAUSA:
- Código legacy residual en pronto-libs/static/js no migrado totalmente.
- Falta de gate explícito por sesión activa en create customer order.
ESTADO: RESUELTO
SOLUCION:
Se aplicó autoridad de mesa por DiningSession en `POST /api/customer/orders` (selección de sesión abierta más reciente por `opened_at DESC`), contrato 409 `TABLE_SESSION_MISMATCH` con detalles de mesa actual, reconciliación BFF a Redis con `table_source=session`, protección de rebind en SessionManager (`allow_table_rebind=False` por defecto), actualización de contratos OpenAPI cliente/API y mapping UX explícito de errores en checkout. En paralelo se migraron rutas/eventos legacy en módulos realtime/waiter para eliminar referencias detectadas por `pronto-no-legacy`.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
