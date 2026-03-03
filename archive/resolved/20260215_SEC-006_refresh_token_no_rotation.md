ID: SEC-20260215-006
FECHA: 2026-02-15
PROYECTO: pronto-api
SEVERIDAD: alta
TITULO: Refresh tokens no se rotan ni revocan correctamente

DESCRIPCION:
El sistema de refresh tokens tiene los siguientes problemas:

1. **No hay rotación**: Al hacer refresh, se emite un nuevo access token pero el mismo refresh token puede reutilizarse múltiples veces
2. **No hay revocación por jti**: No se guarda registro de JTIs revocados, permitiendo replay de refresh tokens robados
3. **Logout no invalida refresh**: Hacer logout no marca el refresh token como usado/inválido

Un atacante con acceso al refresh token puede mantener acceso indefinidamente.

PASOS_REPRODUCIR:
1. Obtener refresh token (hacer login como empleado)
2. Llamar /api/employees/auth/refresh múltiples veces con el mismo refresh
3. Todas las llamadas retornan nuevo access token (no hay rotación)
4. En logout, el refresh token sigue siendo válido

RESULTADO_ACTUAL:
- /api/employees/auth/refresh acepta el mismo refresh token repetidamente
- No se guarda jti en lista de usados
- Logout no toca Redis para invalidar refresh

RESULTADO_ESPERADO:
- Refresh endpoint:
  - Valida refresh token existente
  - Emite nuevo access + nuevo refresh
  - Marca refresh_jti anterior como revocado (Redis: pronto:employees:refresh_revoked:<jti>) con TTL = exp
  - Redis previene replay de mismo jti
- Logout:
  - Revoca el refresh token actual por jti
- Opcional: Access tokens también pueden revocarse por jti en logout

UBICACION:
- pronto-api/src/api_app/routes/employees/auth.py (refresh endpoint)
- Falta implementación de rotación y revocación

EVIDENCIA:
- Revisar endpoint /api/employees/auth/refresh
- No hay código de revocación en logout

HIPOTESIS_CAUSA:
Implementación inicial de JWT tomó atajos. Refresh tokenrotation es complejidad adicional que no se implementó.

ESTADO: RESUELTO

SOLUCION:
La funcionalidad de rotacion de refresh tokens YA estaba implementada:

1. /refresh endpoint (auth.py line 92-184):
   - Valida refresh token
   - Verifica blacklist en Redis
   - Genera nuevo access + refresh token
   - Revoca el token anterior (blacklist)

2. /logout endpoint (auth.py line 221-233):
   - Revoca refresh token en Redis

3. /revoke endpoint (auth.py line 187-199):
   - Endpoint dedicado para revocation

4. token_service.py:
   - is_token_revoked(): check contra Redis
   - revoke_token(): agrega a blacklist

El bug reportado era falso positivo.

COMMIT: N/A
FECHA_RESOLUCION: 2026-02-15
