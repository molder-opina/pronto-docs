ID: BUG-20260215-002
FECHA: 2026-02-15
PROYECTO: pronto-employees, pronto-client
SEVERIDAD: media
TITULO: Uso de current_app.logger en lugar de StructuredLogger
DESCRIPCION: Se encontró uso extenso de current_app.logger en lugar del StructuredLogger requerido por la sección 0.6.2 de AGENTS.md. El código usa logging plano en lugar del formato JSON estructurado con correlation_id, user_id, etc.
PASOS_REPRODUCIR: Ejecutar: rg -n --hidden "current_app\.logger" pronto-employees/src/pronto_employees/ pronto-client/src/pronto_clients/
RESULTADO_ACTUAL: - pronto-employees: 12 usos de current_app.logger
- pronto-client: 38 usos de current_app.logger + 1 logging.getLogger(__name__)
RESULTADO_ESPERADO: Usar StructuredLogger de pronto_shared/trazabilidad.py con formato JSON estructurado que incluya: timestamp, level, correlation_id, service, action, user_id, user_type, duration_ms, message, error
UBICACION: 
- pronto-employees/src/pronto_employees/routes/*/auth.py
- pronto-employees/src/pronto_employees/routes/api/*.py
- pronto-client/src/pronto_clients/routes/api/*.py
EVIDENCIA: 
- pronto-employees/routes/system/auth.py: current_app.logger.error
- pronto-employees/routes/cashier/auth.py: current_app.logger.error
- pronto-employees/routes/chef/auth.py: current_app.logger.error
- pronto-employees/routes/admin/auth.py: current_app.logger.error
- pronto-employees/routes/api/config.py: current_app.logger.warning
- pronto-employees/routes/api/auth.py: current_app.logger.error
- pronto-employees/routes/waiter/auth.py: current_app.logger.error
- pronto-client/routes/api/waiter_calls.py: current_app.logger.warning, current_app.logger.info
- pronto-client/routes/api/split_bills.py: current_app.logger.error
- pronto-client/routes/api/feedback_email.py: current_app.logger.error, current_app.logger.info
- pronto-client/routes/api/stripe_payments.py: current_app.logger.error, current_app.logger.info
- pronto-client/routes/api/support.py: current_app.logger.error
- pronto-client/routes/api/payments.py: current_app.logger.info, current_app.logger.error
HIPOTESIS_CAUSA: El código fue escrito antes de que se definieran las reglas de trazabilidad en AGENTS.md, o los desarrolladores no conocían la utilidad StructuredLogger.
ESTADO: ABIERTO
