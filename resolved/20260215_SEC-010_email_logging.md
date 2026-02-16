ID: SEC-20260215-010
FECHA: 2026-02-15
PROYECTO: pronto-api
SEVERIDAD: media
TITULO: Logging expone email de clientes en output

DESCRIPCION:
El sistema registra emails de clientes en logs, lo que puede exponer PII en:
- Logs de aplicación
- stdout del contenedor
- Sistemas de log centralizado

Aunque passwords no se registran, el email es PII sensible.

PASOS_REPRODUCIR:
1. Buscar logger.info/warning con email:
   rg "logger.*email" pronto-api/src
   rg "logger.*customer" pronto-api/src
2. Ver ejemplos en pronto-libs

RESULTADO_ACTUAL:
- pronto-libs/src/pronto_shared/services/order_service.py:2178:
  logger.info(f"Ticket sent for session {session_id} to {email}")
- pronto-libs/src/pronto_shared/services/email_service.py:72:
  logger.info(f"[EMAIL] Sent successfully to {to_email}: {subject}")

RESULTADO_ESPERADO:
- No registrar emails en logs
- Usar ID de sesión o ID de usuario para logging
- Si es necesario debugging, usar customer_id o masking parcial

UBICACION:
- pronto-libs/src/pronto_shared/services/order_service.py
- pronto-libs/src/pronto_shared/services/email_service.py

EVIDENCIA:
- Líneas mencionadas arriba exponen email directamente

HIPOTESIS_CAUSA:
Logging inicial para debugging no consideró PII.

ESTADO: RESUELTO

SOLUCION:
1. order_service.py:
   - Logging de email ahora usa mask: "ju***@example.com"
   
2. email_service.py:
   - Logging de email ahora usa mask

Metodo de enmascaramiento:
- Primeros 2 caracteres + "***" + dominio
- Ejemplo: "juan@email.com" -> "ju***@email.com"

COMMIT: order_service.py, email_service.py
FECHA_RESOLUCION: 2026-02-15
