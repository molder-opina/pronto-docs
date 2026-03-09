ID: TEST-20260306-029
FECHA: 2026-03-06
PROYECTO: pronto-libs,pronto-api,pronto-tests
SEVERIDAD: alta
TITULO: EmployeeAnalytics usa firma legacy de SQLAlchemy case() y rompe waiter-performance
DESCRIPCION:
  `EmployeeAnalytics.get_waiter_performance()` usaba la firma vieja de `case()` y disparaba 500.
ESTADO: RESUELTO
SOLUCION:
  Se actualizó a la firma posicional vigente de SQLAlchemy y la suite local de analytics quedó verde.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
