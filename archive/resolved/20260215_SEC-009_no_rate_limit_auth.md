ID: SEC-20260215-009
FECHA: 2026-02-15
PROYECTO: pronto-api
SEVERIDAD: media
TITULO: Rate limiting no aplicado en endpoints de login/auth

DESCRIPCION:
Los endpoints de autenticación (/login, /register, /refresh) no tienen rate limiting aplicado. Esto expone el sistema a:

1. Brute force attacks: intentar múltiples contraseñas
2. Credential stuffing: probar combinaciones de email/password robadas
3. DoS: agotar recursos con múltiples requests

Existe código de rate limiting en pronto-libs (security_middleware.py) pero no se aplica a las rutas de auth.

PASOS_REPRODUCIR:
1. Verificar que existe decorador @rate_limit
2. Buscar aplicación en rutas de auth:
   rg "rate_limit" pronto-api/src/api_app/routes/employees/auth.py
   rg "rate_limit" pronto-client/src/pronto_clients/routes/api/auth.py
3. No hay resultados

RESULTADO_ACTUAL:
- security_middleware.py tiene RateLimiter implementado
- Decorador @rate_limit disponible
- NO se aplica a /login, /register, /refresh en ningún servicio

RESULTADO_ESPERADO:
- @rate_limit(limite, ventana) en:
  - POST /api/employees/auth/login
  - POST /api/employees/auth/refresh
  - POST /api/login (clientes)
  - POST /api/register (clientes)
- Límite sugerido: 5 intentos por minuto por IP
- After limit: 429 Too Many Requests

UBICACION:
- pronto-libs/src/pronto_shared/security_middleware.py (líneas 59-175)
- pronto-api/src/api_app/routes/employees/auth.py
- pronto-client/src/pronto_clients/routes/api/auth.py

EVIDENCIA:
- Búsqueda con rg no encuentra rate_limit en rutas de auth

HIPOTESIS_CAUSA:
Rate limiter se implementó pero no se integró en los endpoints críticos. Prioridad baja durante desarrollo.

ESTADO: RESUELTO

SOLUCION:
1. Agregado @rate_limit a POST /login en empleados (auth.py)
2. Agregado @rate_limit a POST /login en clientes (auth.py)

Configuracion:
- max_requests=5
- window_seconds=60 (1 minuto)
- key_prefix para diferenciar endpoints

Response cuando se excede:
- 429 Too Many Requests
- Headers: Retry-After, X-RateLimit-Limit, X-RateLimit-Remaining

En modo TESTING el rate limit esta deshabilitado.

COMMIT: auth.py (pronto-api, pronto-client)
FECHA_RESOLUCION: 2026-02-15
