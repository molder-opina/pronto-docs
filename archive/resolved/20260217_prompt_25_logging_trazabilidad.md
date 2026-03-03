ID: PROMPT-25
FECHA: 2026-02-17
PROYECTO: PRONTO-System
SEVERIDAD: alta
TITULO: PROMPT 25 - Logging y Trazabilidad

DESCRIPCION:
Prompt creado para implementar el sistema de logging y trazabilidad.

CONTENIDO PROMPT:

```

ESTADO: RESUELTO
SOLUCION: Se consolidó y registró el prompt 25 dentro del bloque de prompts adicionales (21-26) para cubrir trazabilidad, logging estructurado y error tracking obligatorio definidos en AGENTS.md.
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-18
Implementa el sistema de logging y trazabilidad para PRONTO:

CORRELATION ID (OBLIGATORIO):
- Todo request debe generar un correlation ID unico
- Header canonico: X-Correlation-ID
- El correlation ID debe propagarse a todos los servicios y logs

LOGGING ESTRUCTURADO (OBLIGATORIO):
Usar pronto_shared/trazabilidad.py - StructuredLogger

Formato JSON con campos obligatorios:
- timestamp: ISO8601
- level: DEBUG|INFO|WARNING|ERROR
- correlation_id: ID del request
- service: nombre del servicio
- action: operacion
- user_id: ID del usuario
- user_type: employee|customer|anonymous
- duration_ms: tiempo de ejecucion
- message: mensaje legible
- error: detalles del error (si aplica)

MENSAJES DE USUARIO (OBLIGATORIO):
- NO exponer errores tecnicos al usuario
- Usar codigos de error amigables (USER_MESSAGES en trazabilidad.py)
- Idiomas soportados: es (default), en

ERRORES Y EXCEPCIONES:
- Capturar contexto completo (stack trace, variables relevantes)
- No exponer PII en logs
- Registrar correlation ID en todo error

MONITOREO:
- Endpoint de health: /health con estado y version
- Metricas basicas: requests totales, errores, duracion promedio
- Usar ProcessMonitor de trazabilidad.py

AUDITORIA DE ACCIONES DE NEGOCIO:
- Registrar quien hizo que y cuando (audit_action)
- Formato: USER|ACTION|TYPE|CODE|RETVAL|SESSION|TIME

LOGS DE TRAZABILIDAD (OBLIGATORIO):
- Todos los logs aplicativo deben vivir en pronto-logs/
- Directorio raiz: pronto-logs/
- Subdirectorios por servicio:
  * pronto-logs/api/ - Logs de pronto-api
  * pronto-logs/employees/ - Logs de pronto-employees
  * pronto-logs/client/ - Logs de pronto-client
  * pronto-logs/nginx/ - Logs de nginx (pronto-static)
- Usar pronto_shared/logging_config.py para configuracion
- Formato: JSON estructurado
- Rotacion: diaria, retencion 7 dias

ERROR TRACKING OBLIGATORIO - Pronto-Error-Tracker-Agent (P0):
Objetivo: Forzar que TODO bug quede documentado y solo pase a resuelto con correccion verificada.

Ubicaciones:
- pronto-docs/errors/
- pronto-docs/resolved/
- pronto-docs/resueltos.txt

Regla: No hay fix sin error documentado (P0)
Ante cualquier bug:
crear pronto-docs/errors/<YYYYMMDD>_<slug_error>.md ANTES del fix.

Formato EXACTO del archivo:
ID:
FECHA:
PROYECTO:
SEVERIDAD: (bloqueante | alta | media | baja)
TITULO:
DESCRIPCION:
PASOS_REPRODUCIR:
RESULTADO_ACTUAL:
RESULTADO_ESPERADO:
UBICACION:
EVIDENCIA:
HIPOTESIS_CAUSA:
ESTADO: RESUELTO

Cierre (P0):
Cuando se corrige:
Actualizar:
ESTADO: RESUELTO
agregar:
SOLUCION:
COMMIT:
FECHA_RESOLUCION:
Mover: pronto-docs/errors/... → pronto-docs/resolved/...
Append a pronto-docs/resueltos.txt:
YYYY-MM-DD | ID | TITULO | COMMIT | PROYECTO

Reapertura (P0):
Si reaparece: crear NUEVO archivo en pronto-docs/errors/ y referenciar ID anterior en DESCRIPCION.

Validaciones duras (P0):
- No existe fix sin archivo en pronto-docs/errors/
- No existe archivo en pronto-docs/resolved/ con ESTADO != RESUELTO
- No existe entrada en pronto-docs/resueltos.txt sin archivo correspondiente

Entrega:
- trazabilidad.py con StructuredLogger
- logging_config.py
- USER_MESSAGES
- Proceso de auditoria
- Validaciones de error tracking
```
