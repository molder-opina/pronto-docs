ID: BUG-20260310-WAITER-REQUEST-CHECK-SCOPE-MISMATCH
FECHA: 2026-03-10
PROYECTO: pronto-api
SEVERIDAD: alta
TITULO: request-check de employees usa actor_scope legacy `employee` y bloquea waiter con 403
DESCRIPCION: El endpoint `POST /api/orders/<order_id>/request-check` en employees propagaba `actor_scope="employee"`, mientras la state machine y las transiciones canónicas usan scopes concretos (`waiter`, `cashier`, `admin`, `system`, `chef`, `client`). Además, las transiciones de pago relevantes no permitían `waiter`, contradiciendo el canon del proyecto.
PASOS_REPRODUCIR:
1. Autenticarse como waiter.
2. Ejecutar `POST /waiter/api/orders/<order_id>/request-check` sobre una orden `delivered` no pagada.
3. Observar `403 Scope no autorizado para esta acción`.
RESULTADO_ACTUAL: Resuelto.
RESULTADO_ESPERADO: El waiter puede solicitar cuenta y participar en el flujo de pago según los scopes canónicos.
UBICACION:
- pronto-api/src/api_app/routes/employees/orders.py
- pronto-libs/src/pronto_shared/constants.py
EVIDENCIA:
- Probe Playwright reprodujo inicialmente `403` con body `Scope no autorizado para esta acción`.
- `waiter-scope-runtime.spec.ts` quedó 6/6 después del fix.
HIPOTESIS_CAUSA: Drift entre la ruta employees y el canon de scopes/transiciones del proyecto.
ESTADO: RESUELTO
SOLUCION:
- `request_check` ahora usa `_get_actor_scope()` al invocar `mark_awaiting_payment(...)`.
- Se alinearon las transiciones canónicas para permitir `waiter` en `delivered -> awaiting_payment` y `awaiting_payment -> paid`, consistente con `AGENTS.md`.
- Se revalidó el flujo real reiniciando el API y ejecutando Playwright waiter runtime en verde.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

