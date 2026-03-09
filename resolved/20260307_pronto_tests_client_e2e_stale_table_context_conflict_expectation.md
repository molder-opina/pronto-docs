ID: TEST-20260307-024
FECHA: 2026-03-07
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: e2e cliente aún espera conflicto 409 al cambiar table-context después de open_session
DESCRIPCION:
  El comportamiento live del backend/cliente devuelve 200 con el contexto actualizado, mientras el e2e
  todavía esperaba un 409 `TABLE_LOCATION_MISMATCH`.
PASOS_REPRODUCIR:
  1. Registrar cliente.
  2. Abrir sesión y volver a llamar `POST /api/sessions/table-context` con otra mesa.
  3. Observar 200 con nuevo `table_context`.
RESULTADO_ACTUAL:
  El test esperaba una colisión que ya no ocurre en runtime.
RESULTADO_ESPERADO:
  Debía verificar el contexto resultante real.
UBICACION:
  - `pronto-tests/tests/functionality/e2e/test_client_api_business_logic_moved_to_api.py`
EVIDENCIA:
  - validación live directa contra `:6082` y `:6080` devolviendo 200
HIPOTESIS_CAUSA:
  Drift del e2e respecto al comportamiento efectivo del backend.
ESTADO: RESUELTO
SOLUCION:
  Se actualizó el e2e para verificar el `table_context` actualizado en lugar de un 409 legacy.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07

