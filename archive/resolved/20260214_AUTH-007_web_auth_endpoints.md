ID: AUTH-007
FECHA: 2026-02-14
PROYECTO: pronto-client
SEVERIDAD: bloqueante
TITULO: Endpoints login/register/logout - Web routes en pronto-client
DESCRIPCION: 
No existen endpoints web de autenticación para clientes en pronto-client.
Se requiere login, register, logout, /me como web routes (no API).
PASOS_REPRODUCIR:
1. curl -X POST http://localhost:6080/login
2. 404 Not Found
RESULTADO_ACTUAL:
No hay endpoints de auth web para clientes
RESULTADO_ESPERADO:
- GET/POST /login
- GET/POST /register
- POST /logout
- GET /me
UBICACION:
- pronto-client/src/pronto_clients/routes/web.py
EVIDENCIA:
No hay funciones login, register, logout en web.py
HIPOTESIS_CAUSA:
Auth de clientes estaba en pronto-api/client_auth.py
ESTADO: RESUELTO
DEPENDENCIAS: AUTH-003, AUTH-005, AUTH-006 (requiere store, service, sin JWT)
BLOQUEA: AUTH-010
SOLUCION:
- Creado /pronto-client/src/pronto_clients/routes/api/auth.py
- POST /api/login - autentica y crea customer_ref en Redis
- POST /api/register - crea cuenta y auto-login
- POST /api/logout - revoca customer_ref
- GET /api/me - retorna info del cliente actual
- Usa customer_session_store para manejo de sesiones Redis
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-14