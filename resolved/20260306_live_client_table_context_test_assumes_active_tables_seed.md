ID: TEST-20260306-043
FECHA: 2026-03-06
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: live client table-context test asume al menos dos mesas activas en pronto_tables
DESCRIPCION:
  El E2E live de shortcuts/feedback/table-context fallaba cuando el entorno no tenía mesas activas
  sembradas, aunque los endpoints ya estuvieran sanos.
ESTADO: RESUELTO
SOLUCION:
  `load_two_active_tables()` ahora hace `skip` explícito cuando `pronto_tables` no tiene al menos
  dos mesas activas. Validación: el caso individual quedó en `1 skipped` en el entorno actual y la
  suite completa `pronto-tests/tests` terminó en `256 passed, 30 skipped`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
