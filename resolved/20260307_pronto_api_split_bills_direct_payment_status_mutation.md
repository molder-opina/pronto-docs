ID: API-20260307-008B
FECHA: 2026-03-07
PROYECTO: pronto-api
SEVERIDAD: alta
TITULO: split_bills muta `payment_status` directamente en la ruta cliente
DESCRIPCION:
  `pay_split_person` en `pronto-api/src/api_app/routes/customers/split_bills.py` hacía asignaciones directas de
  `payment_status`/`payment_method`/`paid_at` y controlaba el cierre del split en la propia ruta.
PASOS_REPRODUCIR:
  1. Abrir `pronto-api/src/api_app/routes/customers/split_bills.py`.
  2. Revisar `pay_split_person`.
  3. Confirmar la mutación directa de `person.payment_status = "paid"` y el manejo local del cierre.
RESULTADO_ACTUAL:
  La ruta delega el pago individual a `pronto_shared.services.split_bill_service.process_person_payment`.
RESULTADO_ESPERADO:
  Evitar mutaciones directas de estado en la ruta y centralizar el comportamiento en la capa compartida.
UBICACION:
  - `pronto-api/src/api_app/routes/customers/split_bills.py`
  - `pronto-libs/src/pronto_shared/services/split_bill_service_core.py`
  - `pronto-api/tests/test_security_regressions.py`
ESTADO: RESUELTO
SOLUCION:
  `pay_split_person` ahora valida auth/ownership y delega a `split_bill_service.process_person_payment(...)`.
  En `split_bill_service_core.py` se amplió el soporte de métodos (`cash`, `card`, `clip`, `stripe`) y se devolvió un payload estable con
  `payment_status`, `payment_method`, `payment_reference`, `split_completed` y `session_closed`.
  El gate local quedó limpio: `rg -n --hidden 'payment_status\s*=' pronto-api/src/api_app/routes/customers/split_bills.py` => sin matches.
  Validación adicional: `pronto-api/.venv/bin/python -m pytest pronto-api/tests/test_security_regressions.py -q` => `17 passed`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
