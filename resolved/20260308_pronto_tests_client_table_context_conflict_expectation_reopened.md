ID: TEST-20260308-027
FECHA: 2026-03-08
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: e2e cliente sigue esperando cambio exitoso de mesa tras open_session aunque el runtime actual devuelve 409
DESCRIPCION:
  Reapertura del drift de expectativa sobre `table-context`: con el runtime actual, el cliente responde
  `409 TABLE_LOCATION_MISMATCH` si se intenta cambiar de mesa después de abrir sesión.
PASOS_REPRODUCIR:
  1. Registrar cliente y abrir sesión en una mesa.
  2. Llamar `POST /api/sessions/table-context` con otra mesa.
  3. Observar 409 en `:6080`.
RESULTADO_ACTUAL:
  El e2e esperaba 200 con mesa actualizada.
RESULTADO_ESPERADO:
  Debe validar el conflicto 409 del runtime vigente.
UBICACION:
  - `pronto-tests/tests/functionality/e2e/test_client_api_business_logic_moved_to_api.py`
EVIDENCIA:
  - respuesta live `409 TABLE_LOCATION_MISMATCH`.
HIPOTESIS_CAUSA:
  Drift de expectativa del test frente a la regla actual de fijar la mesa activa una vez abierta la sesión.
ESTADO: RESUELTO
SOLUCION:
  Se actualizó el e2e para afirmar el `409 TABLE_LOCATION_MISMATCH` y se extendió la suite con
  validaciones de crear/listar órdenes, request-check y modifiers requeridos.
COMMIT: 491a50f
FECHA_RESOLUCION: 2026-03-08

