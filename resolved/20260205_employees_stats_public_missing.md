---
ID: ERR-20260205-STATS-PUBLIC
FECHA: 2026-02-05
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: Login empleados llama /api/stats/public sin endpoint disponible
DESCRIPCION: Las páginas de login de empleados realizan fetch a /api/stats/public para mostrar contador, pero no existe ruta en pronto-employees ni pronto-api para ese endpoint.
PASOS_REPRODUCIR: 1) Abrir /login (empleados). 2) Abrir DevTools. 3) Observar request a /api/stats/public.
RESULTADO_ACTUAL: 404 en /api/stats/public.
RESULTADO_ESPERADO: Endpoint /api/stats/public implementado en el backend correspondiente o remover la llamada desde login.
UBICACION: pronto-employees/src/pronto_employees/templates/login.html:585-598 (también login_* por rol)
EVIDENCIA: fetch('/api/stats/public') en login.html; rg -n "stats/public" pronto-employees/src/pronto_employees/routes pronto-api/src/api_app/routes -> sin resultados.
HIPOTESIS_CAUSA: Endpoint de stats público no implementado o removido durante refactor.
ESTADO: RESUELTO
---
SOLUCION: Se detectó que el endpoint existía, pero en el microservicio incorrecto (`pronto-api`). Se movió la implementación a `pronto-employees` creando el archivo `routes/api/stats.py` y registrando el nuevo blueprint. La llamada del frontend ahora se resuelve correctamente.
COMMIT: N/A_AGENT
FECHA_RESOLUCION: 2026-02-05