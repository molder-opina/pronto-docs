# Payment Idempotency Progress Checklist

Fecha de corte: 2026-03-18

## Día 1 - Idempotencia en pagos
- [x] Campo `idempotency_key` agregado en `pronto_payments` (ORM + SQL).
- [x] Índice único parcial `ix_payment_idempotency_key` creado.
- [x] `process_partial_payment()` con manejo de `IntegrityError` y replay.
- [x] Rutas de pago aceptan `Idempotency-Key` y validan obligatoriedad en pagos digitales.
- [x] Pruebas de idempotencia creadas y ejecutadas.
- [x] `pronto-migrate --check` y `pronto-init --check` en verde.

## Día 2 - Lecturas legacy `Order.payment_status`
- [x] Escaneo transversal ejecutado en `pronto-api`, `pronto-libs`, `pronto-client`, `pronto-employees`, `pronto-static`, `pronto-scripts`.
- [x] Sin lecturas runtime activas de `Order.payment_status` en servicios/rutas productivas.
- [x] Test de regresión agregado para bloquear nuevos usos runtime.

## Día 3 - Cierre canónico de sesión
- [x] `SessionClosureService` creado como fachada canónica.
- [x] `session_financial_service` ahora delega al `SessionClosureService`.
- [x] Tests unitarios de `SessionClosureService` agregados.
- [x] Duplicidad ORM de `PaymentAuditLog` corregida.

## Día 4 - Integridad financiera
- [x] Completar suite de integridad financiera end-to-end (pagos parciales, split, confirmación externa).
- [x] Ejecutar suite ampliada de regresión en `pronto-tests` sobre flujo de pagos cubierto por tests automáticos.
- [x] Evidencia ejecutada:
  - `pronto-api/tests/test_payment_idempotency.py` (6 passed)
  - `pronto-api/tests/test_stripe_webhooks_signature.py` (4 passed)
  - `pronto-tests/invariants/test_business_invariants.py` (5 passed)
  - `pronto-tests/tests/functionality/api/api-tests/test_split_bill_payments.py` (10 passed)
  - `pronto-tests/tests/unit/pronto-client/test_payments_api.py` (8 passed)

## Día 5 - Validación manual
- [x] Pruebas manuales en staging/local con concurrencia real (10+ requests simultáneos).
- [x] Validación funcional cliente/empleados con `Idempotency-Key` en rutas de pago API.
- [x] Cierre de evidencias finales (comandos, resultados, observaciones).
- [x] Evidencia ejecutada (local):
  - `POST /api/customer/payments/sessions/<session_id>/pay` sin key digital -> `400` (`IDEMPOTENCY_KEY_REQUIRED`).
  - `POST /api/customer/payments/sessions/<session_id>/pay` con key -> `200`.
  - Concurrencia `12` requests mismo key -> `12x 200`, `1` `payment_id`, `11` replays.
  - `POST /api/sessions/<session_id>/pay` (empleados) con key -> `200`.
