ID: SEC-20260215-004
FECHA: 2026-02-15
PROYECTO: pronto-api
SEVERIDAD: alta
TITULO: JWT empleados no valida issuer (iss) ni audience (aud)

DESCRIPCION:
Los tokens JWT emitidos para empleados no incluyen ni validan los claims estándar "iss" (issuer) y "aud" (audience). Esto permite que tokens JWT válidos emitidos para PRONTO puedan ser reutilizados en otros contextos o que tokens de otros sistemas sean aceptados si el secret es igual.

Tokens de otros servicios con el mismo secret serían aceptados.

PASOS_REPRODUCIR:
1. Generar un JWT con claims: {sub: employee_id, role: admin} usando el mismo SECRET_KEY
2. Enviar a cualquier endpoint /api/employees/*
3. El token es aceptado aunque no tenga campos iss/aud

RESULTADO_ACTUAL:
- jwt_service.py create_access_token() no incluye iss/aud
- jwt_service.py decode_token() no valida iss/aud
- Solo se valida: firma HS256, exp, type=access

RESULTADO_ESPERADO:
- create_access_token():
  - iss: "pronto-auth" (o dominio específico)
  - aud: "pronto-api"
- decode_token():
  - Valida iss coincide con esperado
  - Valida aud coincide con esperado
  - Rechaza token sin/clames incorrectos con 401

UBICACION:
- pronto-libs/src/pronto_shared/jwt_service.py:76-119 (create_access_token)
- pronto-libs/src/pronto_shared/jwt_service.py:149-178 (decode_token)

EVIDENCIA:
- Al revisar jwt_service.py, el payload en línea 104-117 no incluye iss/aud
- decode_token() solo hace jwt.decode() sin opciones de issuer/audience

HIPOTESIS_CAUSA:
Implementación inicial de JWT fue simplificada sin seguir mejores prácticas de OAuth/OIDC. No se consideraron ataques de reutilización de token fuera de contexto.

ESTADO: RESUELTO

SOLUCION:
1. Agregadas constantes JWT_ISSUER y JWT_AUDIENCE en jwt_service.py
2. create_access_token() ahora incluye iss y aud en el payload
3. decode_token() valida iss y aud usando opciones de PyJWT
4. Agregada opcion include_pii=False por defecto (mejora adicional - SEC-007)

Tokens emitidos ahora tienen:
- iss: "pronto-auth"
- aud: "pronto-api"

Tokens sin iss/aud seran rechazados (requiere re-login).

COMMIT: jwt_service.py modificado
FECHA_RESOLUCION: 2026-02-15
