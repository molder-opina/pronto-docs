# TICKET-8: Validar stripe_webhooks.py

**Prioridad**: MEDIA
**Fase**: Fase 3 (Semana 4)
**Tiempo estimado**: 0.5 días
**Estado**: PLANIFICADO
**Fecha creación**: 2026-03-07

## Descripción

Validar que pronto-api maneja correctamente los webhooks de Stripe que actualmente expone pronto-client.

## Archivo Origen

`pronto-client/src/pronto_clients/routes/api/stripe_webhooks.py`

## Archivo Destino

`pronto-api/src/api_app/routes/webhooks.py` (ya existe)

## Endpoints a Validar

1. `POST /api/stripe/webhooks`
   - Webhook de Stripe
   - Validar que pronto-api tiene este endpoint

## Pasos de Implementación

1. **Analizar código existente**
   - Leer `pronto-client/src/pronto_clients/routes/api/stripe_webhooks.py`
   - Listar todos los eventos Stripe manejados

2. **Comparar con pronto-api**
   - Leer `pronto-api/src/api_app/routes/webhooks.py`
   - Validar que pronto-api maneja los mismos eventos Stripe
   - Verificar compatibilidad de headers/secret

3. **Documentar gaps**
   - Si falta algún evento Stripe en pronto-api, crear TICKET-X
   - Si hay incompatibilidad de secret/hmac, documentar y crear TICKET-Y

4. **Actualizar pronto-client proxy**
   - Convertir `pronto-client/src/pronto_clients/routes/api/stripe_webhooks.py`
   - Reemplazar lógica de negocio con proxy simple
   - Usar `_forward_to_api` helper

5. **Testing**
   - Ejecutar `pronto-api-parity-check clients`
   - Validar firma de webhook Stripe
   - Testing manual con eventos Stripe de prueba

## Criterios de Aceptación

- [ ] pronto-api maneja todos los eventos Stripe que pronto-client manejaba
- [ ] pronto-client hace proxy sin lógica de negocio
- [ ] pronto-api-parity-check clients: ok: true
- [ ] Validación de firma HMAC funciona
- [ ] Contrato API compatible con Stripe

## Riesgos

- **Riesgo**: Incompatibilidad de firma HMAC
  - **Mitigación**: Validar secret configuration, testing con eventos de prueba

## Referencias

- AGENTS.md sección 12.4.2 (API canónica)
- AGENTS.md sección 12.4.3 (BFF proxy técnico)
- `pronto-docs/migration-plans/pronto-client-to-pronto-api-migration.md`

## Notas

- Validar que STRIPE_WEBHOOK_SECRET está configurado en pronto-api
- Validar que pronto-api recibe headers de firma correctos
