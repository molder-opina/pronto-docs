ID: TEST-007
FECHA: 2026-03-05
PROYECTO: pronto-libs
SEVERIDAD: baja
TITULO: Warning de relación duplicada en DiningSession.payments
DESCRIPCION: SQLAlchemy lanza warning: "relationship 'DiningSession.payments' will copy column pronto_dining_sessions.id to column pronto_payments.session_id, which conflicts with relationship(s): 'Payment.session'"
PASOS_REPRODUCIR:
1. Importar modelos en contexto de Flask
2. Observar SAWarning en logs
RESULTADO_ACTUAL: Warning de relaciones conflictivas
RESULTADO_ESPERADO: Las relaciones deberían estar correctamente configuradas
UBICACION: pronto-libs/src/pronto_shared/models/order_models.py
EVIDENCIA: Warning aparece en todos los tests
HIPOTESIS_CAUSA: Las relaciones Payment.session y DiningSession.payments ambas mapean la misma foreign key
ESTADO: RESUELTO
SOLUCION: Se alinearon relaciones SQLAlchemy con `back_populates` en `Payment.session` y `DiningSession.payments`, eliminando el warning de mapeo conflictivo sobre `session_id`.
COMMIT: fea629d
FECHA_RESOLUCION: 2026-03-05
