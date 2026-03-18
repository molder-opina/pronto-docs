ID: PRONTO-PAY-026
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: media
TITULO: Trazabilidad financiera incompleta en operaciones de pago
DESCRIPCION: El sistema no registra adecuadamente la trazabilidad financiera completa para operaciones de pago. Aunque se guarda processed_by_employee_id, faltan campos críticos como method, reference, created_at, confirmed_at, y otros metadatos necesarios para auditoría financiera completa.
PASOS_REPRODUCIR:
1. Analizar el modelo Payment en order_models.py
2. Observar los campos disponibles para trazabilidad
3. Verificar qué información se registra durante operaciones de pago
4. Identificar campos faltantes para auditoría financiera completa
RESULTADO_ACTUAL: Trazabilidad financiera incompleta que no proporciona suficiente información para auditoría financiera completa y resolución de disputas.
RESULTADO_ESPERADO: Cada operación de pago debe registrar todos los metadatos necesarios para auditoría financiera completa, incluyendo método, referencia, timestamps, empleado procesador, etc.
UBICACION:
- pronto-libs/src/pronto_shared/models/order_models.py (modelo Payment)
- pronto-libs/src/pronto_shared/services/payment_service.py (procesamiento de pagos)
EVIDENCIA: El modelo Payment actual solo incluye id, session_id, amount, method, reference, y created_by, pero falta información crítica como timestamps detallados, estado de confirmación, y otros metadatos necesarios para auditoría.
HIPOTESIS_CAUSA: La implementación inicial del modelo Payment se enfocó en la funcionalidad básica sin considerar completamente los requisitos de auditoría financiera.
ESTADO: ABIERTO