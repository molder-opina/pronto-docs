ID: TEST-20260306-030
FECHA: 2026-03-06
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: Analytics tests usan response.json() en vez de get_json() para Flask
DESCRIPCION:
  Las suites de analytics seguían usando una API de test obsoleta (`response.json()`).
ESTADO: RESUELTO
SOLUCION:
  Se migraron las suites de analytics a `response.get_json()`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
