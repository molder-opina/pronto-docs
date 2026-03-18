ID: PRONTO-PAY-050
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: alta
TITULO: Consistencia de caché financiera incompleta sin invalidación garantizada
DESCRIPCION: El sistema no implementa mecanismos adecuados de invalidación de caché financiera. Cuando se procesan pagos o se modifican totales, no se garantiza que las cachés relacionadas se invaliden correctamente, lo que puede causar inconsistencias entre los datos en caché y los datos reales.
PASOS_REPRODUCIR:
1. Crear una sesión y procesar un pago
2. Consultar los datos desde caché
3. Procesar otro pago que modifique los totales
4. Consultar nuevamente los datos desde caché
5. Observar si los datos en caché están actualizados
RESULTADO_ACTUAL: Sin mecanismos adecuados de invalidación de caché financiera, lo que puede causar inconsistencias entre los datos en caché y los datos reales.
RESULTADO_ESPERADO: Deben existir mecanismos adecuados de invalidación de caché financiera que garanticen que las cachés relacionadas se invaliden correctamente cuando se procesan pagos o se modifican totales.
UBICACION:
- pronto-libs/src/pronto_shared/services/payment_service.py (procesamiento de pagos)
- pronto-libs/src/pronto_shared/services/cache_service.py (servicio de caché)
EVIDENCIA: El análisis del código muestra que no existen mecanismos adecuados de invalidación de caché financiera que se activen automáticamente cuando se procesan pagos o se modifican totales.
HIPOTESIS_CAUSA: La implementación inicial no consideró adecuadamente los requisitos de consistencia de caché en entornos con alto rendimiento y múltiples fuentes de datos.
ESTADO: ABIERTO