ID: PRONTO-PAY-057
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: crítica
TITULO: Consistencia de microservicios financieros incompleta sin patrón Saga
DESCRIPCION: El sistema no implementa un patrón adecuado de Saga para garantizar la consistencia de datos financieros en arquitecturas de microservicios. Cuando se procesan pagos que involucran múltiples servicios, no se garantiza que todas las operaciones se completen consistentemente o que se realice un rollback adecuado en caso de fallos.
PASOS_REPRODUCIR:
1. Configurar una arquitectura de microservicios
2. Crear una sesión y procesar un pago que involucre múltiples servicios
3. Simular un fallo en uno de los servicios durante el procesamiento
4. Observar si se realiza un rollback adecuado en todos los servicios
5. Verificar si existe un patrón de Saga implementado
RESULTADO_ACTUAL: Sin patrón adecuado de Saga para garantizar la consistencia de datos financieros en arquitecturas de microservicios, lo que puede causar inconsistencias financieras graves cuando ocurren fallos parciales durante el procesamiento de pagos.
RESULTADO_ESPERADO: Debe existir un patrón adecuado de Saga que garantice que todas las operaciones se completen consistentemente o que se realice un rollback adecuado en todos los servicios en caso de fallos.
UBICACION:
- pronto-libs/src/pronto_shared/services/payment_service.py (procesamiento de pagos)
- pronto-libs/src/pronto_shared/services/saga_service.py (servicio de Saga)
EVIDENCIA: El análisis del código muestra que no existe un patrón adecuado de Saga para garantizar la consistencia de datos financieros en arquitecturas de microservicios con múltiples servicios procesando operaciones financieras.
HIPOTESIS_CAUSA: La implementación inicial se enfocó en arquitecturas monolíticas sin considerar adecuadamente los requisitos de consistencia en arquitecturas de microservicios distribuidos.
ESTADO: ABIERTO