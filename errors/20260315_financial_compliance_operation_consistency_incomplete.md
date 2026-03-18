ID: PRONTO-PAY-077
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: crítica
TITULO: Consistencia de operaciones financieras con compliance incompleta sin auditoría regulatoria
DESCRIPCION: El sistema no implementa una auditoría regulatoria adecuada para las operaciones financieras críticas. Cuando se procesan pagos o se realizan operaciones financieras, no se registran los metadatos necesarios para cumplir con requisitos regulatorios (PCI DSS, AML, KYC) ni se genera un trail de auditoría completo que permita demostrar cumplimiento ante autoridades regulatorias.
PASOS_REPRODUCIR:
1. Crear una sesión y procesar un pago
2. Observar los metadatos y registros de auditoría generados
3. Verificar si se registran los campos requeridos por PCI DSS, AML, KYC
4. Comprobar si existe un trail de auditoría completo y seguro
5. Analizar si se pueden generar reportes regulatorios adecuados
RESULTADO_ACTUAL: Sin auditoría regulatoria adecuada para las operaciones financieras críticas, lo que dificulta el cumplimiento con requisitos regulatorios (PCI DSS, AML, KYC) y la generación de reportes para autoridades regulatorias.
RESULTADO_ESPERADO: Debe existir una auditoría regulatoria adecuada que registre todos los metadatos necesarios para cumplir con requisitos regulatorios, genere un trail de auditoría completo y seguro, y permita la generación de reportes regulatorios adecuados.
UBICACION:
- pronto-libs/src/pronto_shared/models/order_models.py (modelo Payment)
- pronto-libs/src/pronto_shared/services/payment_service.py (procesamiento de pagos)
- pronto-libs/src/pronto_shared/trazabilidad.py (registro de auditoría)
- pronto-libs/src/pronto_shared/compliance_service.py (servicio de compliance)
EVIDENCIA: El análisis del código muestra que no existe una auditoría regulatoria adecuada para las operaciones financieras críticas, especialmente para requisitos PCI DSS que requieren protección de datos de tarjetas, enmascaramiento de PAN, y registro de eventos de seguridad.
HIPOTESIS_CAUSA: La implementación inicial no consideró adecuadamente los requisitos regulatorios para operaciones financieras en entornos de producción donde el cumplimiento con estándares como PCI DSS, AML, y KYC es obligatorio para procesar pagos con tarjetas y prevenir lavado de dinero.
ESTADO: ABIERTO