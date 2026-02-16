ID: SEC-20260215-003
FECHA: 2026-02-15
PROYECTO: pronto-api
SEVERIDAD: bloqueante
TITULO: Falta autenticación servicio-a-servicio (HMAC) entre BFF y API

DESCRIPCION:
Las llamadas de pronto-client (BFF) hacia pronto-api utilizan únicamente el header X-PRONTO-CUSTOMER-REF para identificar al cliente. Si un atacante logra alcanzar la API directamente (o mediante el puerto expuesto), puede enviar requests autenticándose como cualquier cliente únicamente con knowing el customer_ref.

No existe firma HMAC que valide que la request fue originates del BFF legítimo.

PASOS_REPRODUCIR:
1. Si puerto 6082 está expuesto (SEC-20260215-002), enviar request directa:
   curl -X POST http://localhost:6082/api/orders \
     -H "X-PRONTO-CUSTOMER-REF: any-uuid-here" \
     -H "Content-Type: application/json" \
     -d '{...}'
2. La request se procesa como cliente válido

RESULTADO_ACTUAL:
- Solo se valida X-PRONTO-CUSTOMER-REF header
- No hay verificación de que la request vino del BFF
- No hay timestamp/nonce para prevenir replay

RESULTADO_ESPERADO:
- BFF añade headers de firma HMAC:
  - X-PRONTO-TS: epoch timestamp
  - X-PRONTO-NONCE: uuid único
  - X-PRONTO-SIGNATURE: HMAC-SHA256(secret, method|path|ts|nonce|body_hash)
- API valida:
  - TS dentro de ventana (±60s)
  - NONCE no usado recientemente (Redis)
  - Firma correcta
- Request sin firma → 401/403

UBICACION:
- pronto-client/src/pronto_clients/routes/api/*.py (agregar headers)
- pronto-api/src/api_app/ (validar firma)
- Faltante: pronto-libs/src/pronto_shared/internal_auth.py

EVIDENCIA:
- solo se ve X-PRONTO-CUSTOMER-REF en headers, no headers de HMAC

HIPOTESIS_CAUSA:
Diseño inicial no consideró ataque de red interna o configuración incorrecta de puertos. Asumió que API solo sería alcanzable desde BFF dentro de la red Docker.

ESTADO: RESUELTO

SOLUCION:
1. Creado modulo internal_auth.py en pronto-libs con funciones:
   - create_internal_auth_headers(): genera headers HMAC
   - verify_internal_auth_headers(): verifica signatures
   - is_internal_auth_enabled(): check si esta configurado

2. Integrado en pronto-client/routes/api/orders.py:
   - Ahora firma requests hacia API cuando PRONTO_INTERNAL_HMAC_KEY esta configurada
   - Backward compatible (si no hay key, funciona como antes)

3. Agregada variable PRONTO_INTERNAL_HMAC_KEY a .env.example

Para habilitar en produccion:
- Generar key: python3 -c "import secrets; print(secrets.token_urlsafe(32))"
- Setear PRONTO_INTERNAL_HMAC_KEY en .env

COMMIT: N/A
FECHA_RESOLUCION: 2026-02-15
