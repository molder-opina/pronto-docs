ID: TEST-20260306-024
FECHA: 2026-03-06
PROYECTO: pronto-libs,pronto-api,pronto-tests
SEVERIDAD: alta
TITULO: recommendation_service no expone los símbolos que importan los routes
DESCRIPCION:
  La fachada de recommendations no exportaba los nombres consumidos por los routes.
ESTADO: RESUELTO
SOLUCION:
  Se agregaron wrappers estables `get_global_recommendations()` y
  `update_item_recommendations()` sobre `RecommendationService` y se declaró `__all__`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
