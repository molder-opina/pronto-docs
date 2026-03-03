---
ID: ERR-20260208-014
FECHA: 2026-02-08
PROYECTO: pronto-shared
SEVERIDAD: media
TITULO: Falta de resiliencia ante fallos de Redis en el flujo de Refresh
DESCRIPCION: El endpoint de refresco de tokens depende críticamente de Redis para verificar si un Refresh Token ha sido revocado (`is_token_revoked`). Si Redis no está disponible, la función lanza una excepción no controlada que resulta en un error 500 del servidor, impidiendo el acceso a todos los usuarios incluso si tienen tokens válidos.
PASOS_REPRODUCIR:
1) Detener el contenedor de Redis.
2) Intentar realizar un refresh de token mediante `POST /api/employees/auth/refresh`.
RESULTADO_ACTUAL: Error 500 Internal Server Error.
RESULTADO_ESPERADO: El sistema debe degradarse graciosamente. Si Redis falla, se debe decidir si permitir el refresh (priorizando disponibilidad) o denegarlo (priorizando seguridad), pero nunca crashear.
UBICACION: pronto-libs/src/pronto_shared/services/token_service.py y pronto-api/src/api_app/routes/employees/auth.py
EVIDENCIA: `auth.py` captura excepciones generales pero `token_service.py` no implementa fallbacks para la conexión a Redis.
HIPOTESIS_CAUSA: Confianza ciega en la disponibilidad de la infraestructura de caché.
ESTADO: PENDIENTE
---
PLAN DE SOLUCION:
1. Envolver las llamadas a Redis en `token_service.py` con bloques try/except específicos para `RedisError`.
2. Implementar un log de advertencia ("Redis down, bypass revocation check") y retornar `False` (no revocado) como fallback de seguridad vs disponibilidad.
3. Asegurar que el endpoint de refresh maneje el estado de Redis sin propagar el error 500.
