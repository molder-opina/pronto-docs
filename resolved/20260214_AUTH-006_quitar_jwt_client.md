ID: AUTH-006
FECHA: 2026-02-14
PROYECTO: pronto-client
SEVERIDAD: bloqueante
TITULO: Quitar JWT de pronto-client - Usar sesión Flask con Redis
DESCRIPCION: 
pronto-client usa init_jwt_middleware que es incorrecto para clientes según AGENTS.md.
Los clientes deben usar sesión Flask + Redis-backed customer_ref.
PASOS_REPRODUCIR:
1. Ver línea 67 de pronto-client/app.py: init_jwt_middleware(app)
2. Clientes usan JWT en lugar de sesión
RESULTADO_ACTUAL:
JWT middleware inicializado en pronto-client
RESULTADO_ESPERADO:
- Quitar init_jwt_middleware
- Configurar sesión Flask con allowlist
- CSRF Flask-WTF activo
UBICACION:
- pronto-client/src/pronto_clients/app.py (línea 22, 67)
EVIDENCIA:
from pronto_shared.jwt_middleware import init_jwt_middleware
HIPOTESIS_CAUSA:
Implementación inicial usó JWT para todos
ESTADO: RESUELTO
DEPENDENCIAS: AUTH-003, AUTH-004 (requiere infra base)
BLOQUEA: AUTH-007
SOLUCION: 
- Eliminado init_jwt_middleware de pronto-client
- Agregado config de session cookie (HTTPONLY, SAMESITE, SECURE)
- Context processor ahora usa customer_session_store.get_customer()
- Variables de template actualizadas (customer_name usa 'name', session_id de flask.session)
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-14