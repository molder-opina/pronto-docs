---
ID: ERR-20260204-SESSIONS-ALL
FECHA: 2026-02-04
PROYECTO: pronto-static/pronto-employees
SEVERIDAD: alta
TITULO: Dashboard empleados llama /api/sessions/all sin endpoint disponible
DESCRIPCION: El dashboard de empleados dispara fetch a /api/sessions/all, pero no existe ruta en pronto-employees ni en pronto-api para ese endpoint.
PASOS_REPRODUCIR: 1) Abrir dashboard de empleados. 2) Abrir DevTools. 3) Ver request a /api/sessions/all.
RESULTADO_ACTUAL: 404 en /api/sessions/all.
RESULTADO_ESPERADO: Endpoint /api/sessions/all disponible en backend de empleados o ajustar UI al endpoint real.
UBICACION: pronto-employees/src/pronto_employees/templates/dashboard.html:768
EVIDENCIA: fetch('/api/sessions/all') en dashboard.html:768; rg -n "/api/" pronto-employees/src/pronto_employees/routes solo muestra api_branding.
HIPOTESIS_CAUSA: Endpoint eliminado o nunca implementado en el BFF de empleados.
ESTADO: RESUELTO
---

SOLUCION:
Se implemento `GET /api/sessions/all` y se alineo el template para consumir el envelope `success_response`.

COMMIT:
2f6533a

FECHA_RESOLUCION:
2026-02-05
