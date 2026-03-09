ID: TEST-20260306-028
FECHA: 2026-03-06
PROYECTO: pronto-libs,pronto-api,pronto-tests
SEVERIDAD: alta
TITULO: AnalyticsService devuelve success_response y los routes de reports vuelven a envolver la respuesta
DESCRIPCION:
  La fachada `AnalyticsService` retornaba envelopes `success_response(...)` que los routes públicos
  envolvían de nuevo, rompiendo el contrato JSON esperado de analytics.
ESTADO: RESUELTO
SOLUCION:
  `AnalyticsService` ahora devuelve datos crudos y `pronto-api/src/api_app/routes/reports.py`
  mantiene la única capa pública de envelope.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
