# TICKET-6: Migrar waiter_calls.py

**Prioridad**: MEDIA
**Fase**: Fase 3 (Semana 4)
**Tiempo estimado**: 2 días
**Estado**: PLANIFICADO
**Fecha creación**: 2026-03-07

## Descripción

Migrar el módulo de llamadas a mesero desde pronto-client a pronto-api.

## Archivo Origen

`pronto-client/src/pronto_clients/routes/api/waiter_calls.py`

## Archivo Destino

`pronto-api/src/api_app/routes/customers/waiter_calls.py` (crear nuevo)

## Endpoints a Migrar

1. `POST /api/call-waiter`
   - Llamar mesero a la mesa
   - Body: `{reason, notes}`
   - Response: `{call_id, status, message}`

2. `GET /api/call-waiter/status/<int:call>`
   - Obtener estado de llamada a mesero
   - Response: `{call_id, status, created_at, resolved_at}`

3. `POST /api/call-waiter/cancel`
   - Cancelar llamada a mesero
   - Body: `{call_id}`
   - Response: `{success, message}`

## Dependencias

- `pronto-libs/src/pronto_shared/models.py`: `WaiterCall`, `Table`, `Notification`
- `pronto-libs/src/pronto_shared/supabase/realtime.py`: `emit_waiter_call`

## Autenticación

Usar `X-PRONTO-CUSTOMER-REF` header para autenticación de clientes.

## Pasos de Implementación

1. **Analizar código existente**
   - Leer `pronto-client/src/pronto_clients/routes/api/waiter_calls.py`
   - Documentar lógica de llamadas a mesero

2. **Crear blueprint en pronto-api**
   - Crear `pronto-api/src/api_app/routes/customers/waiter_calls.py`
   - Registrar en `pronto-api/src/api_app/routes/customers/__init__.py`

3. **Implementar endpoints**
   - Migrar cada endpoint con logging estructurado
   - Usar `get_logger` con correlation_id
   - Validar autenticación con `X-PRONTO-CUSTOMER-REF`

4. **Validar pronto-client proxy**
   - Actualizar `pronto-client/src/pronto_clients/routes/api/waiter_calls.py`
   - Convertir a proxy simple sin lógica de negocio
   - Usar `_forward_to_api` helper

5. **Testing**
   - Ejecutar tests de waiter_calls en pronto-tests
   - Validar paridad con `pronto-api-parity-check clients`
   - Testing manual de flujo de llamadas a mesero

## Criterios de Aceptación

- [ ] Todos los 3 endpoints responden en pronto-api:6082
- [ ] pronto-client hace proxy sin lógica de negocio
- [ ] Tests de waiter_calls pasan
- [ ] API parity check: ok: true
- [ ] Logging estructurado implementado en todos los endpoints
- [ ] Realtime notification `emit_waiter_call` funciona

## Riesgos

- **Riesgo**: Regresiones en flujo de llamadas a mesero
  - **Mitigación**: Testing exhaustivo, rollback plan

- **Riesgo**: Realtime notification no enviada
  - **Mitigación**: Validar integración con Supabase realtime

## Referencias

- AGENTS.md sección 12.4.2 (API canónica)
- AGENTS.md sección 12.4.3 (BFF proxy técnico)
- `pronto-docs/migration-plans/pronto-client-to-pronto-api-migration.md`

## Notas

- Validar que `emit_waiter_call` está en pronto-libs
- Mantener compatibilidad con frontend existente
- Probar integración realtime con employees
