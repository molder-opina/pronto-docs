# 📦 PRONTO-LIBS: Checklist de Revisión

**ID:** CHECKLIST-LIBS-20250209
**FECHA:** 2026-02-09
**PROYECTO:** pronto-libs
**TOTAL ARCHIVOS:** 120

---

## 📁 CORE Y UTILIDADES (31 archivos)
- [ ]  1. `src/pronto_shared/__init__.py`
- [ ]  2. `src/pronto_shared/audit_middleware.py`
- [ ]  3. `src/pronto_shared/config.py`
- [ ]  4. `src/pronto_shared/constants.py`
- [ ]  5. `src/pronto_shared/create_tables.py`
- [ ]  6. `src/pronto_shared/customer_helpers.py`
- [ ]  7. `src/pronto_shared/datetime_utils.py`
- [ ]  8. `src/pronto_shared/db.py`
- [ ]  9. `src/pronto_shared/error_catalog.py`
- [ ] 10. `src/pronto_shared/error_handlers.py`
- [ ] 11. `src/pronto_shared/extensions.py`
- [ ] 12. `src/pronto_shared/fix_schema.py`
- [ ] 13. `src/pronto_shared/jwt_middleware.py`
- [ ] 14. `src/pronto_shared/jwt_service.py`
- [ ] 15. `src/pronto_shared/logging_config.py`
- [ ] 16. `src/pronto_shared/models.py`
- [ ] 17. `src/pronto_shared/normalize.py`
- [ ] 18. `src/pronto_shared/notification_stream_service.py`
- [ ] 19. `src/pronto_shared/permissions.py`
- [ ] 20. `src/pronto_shared/psycopg2_patch.py`
- [ ] 21. `src/pronto_shared/redis_client.py`
- [ ] 22. `src/pronto_shared/schemas.py`
- [ ] 23. `src/pronto_shared/scope_guard.py`
- [ ] 24. `src/pronto_shared/security_middleware.py`
- [ ] 25. `src/pronto_shared/seed_employees.py`
- [ ] 26. `src/pronto_shared/serializers.py`
- [ ] 27. `src/pronto_shared/socketio_manager.py`
- [ ] 28. `src/pronto_shared/table_utils.py`
- [ ] 29. `src/pronto_shared/url_helpers.py`
- [ ] 30. `src/pronto_shared/utils.py`
- [ ] 31. `src/pronto_shared/validation.py`

## 🔐 AUTH (2 archivos)
- [ ] 32. `src/pronto_shared/auth/__init__.py`
- [ ] 33. `src/pronto_shared/auth/service.py`

## 🔒 SECURITY (3 archivos)
- [ ] 34. `src/pronto_shared/security/__init__.py`
- [ ] 35. `src/pronto_shared/security/core.py`
- [ ] 36. `src/pronto_shared/security/csrf.py`

## 🤖 ORCHESTRATOR (8 archivos)
- [ ] 37. `src/pronto_shared/orchestrator/__init__.py`
- [ ] 38. `src/pronto_shared/orchestrator/classifier.py`
- [ ] 39. `src/pronto_shared/orchestrator/cli.py`
- [ ] 40. `src/pronto_shared/orchestrator/config.py`
- [ ] 41. `src/pronto_shared/orchestrator/memory.py`
- [ ] 42. `src/pronto_shared/orchestrator/ollama_client.py`
- [ ] 43. `src/pronto_shared/orchestrator/orchestrator.py`
- [ ] 44. `src/pronto_shared/orchestrator/router.py`

## 📦 SUPABASE (3 archivos)
- [ ] 45. `src/pronto_shared/supabase/__init__.py`
- [ ] 46. `src/pronto_shared/supabase/realtime.py`
- [ ] 47. `src/pronto_shared/supabase/storage.py`

## ⚙️ SERVICES - CORE (46 archivos)
- [ ] 48. `src/pronto_shared/services/__init__.py`
- [ ] 49. `src/pronto_shared/services/ai_image_service.py`
- [ ] 50. `src/pronto_shared/services/analytics_service.py`
- [ ] 51. `src/pronto_shared/services/analytics_service_new.py`
- [ ] 52. `src/pronto_shared/services/auth_service.py`
- [ ] 53. `src/pronto_shared/services/business_config_service.py`
- [ ] 54. `src/pronto_shared/services/business_info_service.py`
- [ ] 55. `src/pronto_shared/services/cancel_order_service.py`
- [ ] 56. `src/pronto_shared/services/custom_role_service.py`
- [ ] 57. `src/pronto_shared/services/customer_service.py`
- [ ] 58. `src/pronto_shared/services/day_period_service.py`
- [ ] 59. `src/pronto_shared/services/dining_session_service.py`
- [ ] 60. `src/pronto_shared/services/email_service.py`
- [ ] 61. `src/pronto_shared/services/employee_service.py`
- [ ] 62. `src/pronto_shared/services/enhanced_search_service.py`
- [ ] 63. `src/pronto_shared/services/feedback_email_service.py`
- [ ] 64. `src/pronto_shared/services/feedback_service.py`
- [ ] 65. `src/pronto_shared/services/image_service.py`
- [ ] 66. `src/pronto_shared/services/menu_service.py`
- [ ] 67. `src/pronto_shared/services/menu_validation.py`
- [ ] 68. `src/pronto_shared/services/modifiers_service.py`
- [ ] 69. `src/pronto_shared/services/notification_service.py`
- [ ] 70. `src/pronto_shared/services/notifications_service.py`
- [ ] 71. `src/pronto_shared/services/order_events.py`
- [ ] 72. `src/pronto_shared/services/order_modification_service.py`
- [ ] 73. `src/pronto_shared/services/order_service.py`
- [ ] 74. `src/pronto_shared/services/order_state_machine.py`
- [ ] 75. `src/pronto_shared/services/order_write_service.py`
- [ ] 76. `src/pronto_shared/services/payments.py`
- [ ] 77. `src/pronto_shared/services/price_service.py`
- [ ] 78. `src/pronto_shared/services/recommendation_service.py`
- [ ] 79. `src/pronto_shared/services/report_export_service.py`
- [ ] 80. `src/pronto_shared/services/role_service.py`
- [ ] 81. `src/pronto_shared/services/secret_service.py`
- [ ] 82. `src/pronto_shared/services/settings_service.py`
- [ ] 83. `src/pronto_shared/services/staff_events.py`
- [ ] 84. `src/pronto_shared/services/status_label_service.py`
- [ ] 85. `src/pronto_shared/services/ticket_pdf_service.py`
- [ ] 86. `src/pronto_shared/services/token_service.py`
- [ ] 87. `src/pronto_shared/services/waiter_call_service.py`
- [ ] 88. `src/pronto_shared/services/waiter_calls.py`
- [ ] 89. `src/pronto_shared/services/waiter_table_assignment_service.py`

## 📊 SERVICES - ANALYTICS (6 archivos)
- [ ] 90. `src/pronto_shared/services/analytics/__init__.py`
- [ ] 91. `src/pronto_shared/services/analytics/customer_analytics.py`
- [ ] 92. `src/pronto_shared/services/analytics/employee_analytics.py`
- [ ] 93. `src/pronto_shared/services/analytics/operational_analytics.py`
- [ ] 94. `src/pronto_shared/services/analytics/product_analytics.py`
- [ ] 95. `src/pronto_shared/services/analytics/revenue_analytics.py`

## 📦 SERVICES - ORDERS (5 archivos)
- [ ] 96. `src/pronto_shared/services/orders/__init__.py`
- [ ] 97. `src/pronto_shared/services/orders/customer_resolver.py`
- [ ] 98. `src/pronto_shared/services/orders/item_processor.py`
- [ ] 99. `src/pronto_shared/services/orders/session_manager.py`
- [ ] 100. `src/pronto_shared/services/orders/validators.py`

## 💳 SERVICES - PAYMENT PROVIDERS (6 archivos)
- [ ] 101. `src/pronto_shared/services/payment_providers/__init__.py`
- [ ] 102. `src/pronto_shared/services/payment_providers/base_provider.py`
- [ ] 103. `src/pronto_shared/services/payment_providers/cash_provider.py`
- [ ] 104. `src/pronto_shared/services/payment_providers/clip_provider.py`
- [ ] 105. `src/pronto_shared/services/payment_providers/payment_gateway.py`
- [ ] 106. `src/pronto_shared/services/payment_providers/stripe_provider.py`

---

## 📊 RESUMEN DE PROGRESO

| Categoría | Total | Revisados | Pendientes |
|-----------|-------|-----------|------------|
| Core y Utilidades | 31 | 0 | 31 |
| Auth | 2 | 0 | 2 |
| Security | 3 | 0 | 3 |
| Orchestrator | 8 | 0 | 8 |
| Supabase | 3 | 0 | 3 |
| Services Core | 46 | 0 | 46 |
| Services Analytics | 6 | 0 | 6 |
| Services Orders | 5 | 0 | 5 |
| Services Payment Providers | 6 | 0 | 6 |
| **TOTAL** | **120** | **0** | **120** |

---

## ✅ CRITERIOS DE REVISIÓN POR ARCHIVO

Para cada archivo verificar:

1. **Seguridad**
   - [ ] No expone PII
   - [ ] Validación de inputs
   - [ ] Manejo de excepciones seguro

2. **Arquitectura**
   - [ ] Cumple AGENTS.md
   - [ ] No duplica lógica de otro servicio
   - [ ] Usa dependencias correctas

3. **Lógica de Negocio**
   - [ ] Roles canónicos (waiter/chef/cashier/admin/system)
   - [ ] Workflow states正确
   - [ ] Validaciones correctas

4. **Observabilidad**
   - [ ] Logging estructurado
   - [ ] Error handling adecuado

---

## 🚨 FORMATO PARA PROBLEMAS ENCONTRADOS

```
### PROBLEMA: <título>
**Archivo:** ruta/archivo.py
**Línea:** N
**Severidad:** alta/media/baja
**Descripción:** ...

**Recomendación:** ...
```

---

**ÚLTIMA ACTUALIZACIÓN:** 2026-02-09
**ESTADO:** PENDIENTE DE INICIAR
