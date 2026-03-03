---
ID: ERR-20260205-EMPLOYEES-PREFERENCES-PUT-NO-CSRF
FECHA: 2026-02-05
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: PUT /api/employees/me/preferences sin CSRF header en templates
DESCRIPCION: El dashboard employees hace un PUT a /api/employees/me/preferences desde JS en template sin enviar X-CSRFToken ni credentials include. Con CSRF global habilitado en pronto-employees, el request puede fallar con 400 (CSRF Error) y la preferencia no se persiste.
PASOS_REPRODUCIR: 1) Abrir pronto-employees/src/pronto_employees/templates/includes/_dashboard_scripts.html. 2) Buscar fetch('/api/employees/me/preferences', { method: 'PUT' ... }) sin X-CSRFToken. 3) En runtime, intentar cambiar una preferencia (home_section u otras) y observar fallo/ausencia de persistencia.
RESULTADO_ACTUAL: El PUT puede ser rechazado por CSRF y no guarda preferencias.
RESULTADO_ESPERADO: Toda mutacion a /api/* incluye X-CSRFToken y credentials include (cookie-auth) segun canon.
UBICACION: pronto-employees/src/pronto_employees/templates/includes/_dashboard_scripts.html
EVIDENCIA: fetch PUT no incluye header X-CSRFToken ni credentials include.
HIPOTESIS_CAUSA: Codigo legacy de dashboard fue agregado antes de estandarizar CSRF canonico para /api/*.
ESTADO: RESUELTO
---

SOLUCION:
Se agrego `X-CSRFToken` y `credentials: include` en el request mutador de preferencias.

COMMIT:
2f6533a

FECHA_RESOLUCION:
2026-02-05
