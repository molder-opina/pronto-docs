ID: TEST-20260306-021
FECHA: 2026-03-06
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: test_recommendations_api usa fixture removida y contrato legacy de recommendations
DESCRIPCION:
  Las suites de recommendations seguían usando `_authenticated_session` y un payload legacy.
ESTADO: RESUELTO
SOLUCION:
  Se reescribieron ambas suites para validar `GET /api/menu-items/recommendations` con `items`
  y `PATCH /api/menu-items/<uuid>/recommendations` con `{"recommendations": [...]}`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
