ID: ERR-20260219-FEEDBACK-BULK-CROSS-HOST
FECHA: 2026-02-19
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: Formulario feedback usa endpoint cross-host sin contrato de auth/CSRF
DESCRIPCION: `feedback.html` envía feedback a ``${EMPLOYEES_API_BASE}/api/feedback/bulk`` en lugar de usar llamada relativa canónica a BFF. La llamada no incluye `credentials: 'include'` ni `X-CSRFToken`, quedando incompatible con protección CSRF y autenticación de sesión.
PASOS_REPRODUCIR:
1) Revisar submit handler de `/feedback` en template.
2) Probar `POST http://localhost:6081/api/feedback/bulk`.
3) Probar `POST http://localhost:6082/api/feedback/bulk`.
RESULTADO_ACTUAL: En employees host (6081) responde 404 (endpoint no existe). En api host (6082) responde 400 por CSRF faltante; además la solicitud del browser no envía cookies al no usar `credentials: 'include'` en cross-origin.
RESULTADO_ESPERADO: El frontend cliente debe usar endpoint relativo bajo su BFF (misma origin), con `credentials: 'include'` y header `X-CSRFToken` en mutaciones.
UBICACION: /Users/molder/projects/github-molder/pronto/pronto-client/src/pronto_clients/templates/feedback.html:178, /Users/molder/projects/github-molder/pronto/pronto-client/src/pronto_clients/templates/feedback.html:320
EVIDENCIA: Template usa `fetch(`${EMPLOYEES_API_BASE}/api/feedback/bulk`, { method: 'POST', headers: { 'Content-Type': 'application/json' } })` sin credenciales ni CSRF. Pruebas manuales: `/api/feedback/bulk` en 6081 => 404, en 6082 => 400 CSRF missing.
HIPOTESIS_CAUSA: Integración incompleta durante separación de responsabilidades client BFF vs employees/API directo.
ESTADO: RESUELTO
SOLUCION: El formulario `feedback.html` ahora usa endpoint relativo same-origin `/api/feedback/bulk` con `credentials: 'include'` y header `X-CSRFToken`. En BFF cliente se implementó `POST /api/feedback/bulk` (proxy a pronto-api) para mantener autenticación por `customer_ref` y eliminar dependencia cross-host.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-19
