ID: PRONTO-PAY-040
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: media
TITULO: Reportes financieros incompletos sin datos de auditoría adecuados
DESCRIPCION: El sistema no genera reportes financieros completos con todos los datos necesarios para auditoría y análisis financiero. Los reportes actuales pueden faltar información crítica como detalles de pagos parciales, propinas, métodos de pago, empleados procesadores, y otros metadatos necesarios para análisis financiero completo.
PASOS_REPRODUCIR:
1. Analizar los endpoints y servicios de reportes financieros
2. Observar qué información se incluye en los reportes
3. Verificar si se incluyen todos los metadatos necesarios para auditoría
4. Identificar datos faltantes en los reportes financieros
RESULTADO_ACTUAL: Reportes financieros incompletos que no proporcionan suficiente información para auditoría y análisis financiero completo.
RESULTADO_ESPERADO: Los reportes financieros deben incluir todos los metadatos necesarios para auditoría y análisis financiero completo, incluyendo detalles de pagos parciales, propinas, métodos de pago, empleados procesadores, etc.
UBICACION:
- pronto-api/src/api_app/routes/analytics/ (reportes financieros)
- pronto-libs/src/pronto_shared/services/analytics_service.py (servicios de análisis)
EVIDENCIA: El análisis del código muestra que los reportes financieros actuales pueden faltar información crítica necesaria para auditoría y análisis financiero completo.
HIPOTESIS_CAUSA: La implementación inicial de reportes se enfocó en métricas básicas sin considerar completamente los requisitos de auditoría y análisis financiero detallado.
ESTADO: ABIERTO