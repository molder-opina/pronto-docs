ID: AUTH-010
FECHA: 2026-02-14
PROYECTO: pronto-api
SEVERIDAD: media
TITULO: Eliminar client_auth.py - Auth de clientes ahora en pronto-client
DESCRIPCION: 
pronto-api/routes/client_auth.py ya no es necesario.
El auth de clientes vive en pronto-client web routes.
PASOS_REPRODUCIR:
1. cat pronto-api/src/api_app/routes/client_auth.py
2. Archivo existe pero funcionalidad movida
RESULTADO_ACTUAL:
client_auth.py existe en pronto-api
RESULTADO_ESPERADO:
- Archivo eliminado
- Blueprint no registrado
- /api/client-auth/* retorna 404
UBICACION:
- pronto-api/src/api_app/routes/client_auth.py
- pronto-api/src/api_app/routes/__init__.py
EVIDENCIA:
from api_app.routes.client_auth import bp as client_auth_bp
HIPOTESIS_CAUSA:
Auth estaba en API, ahora debe estar en BFF
ESTADO: RESUELTO
DEPENDENCIAS: AUTH-007, AUTH-009 (requiere auth web funcionando)
BLOQUEA: Ninguna
SOLUCION:
- Eliminado /pronto-api/src/api_app/routes/client_auth.py
- Removido import y registro de client_auth_bp en __init__.py
- Movido ACCESS_COOKIE_OPTS a client_sessions.py (único que lo usa)
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-14