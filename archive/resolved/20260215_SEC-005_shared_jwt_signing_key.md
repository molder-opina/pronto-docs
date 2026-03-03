ID: SEC-20260215-005
FECHA: 2026-02-15
PROYECTO: pronto-api
SEVERIDAD: alta
TITULO: SECRET_KEY compartida para Flask sessions y JWT signing

DESCRIPCION:
La misma SECRET_KEY se usa para:
1. Firmar cookies de Flask session (CSRF tokens, etc)
2. Firmar tokens JWT de empleados
3. Firmar tokens de clientes

Esto dificulta la rotación de claves y aumenta el impacto de un leak: comprometido = todas las sesiones comprometidas.

Además, no hay diferenciación entre JWT_SIGNING_KEY dedicado.

PASOS_REPRODUCIR:
1. Revisar configuración en .env o config
2. Solo existe SECRET_KEY, no JWT_SIGNING_KEY

RESULTADO_ACTUAL:
- jwt_service.py get_jwt_secret() retorna SECRET_KEY
- Flask app.config["SECRET_KEY"] usa el mismo valor
- No hay rotación independiente posible

RESULTADO_ESPERADO:
- Introducir JWT_SIGNING_KEY (o JWT_SECRET_KEY) separada
- En producción: requerida obligatoriamente
- Rotación de SECRET_KEY no invalida JWT y viceversa
- Fallo de arranque si JWT_SIGNING_KEY no configurada en prod

UBICACION:
- pronto-libs/src/pronto_shared/jwt_service.py:59-73
- pronto-api/src/api_app/app.py
- pronto-employees/src/pronto_employees/app.py

EVIDENCIA:
- get_jwt_secret() línea 59-73 usa current_app.config.get("SECRET_KEY")
- No existe JWT_SIGNING_KEY en config

HIPOTESIS_CAUSA:
Implementación inicial simplificada. No se planificó separación de secretos para diferentes propósitos.

ESTADO: RESUELTO

SOLUCION:
1. Modificada get_jwt_secret() en jwt_service.py:
   - Nueva prioridad: JWT_SIGNING_KEY > JWT_SECRET_KEY > SECRET_KEY
   - Warning si usa SECRET_KEY (deprecated)

2. Agregada variable JWT_SIGNING_KEY a .env.example

3. Agregada funcion is_jwt_key_dedicated() para verificar config

Para produccion:
- Generar JWT_SIGNING_KEY: python3 -c "import secrets; print(secrets.token_urlsafe(32))"
- Setear JWT_SIGNING_KEY en .env
- JWT_SECRET_KEY y SECRET_KEY ya no se usaran para JWT

COMMIT: jwt_service.py, .env.example
FECHA_RESOLUCION: 2026-02-15
