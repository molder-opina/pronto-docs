
# Estándar de Logging y Auditoría - Pronto System

Este documento define el estándar de logging unificado para todos los microservicios backend del ecosistema Pronto (Employee App, Client App, API Gateway).

## Propósito
El objetivo es garantizar la trazabilidad completa de cada operación, permitiendo diagnosticar problemas, auditar acciones de usuarios y medir rendimiento mediante el análisis de logs estructurados.

## Formato de Log de Auditoría

Cada operación HTTP debe generar una entrada de log con el siguiente formato, separado por pipes (`|`):

```text
USER|ACTION|TYPE|CODE|RETVAL|SESSION_ID|TIME
```

### Definición de Campos

| Campo | Descripción | Ejemplo |
|-------|-------------|---------|
| **USER** | Identificador del usuario (Email) o 'ANONYMOUS'. | `admin@pronto.test` |
| **ACTION** | Verbo HTTP y Ruta solicitada. | `GET /api/menu` |
| **TYPE** | Tipo de evento: `RESPONSE` (traza final) o `ERROR`. | `RESPONSE` |
| **CODE** | Código de estado HTTP. | `200` |
| **RETVAL** | Tamaño de la respuesta (bytes) o mensaje de retorno. | `1540 bytes` |
| **SESSION_ID** | ID de traza de sesión (Cookie o Header) para correlación. | `e4f5a...` |
| **TIME** | Tiempo de procesamiento en milisegundos. | `45ms` |

### Ejemplo de Salida

```text
[INFO] admin@pronto.test|POST /api/orders|RESPONSE|201|45 bytes|a1b2c3d4|120ms
[WARN] waiter1@pronto.test|GET /api/admin|RESPONSE|403|Forbidden|x9y8z7|10ms
[ERROR] SYSTEM|AUDIT_FAIL|ERROR|500|Database connection failed|UNKNOWN|0ms
```

## Implementación

El estándar se aplica mediante el middleware `shared.audit_middleware.py`.
Este intercepta `before_request` para iniciar el cronómetro y `after_request` para generar la línea de log.

### Niveles de Log

- **INFO**: Operaciones exitosas (2xx, 3xx).
- **WARNING**: Errores de cliente (4xx).
- **ERROR**: Errores de servidor (5xx).

## Ubicación de Logs

En el entorno Docker, los logs se envían a `stdout` y son capturados por el driver de logging de Docker.
Pueden consultarse mediante:
```bash
docker logs pronto-employee
docker logs pronto-client
```
