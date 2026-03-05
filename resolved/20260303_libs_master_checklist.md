ID: AUDIT-20260303-LIBS-MASTER
FECHA: 2026-03-03
PROYECTO: pronto-libs
SEVERIDAD: baja
TITULO: Master Checklist - Auditoría Archivo por Archivo de pronto-libs

DESCRIPCION: |
  Este archivo rastrea el progreso de la auditoría detallada de cada archivo fuente en `pronto-libs/src/pronto_shared`. 

ESTADO: COMPLETADO

CHECKLIST_AUDITORIA:
  **Core & Utilities**
  - [x] `__init__.py`
  - [x] `config.py` (Ok, detectado código inalcanzable CODE-20260303-017)
  - [x] `config_contract.py` (Ok)
  - [x] `constants.py` (Ok, detectado conflicto constantes propina CODE-20260303-014)
  - [x] `datetime_utils.py` (Ok, detectada falta de helpers de formateo CODE-20260303-011)
  - [x] `db.py` (Ok)
  - [x] `error_catalog.py` (Ok)
  - [x] `error_handlers.py` (Ok)
  - [x] `extensions.py` (Ok)
  - [x] `fix_schema.py` (Script legacy)
  - [x] `logging_config.py` (Ok)
  - [x] `models.py` (Ok, detectado monolito ARCH-20260303-011 e inconsistencia ID DATA-20260303-003)
  - [x] `normalize.py` (Ok)
  - [x] `permissions.py` (Ok)
  - [x] `psycopg2_patch.py` (Ok)
  - [x] `redis_client.py` (Ok)
  - [x] `schemas.py` (Ok)
  - [x] `serializers.py` (Ok)
  - [x] `table_utils.py` (Ok)
  - [x] `trazabilidad.py` (Ok)
  - [x] `url_helpers.py` (Ok)
  - [x] `utils.py` (Ok)
  - [x] `validation.py` (Ok)

  **Security & Auth**
  - [x] `auth/__init__.py`
  - [x] `auth/decorators.py`
  - [x] `auth/service.py` (Ok, detectada duplicación ARCH-20260303-008)
  - [x] `jwt_middleware.py` (Ok, detectado fail-open SEC-20260303-004)
  - [x] `jwt_service.py` (Ok)
  - [x] `security.py` (Ok)
  - [x] `security_middleware.py` (Ok, detectado fix rate limit)
  - [x] `internal_auth.py` (Ok)
  - [x] `audit_middleware.py` (Ok)
  - [x] `scope_guard.py` (Ok)
  - [x] `console_ctx.py` (Ok)
  - [x] `security/csrf.py` (Ok)
  - [x] `security/core.py` (Ok)

  **Services (General)**
  - [x] `services/__init__.py`
  - [x] `services/area_service.py` (Ok)
  - [x] `services/auth_service.py` (Ok, detectada duplicación ARCH-20260303-008)
  - [x] `services/business_config_service.py` (Ok)
  - [x] `services/business_info_service.py` (Ok)
  - [x] `services/customer_service.py` (Ok)
  - [x] `services/customer_session_store.py` (Ok)
  - [x] `services/day_period_service.py` (Ok)
  - [x] `services/employee_service.py` (Ok)
  - [x] `services/feedback_service.py` (Ok)
  - [x] `services/image_service.py` (Ok)
  - [x] `services/ai_image_service.py` (Ok)
  - [x] `services/menu_service.py` (Ok)
  - [x] `services/menu_validation.py` (Ok)
  - [x] `services/modifiers_service.py` (Ok, detectada inconsistencia nomenclatura CODE-20260303-026)
  - [x] `services/notification_service.py` (Ok, detectada triplicación ARCH-20260303-007)
  - [x] `services/notifications_service.py` (Ok, detectada triplicación ARCH-20260303-007)
  - [x] `services/notifications.py` (Ok, detectada triplicación ARCH-20260303-007)
  - [x] `services/notification_stream_service.py` (Ok)
  - [x] `services/price_service.py` (Ok)
  - [x] `services/rbac_service.py` (Ok)
  - [x] `services/recommendation_service.py` (Ok, detectado error indentación CODE-20260303-027)
  - [x] `services/report_export_service.py` (Ok)
  - [x] `services/secret_service.py` (Ok)
  - [x] `services/settings_service.py` (Ok)
  - [x] `services/shortcuts_static_service.py` (Ok, detectado acoplamiento ARCH-20260303-010)
  - [x] `services/status_label_service.py` (Ok)
  - [x] `services/table_service.py` (Ok)
  - [x] `services/table_context_service.py` (Ok)
  - [x] `services/ticket_pdf_service.py` (Ok)
  - [x] `services/token_service.py` (Ok)
  - [x] `services/waiter_calls.py` (Ok)
  - [x] `services/waiter_call_service.py` (Ok)
  - [x] `services/waiter_table_assignment_service.py` (Ok)
  - [x] `services/seed.py` (Ok, detectado obesidad CODE-20260303-012)
  - [x] `services/seed_employees.py` (Ok)

  **Services (Orders & Payments)**
  - [x] `services/order_service.py` (Ok, detectada violación P0 CODE-20260303-007)
  - [x] `services/order_write_service.py` (Ok)
  - [x] `services/order_modification_service.py` (Ok)
  - [x] `services/order_state_machine.py` (Ok)
  - [x] `services/order_events.py` (Ok)
  - [x] `services/cancel_order_service.py` (Ok)
  - [x] `services/split_bill_service.py` (Ok)
  - [x] `services/payment_service.py` (Ok)
  - [x] `services/payments.py` (Ok)
  - [x] `services/payment_providers/base_provider.py` (Ok)
  - [x] `services/payment_providers/payment_gateway.py` (Ok)
  - [x] `services/payment_providers/cash_provider.py` (Ok)
  - [x] `services/payment_providers/stripe_provider.py` (Ok)
  - [x] `services/payment_providers/clip_provider.py` (Ok)
  - [x] `services/orders/validators.py` (Ok)
  - [x] `services/orders/session_manager.py` (Ok)
  - [x] `services/orders/item_processor.py` (Ok)
  - [x] `services/orders/customer_resolver.py` (Ok)

  **Analytics**
  - [x] `services/analytics_service.py` (Ok)
  - [x] `services/analytics_service_new.py` (Ok, detectada duplicación CODE-20260303-018)
  - [x] `services/analytics/product_analytics.py` (Ok)
  - [x] `services/analytics/customer_analytics.py` (Ok)
  - [x] `services/analytics/employee_analytics.py` (Ok)
  - [x] `services/analytics/operational_analytics.py` (Ok)
  - [x] `services/analytics/revenue_analytics.py` (Ok)

  **Orchestrator & AI**
  - [x] `orchestrator/classifier.py` (Ok)
  - [x] `orchestrator/config.py` (Ok)
  - [x] `orchestrator/ollama_client.py` (Ok)
  - [x] `orchestrator/memory.py` (Ok, detectado NameError CODE-20260303-016)
  - [x] `orchestrator/cli.py` (Ok)
  - [x] `orchestrator/orchestrator.py` (Ok)
  - [x] `orchestrator/router.py` (Ok)

  **External Integrations**
  - [x] `supabase/realtime.py` (Ok)
  - [x] `supabase/storage.py` (Ok)

ACCIONES_PENDIENTES:
  - Ninguna. Auditoría de pronto-libs completada.

SOLUCION: |
  Auditoría finalizada con éxito. Se han documentado todos los hallazgos en reportes de bug individuales. La librería compartida es el núcleo más complejo y presenta la mayor acumulación de deuda técnica por duplicidad de servicios.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-03
