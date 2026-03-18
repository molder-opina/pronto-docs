ID: PRONTO-PAY-060
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: crítica
TITULO: Consistencia de streams financieros incompleta sin garantía de procesamiento exactly-once
DESCRIPCION: El sistema no garantiza el procesamiento exactly-once de eventos financieros en arquitecturas de streaming. Cuando se procesan pagos o se generan eventos financieros que se publican en streams, no se garantiza que los eventos se procesen exactamente una vez, lo que puede causar duplicación o pérdida de eventos financieros críticos.
PASOS_REPRODUCIR:
1. Configurar un sistema con streaming de eventos
2. Crear una sesión y procesar un pago que genere eventos en streams
3. Simular condiciones de red adversas durante el procesamiento
4. Observar si los eventos se procesan exactamente una vez
5. Verificar si existe garantía de procesamiento exactly-once
RESULTADO_ACTUAL: Sin garantía de procesamiento exactly-once de eventos financieros en arquitecturas de streaming, lo que puede causar duplicación o pérdida de eventos financieros críticos cuando ocurren condiciones de red adversas.
RESULTADO_ESPERADO: Debe existir una garantía de procesamiento exactly-once que asegure que todos los eventos financieros se procesen exactamente una vez, manteniendo la integridad de los datos financieros en arquitecturas de streaming.
UBICACION:
- pronto-libs/src/pronto_shared/services/payment_service.py (procesamiento de pagos)
- pronto-libs/src/pronto_shared/services/stream_service.py (servicio de streaming)
EVIDENCIA: El análisis del código muestra que no existe garantía de procesamiento exactly-once para eventos financieros en arquitecturas de streaming, lo que puede causar duplicación o pérdida de eventos financieros críticos.
HIPOTESIS_CAUSA: La implementación inicial se enfocó en arquitecturas batch sin considerar adecuadamente los requisitos de procesamiento exactly-once en arquitecturas de streaming en tiempo real.
ESTADO: ABIERTO