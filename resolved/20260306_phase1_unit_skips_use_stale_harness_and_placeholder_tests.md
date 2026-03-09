ID: TEST-20260306-044
FECHA: 2026-03-06
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: Phase 1 unit skips dependen de harness stale y tests placeholder
DESCRIPCION:
  Los skips priorizados de Fase 1 no reflejaban bugs activos del código productivo sino deuda en el
  harness: `test_services.py` dependía de `.env` real y patch paths desactualizados, mientras que
  `test_order_modification_service.py` seguía con placeholders `pass` y razones de skip obsoletas.
ESTADO: RESUELTO
SOLUCION:
  Se activaron los 7 tests de Fase 1: `BusinessInfoService` ahora se prueba con `general.env`
  temporal y patches del módulo core correcto, y `OrderModificationService` quedó cubierto con
  mocks sobre `get_session`, `_apply_modification` y eventos realtime según la API actual.
  Validación: `test_services.py` => `6 passed`, `test_order_modification_service.py` => `5 passed`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
