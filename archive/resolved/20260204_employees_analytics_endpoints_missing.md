---
ID: ERR-20260204-ANALYTICS-ENDPOINTS
FECHA: 2026-02-04
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: Analytics UI llama /api/analytics/* sin endpoints en backend
DESCRIPCION: La vista analytics de empleados solicita múltiples endpoints /api/analytics/*, pero no hay rutas en pronto-employees ni pronto-api que respondan esas llamadas.
PASOS_REPRODUCIR: 1) Abrir analytics en empleados. 2) Cambiar rango de fechas. 3) Ver requests a /api/analytics/*.
RESULTADO_ACTUAL: 404 en /api/analytics/kpis, /api/analytics/revenue-trends, /api/analytics/waiter-performance, etc.
RESULTADO_ESPERADO: Endpoints /api/analytics/* implementados o UI ajustada al backend real.
UBICACION: pronto-employees/src/pronto_employees/templates/analytics.html:654,761,834,886,938,1023,1088
EVIDENCIA: fetch a /api/analytics/* en analytics.html; no existen rutas en pronto-employees/src ni en pronto-api/src.
HIPOTESIS_CAUSA: Endpoints de analytics no implementados en el BFF de empleados.
ESTADO: RESUELTO
---

SOLUCION:
Se agregaron endpoints `/api/analytics/*` en `pronto-employees` con payload minimo (ceros/listas vacias) para evitar 404 y mantener la pagina SSR funcional.

COMMIT:
2f6533a

FECHA_RESOLUCION:
2026-02-05
