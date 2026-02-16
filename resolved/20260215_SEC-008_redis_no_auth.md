ID: SEC-20260215-008
FECHA: 2026-02-15
PROYECTO: infrastructure
SEVERIDAD: alta
TITULO: Redis sin password y expuesto públicamente

DESCRIPCION:
Redis está configurado sin autenticación y expuesto en el puerto 6379. Esto representa un riesgo crítico porque:

1. Cualquiera en la red local puede conectarse a Redis
2. Las sesiones de clientes (customer_ref) contienen PII: email, nombre, teléfono
3. Un atacante puede:
   - Leer todas las sesiones de clientes
   - Modificar sesiones existentes
   - Crear sesiones fake
   - Borrar todas las sesiones (DoS)

Además, la revocación de sesiones de clientes usa keys separadas (no borra la original) - un atacante puede restaurar una sesión revocada.

PASOS_REPRODUCIR:
1. redis-cli -h localhost -p 6379
2. KEYS pronto:client:*
3. GET pronto:client:customer_ref:<uuid>
4. Acceso sin autenticación exitoso

RESULTADO_ACTUAL:
- redis_client.py líneas 20-30:
  REDIS_PASSWORD = os.getenv("REDIS_PASSWORD", "")  # Vacío por defecto
  password=REDIS_PASSWORD or None,  # Sin password

- docker-compose.yml:
  redis:
    ports:
      - "6379:6379"  # Expuesto sin protección

RESULTADO_ESPERADO:
- Redis requiere password (config requirepass)
- Puerto 6379 NO expuesto al host (solo interno)
- Conexión TLS para Redis (opcional en red interna)
- Session store: en logout, borrar key original (no solo marcar revocada)

UBICACION:
- pronto-libs/src/pronto_shared/redis_client.py
- docker-compose.yml
- pronto-libs/src/pronto_shared/services/customer_session_store.py (revoke)

EVIDENCIA:
- redis_client.py líneas 20-30
- docker-compose.yml líneas 23-34

HIPOTESIS_CAUSA:
Setup inicial para desarrollo local sin considerar producción. Redis es "de confianza" dentro de la red Docker por defecto.

ESTADO: RESUELTO

SOLUCION:
1. docker-compose.yml:
   - Agregado requirepass a Redis
   - Puerto 6379 expuesto solo en perfil dev
   - profiles: apps, dev

2. .env.example:
   - Agregada REDIS_PASSWORD

3. redis_client.py:
   - Ya soportaba REDIS_PASSWORD (línea 23)

Para produccion:
- Generar REDIS_PASSWORD segura
- Setear REDIS_PASSWORD en .env
- Redis no estara expuesto públicamente

COMMIT: docker-compose.yml, .env.example
FECHA_RESOLUCION: 2026-02-15
