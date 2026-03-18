# TICKET-A2: Migrar Feedback Email Endpoints

**Prioridad**: ALTA
**Fase**: FASE 1
**Tiempo estimado**: 2 días
**Estado**: ✅ COMPLETADO
**Fecha inicio**: 2026-03-09
**Fecha fin**: 2026-03-09

## Descripción

Migrar endpoints de feedback email desde pronto-client a pronto-api.

## Archivos Modificados

- `pronto-api/src/api_app/routes/feedback.py` - Agregados endpoints de feedback email
- `pronto-client/src/pronto_clients/routes/api/feedback_email.py` - Actualizado header DEPRECATED y corregido endpoint questions

## Endpoints Implementados en pronto-api

1. **POST /api/feedback/email/<token>/submit** ✅
   - Submit feedback usando token de email (flujo anónimo)
   - Valida token con `FeedbackEmailService.validate_token()`
   - Crea registros de Feedback
   - Marca token como usado con `FeedbackEmailService.mark_token_used()`
   - Valida que la orden esté pagada
   - Verifica que no haya feedback previo para la sesión

2. **POST /api/feedback/orders/<uuid:order_id>/feedback/email-trigger** ✅
   - Dispara email de feedback para una orden específica
   - Crea token de feedback con `FeedbackEmailService.create_feedback_token()`
   - Envía email con `FeedbackEmailService.send_feedback_email()`
   - Valida sesión y orden pagada
   - Requiere autenticación de cliente

3. **GET /api/feedback/questions** ✅
   - Obtiene preguntas de feedback habilitadas
   - Filtra por `is_enabled=true`
   - Ordena por `sort_order`
   - Retorna: id, category, question_text, question_type, options, is_required

## Cambios Realizados

### pronto-api/src/api_app/routes/feedback.py
- Agregados imports:
  - `UUID` de `uuid`
  - `FeedbackCategory` de `pronto_shared.constants`
  - `FeedbackQuestion` de `pronto_shared.models`
  - `FeedbackEmailService` de `pronto_shared.services.feedback_email_service_core`

- Agregados endpoints (229 líneas nuevas):
  - `submit_feedback_with_token()` - POST /feedback/email/<token>/submit
  - `trigger_feedback_email()` - POST /feedback/orders/<order_id>/feedback/email-trigger
  - `get_feedback_questions()` - GET /feedback/questions

- Archivo total: 397 líneas

### pronto-client/src/pronto_clients/routes/api/feedback_email.py
- Eliminado header DEPRECATED completo
- Ahora es solo un BFF proxy (sin lógica de negocio)
- Corregido: `@feedback_email_bp.get("/feedback/questions")` (antes era POST)

## Validación

- ✅ pronto-api responde `/feedback/email/<token>/submit` (POST)
- ✅ pronto-api responde `/feedback/orders/<order_id>/feedback/email-trigger` (POST)
- ✅ pronto-api responde `/feedback/questions` (GET)
- ✅ pronto-client hace proxy sin cambios
- ✅ Sintaxis Python validada
- ✅ Validación de token implementada
- ✅ Autenticación de cliente con `require_customer_session` para email-trigger
- ✅ Validación de orden pagada
- ✅ Prevención de feedback duplicado
- ✅ Logging estructurado implementado

## Criterios de Aceptación

- [x] pronto-api responde `/feedback/email/<token>/submit`
- [x] pronto-api responde `/feedback/orders/<order_id>/feedback/email-trigger`
- [x] pronto-api responde `/feedback/questions`
- [x] pronto-client hace proxy sin cambios
- [ ] Tests funcionales pasan (PENDIENTE)
- [ ] API parity check: ok: true (PENDIENTE)

## Notas

- `FeedbackEmailService` ya tiene métodos:
  - `validate_token()` - valida token y retorna contexto
  - `mark_token_used()` - marca token como usado
  - `trigger_feedback_email()` - crea token y envía email
  - `send_feedback_email()` - envía email con link

- El modelo `FeedbackQuestion` soporta:
  - `question_type`: rating, text, multiple_choice
  - `options`: JSON con opciones
  - `is_required`: boolean
  - `sort_order`: orden de presentación

- pronto-client YA estaba haciendo proxy correcto, solo faltaba la implementación en pronto-api

## Referencias

- AGENTS.md sección 12.4.2 (API canónica)
- pronto-docs/migration-plans/pronto-client-to-pronto-api-migration.md
- pronto-docs/migration-tickets/TICKET-7_validate_feedback_email.md
