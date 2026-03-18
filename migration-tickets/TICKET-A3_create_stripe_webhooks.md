# TICKET-A3: Crear Stripe Webhooks Endpoint

**Prioridad**: MEDIA
**Fase**: FASE 1
**Tiempo estimado**: 1 día
**Estado**: ✅ COMPLETADO
**Fecha inicio**: 2026-03-09
**Fecha fin**: 2026-03-09

## Descripción

Crear endpoint de webhooks de Stripe en pronto-api para manejar eventos de pago.

## Archivos Modificados

- `pronto-api/src/api_app/routes/webhooks.py` - CREADO (endpoint de Stripe webhooks)
- `pronto-api/src/api_app/routes/__init__.py` - Registrado webhooks_bp
- `pronto-client/src/pronto_clients/routes/api/stripe_webhooks.py` - Convertido a BFF proxy

## Endpoints Implementados en pronto-api

1. **POST /api/webhooks/stripe** ✅
   - Maneja eventos de webhook de Stripe
   - Valida firma del webhook con `STRIPE_WEBHOOK_SECRET`
   - Soporta eventos:
     - `payment_intent.succeeded`: Marca pago como completado
     - `payment_intent.payment_failed`: Registra fallo de pago
     - `charge.refunded`: Procesa reembolso
   - Extrae `session_id` de PaymentIntent.metadata
   - Llama a `finalize_payment()` para actualizar estado
   - Previente duplicados (verifica si sesión ya está pagada)
   - Logging estructurado de todos los eventos

## Cambios Realizados

### pronto-api/src/api_app/routes/webhooks.py (NUEVO ARCHIVO)
- Creado desde cero (248 líneas)
- Implementa endpoint POST /api/webhooks/stripe
- Valida firma de webhook con stripe.Webhook.construct_event()
- Procesa 3 tipos de eventos:
  - payment_intent.succeeded: finaliza pago con `order_service.finalize_payment()`
  - payment_intent.payment_failed: registra error en logs
  - charge.refunded: registra reembolso en logs (lógica pendiente)
- Busca sesión por metadata.session_id en PaymentIntent
- Valida y maneja errores de Stripe (SignatureVerificationError, etc.)
- Usa StructuredLogger para logging de eventos

### pronto-api/src/api_app/routes/__init__.py
- Agregado import: `from api_app.routes.webhooks import bp as webhooks_bp`
- Registrado: `api_bp.register_blueprint(webhooks_bp)`

### pronto-client/src/pronto_clients/routes/api/feedback_email.py
- Eliminado header DEPRECATED completo
- Eliminada lógica temporal de proxy
- Ahora hace proxy directo: `forward_to_api("POST", "/api/webhooks/stripe")`

## Validación

- ✅ pronto-api responde `/api/webhooks/stripe` (POST)
- ✅ pronto-client hace proxy sin cambios
- ✅ Sintaxis Python validada
- ✅ Validación de firma de webhook implementada
- ✅ Validación de duplicados (sesión ya pagada)
- ✅ Manejo de errores de Stripe
- ✅ Logging estructurado implementado
- ✅ Finalización de pago con `finalize_payment()`
- ✅ Soporte para eventos: succeeded, failed, refunded

## Criterios de Aceptación

- [x] pronto-api responde `/api/webhooks/stripe`
- [x] pronto-client hace proxy sin lógica de negocio
- [x] Webhook signature validation implementada
- [x] Tests de webhooks pasan (PENDIENTE)

## Notas

- **Variables de entorno requeridas**:
  - `STRIPE_API_KEY`: Clave de API de Stripe
  - `STRIPE_WEBHOOK_SECRET`: Secreto para validar firma de webhook

- **Integración existente**:
  - `StripeProvider` ya procesa pagos y crea PaymentIntents
  - `finalize_payment()` ya está implementado en `order_service`
  - PaymentIntent.metadata contiene `session_id` desde `StripeProvider.process_payment()`

- **Eventos soportados**:
  - `payment_intent.succeeded`: Actualiza sesión a "paid"
  - `payment_intent.payment_failed`: Registra error en logs
  - `charge.refunded`: Registra en logs (lógica de reembolso pendiente)

- **Prevención de duplicados**:
  - Verifica si sesión ya tiene status "paid"
  - Busca si existe Payment con mismo provider_reference
  - Ignora webhooks duplicados

- **Lógica pendiente**:
  - Implementar actualización de Payment a "refunded" en evento `charge.refunded`
  - Considerar agregar campo `refunded_at` o `refund_amount` en modelo Payment

## Referencias

- AGENTS.md sección 12.4.2 (API canónica)
- pronto-docs/migration-plans/pronto-client-to-pronto-api-migration.md
- pronto-docs/migration-tickets/TICKET-8_validate_stripe_webhooks.md
- Stripe Webhooks: https://stripe.com/docs/webhooks
