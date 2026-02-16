ID: 20260215_SCHEMA_INCONSISTENCY
FECHA: 2026-02-15
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: Modelos sin tabla en DB - 17 tablas faltantes
DESCRIPCION:
Se encontraron 50 modelos definidos en models.py pero solo 33 tablas en la base de datos. Hay modelos que referencian tablas que no existen en la DB.
PASOS_REPRODUCIR:
1. Contar modelos en models.py: grep -c "__tablename__" models.py
2. Contar tablas en DB: SELECT COUNT(*) FROM pg_tables WHERE schemaname = 'public'
RESULTADO_ACTUAL: 50 modelos vs 33 tablas
RESULTADO_ESPERADO: Todos los modelos deberían tener su tabla correspondiente
UBICACION: 
- modelos: pronto-libs/src/pronto_shared/models.py
- DB: PostgreSQL pronto
EVIDENCIA:
Tablas faltantes identificadas (modelos sin tabla):
- pronto_employee_preferences
- pronto_order_status_labels
- pronto_order_modifications
- pronto_notifications
- pronto_promotions
- pronto_discount_codes
- pronto_secrets
- pronto_support_tickets
- pronto_split_bills
- pronto_split_bill_people
- pronto_split_bill_assignments
- pronto_custom_roles
- pronto_role_permissions
- pronto_waiter_table_assignments
- pronto_table_transfer_requests
- pronto_realtime_events
- pronto_recommendation_change_log
- pronto_keyboard_shortcuts
- pronto_feedback_questions
- pronto_feedback_tokens
- system_handoff_tokens
- audit_logs
HIPOTESIS_CAUSA:
Los modelos fueron creados pero las migraciones no se ejecutaron o fueron eliminadas.
ESTADO: ABIERTO
