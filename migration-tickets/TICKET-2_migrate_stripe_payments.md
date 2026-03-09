# TICKET-2: Migrar stripe_payments.py

**Prioridad**: ALTA
**Fase**: Fase 1 (Semana 1)
**Tiempo estimado**: 2 días
**Estado**: PLANIFICADO
**Fecha creación**: 2026-03-07

## Descripción

Migrar el módulo de pagos con Stripe/Clip desde pronto-client a pronto-api.

## Archivo Origen

`pronto-client/src/pronto_clients/routes/api/stripe_payments.py`

## Archivo Destino

`pronto-api/src/api_app/routes/customers/payments.py` (extender existente)

## Endpoints a Migrar

1. `POST /api/sessions/<uuid:session_id>/pay/stripe`
   - Procesar pago con Stripe
   - Body: `{tip_amount, tip_percentage}`
   - Response: `{client_secret, payment_intent_id, total_amount, subtotal, tax_amount, tip_amount}`

2. `POST /api/sessions/<uuid:session_id>/pay/clip`
   - Solicitar pago con terminal Clip
   - Body: `{tip_amount, tip_percentage}`
   - Response: `{success, message, waiter_call_id, total_amount, subtotal, tax_amount, tip_amount}`

## Dependencias

- `pronto-libs/src/pronto_shared/models.py`: `DiningSession`, `WaiterCall`, `Notification`
- `pronto-libs/src/pronto_shared/services/payment_providers.py`: `process_payment`, `PaymentError`
- `pronto-libs/src/pronto_shared/supabase/realtime.py`: `emit_waiter_call`

## Autenticación

Usar `X-PRONTO-CUSTOMER-REF` header para autenticación de clientes.

## Pasos de Implementación

1. **Analizar código existente**
   - Leer `pronto-client/src/pronto_clients/routes/api/stripe_payments.py`
   - Documentar integración con Stripe/Clip

2. **Extender payments.py en pronto-api**
   - Agregar endpoints POST para `/pay/stripe` y `/pay/clip`
   - Validar que `payments_bp` ya existe en pronto-api

3. **Implementar endpoints**
   - Migrar lógica de pago Stripe
   - Migrar lógica de solicitud de pago Clip
   - Implementar logging estructurado con correlation_id

4. **Validar pronto-client proxy**
   - Actualizar `pronto-client/src/pronto_clients/routes/api/stripe_payments.py`
   - Convertir a proxy simple sin lógica de negocio

5. **Testing**
   - Ejecutar tests de pagos en pronto-tests
   - Validar integración con Stripe/Clip
   - Testing manual de flujo de pago

## Criterios de Aceptación

- [ ] Ambos endpoints responden en pronto-api:6082
- [ ] pronto-client hace proxy sin lógica de negocio
- [ ] Tests de payments pasan
- [ ] API parity check: ok: true
- [ ] Stripe integration funciona correctamente
- [ ] Clip payment request genera WaiterCall y Notification

## Riesgos

- **Riesgo**: Regresiones en flujo de pago
  - **Mitigación**: Testing en sandbox Stripe, rollback plan

- **Riesgo**: Timeout en integración Stripe
  - **Mitigación**: Rate limiting, error handling robusto

## Referencias

- AGENTS.md sección 12.4.2 (API canónica)
- AGENTS.md sección 12.4.3 (BFF proxy técnico)
- `pronto-docs/migration-plans/pronto-client-to-pronto-api-migration.md`

## Notas

- Validar que `payment_providers.process_payment` está en pronto-libs
- Mantener compatibilidad con frontend existente
- Probar en sandbox antes de producción
