# TICKET-1: Migrar split_bills.py

**Prioridad**: ALTA
**Fase**: Fase 1 (Semana 1)
**Tiempo estimado**: 3 días
**Estado**: PLANIFICADO
**Fecha creación**: 2026-03-07

## Descripción

Migrar el módulo de división de cuentas (split bills) desde pronto-client a pronto-api.

## Archivo Origen

`pronto-client/src/pronto_clients/routes/api/split_bills.py`

## Archivo Destino

`pronto-api/src/api_app/routes/customers/split_bills.py` (crear nuevo)

## Endpoints a Migrar

1. `POST /api/sessions/<uuid:session_id>/split-bill`
   - Crear división de cuenta para una sesión
   - Body: `{number_of_people, split_type}`
   - Response: `{split_bill_id, session_id, number_of_people, split_type, status}`

2. `GET /api/split-bills/<uuid:split_id>`
   - Obtener detalles de división de cuenta
   - Response: `{split_bill, people}`

3. `POST /api/split-bills/<uuid:split_id>/assign`
   - Asignar ítem a persona en división
   - Body: `{person_id, order_item_id, quantity_portion}`
   - Response: `{assignment_id, person_id, order_item_id, quantity_portion, amount}`

4. `POST /api/split-bills/<uuid:split_id>/calculate`
   - Recalcular totales para todas las personas
   - Response: `{split_bill_id, people}`

5. `GET /api/split-bills/<uuid:split_id>/summary`
   - Obtener resumen de división
   - Response: `{split_bill, session, people}`

6. `POST /api/split-bills/<uuid:split_id>/people/<uuid:person_id>/pay`
   - Procesar pago de una persona
   - Body: `{payment_method, payment_reference}`
   - Response: `{person_id, payment_status, amount_paid, split_completed, session_closed}`

## Dependencias

- `pronto-libs/src/pronto_shared/models.py`: `SplitBill`, `SplitBillPerson`, `SplitBillAssignment`
- `pronto-libs/src/pronto_shared/services/`: `split_bill_service` (validar si existe)

## Autenticación

Usar `X-PRONTO-CUSTOMER-REF` header para autenticación de clientes.

## Pasos de Implementación

1. **Analizar código existente**
   - Leer `pronto-client/src/pronto_clients/routes/api/split_bills.py`
   - Documentar lógica de negocio actual

2. **Crear blueprint en pronto-api**
   - Crear `pronto-api/src/api_app/routes/customers/split_bills.py`
   - Registrar en `pronto-api/src/api_app/routes/customers/__init__.py`

3. **Implementar endpoints**
   - Migrar cada endpoint con logging estructurado
   - Usar `get_logger` con correlation_id
   - Validar autenticación con `X-PRONTO-CUSTOMER-REF`

4. **Validar pronto-client proxy**
   - Actualizar `pronto-client/src/pronto_clients/routes/api/split_bills.py`
   - Convertir a proxy simple sin lógica de negocio
   - Usar `_forward_to_api` helper

5. **Testing**
   - Ejecutar tests de split-bills en pronto-tests
   - Validar paridad con `pronto-api-parity-check clients`
   - Testing manual de flujo de división de cuenta

## Criterios de Aceptación

- [ ] Todos los 6 endpoints responden en pronto-api:6082
- [ ] pronto-client hace proxy sin lógica de negocio
- [ ] Tests de split-bills pasan
- [ ] API parity check: ok: true
- [ ] Logging estructurado implementado en todos los endpoints
- [ ] Error handling correcto (401, 403, 404, 500)

## Riesgos

- **Riesgo**: Regresiones en lógica de división de cuenta
  - **Mitigación**: Testing exhaustivo, rollback plan

- **Riesgo**: Auth header no propagado
  - **Mitigación**: Validar X-PRONTO-CUSTOMER-REF en todos los endpoints

## Referencias

- AGENTS.md sección 12.4.2 (API canónica)
- AGENTS.md sección 12.4.3 (BFF proxy técnico)
- `pronto-docs/migration-plans/pronto-client-to-pronto-api-migration.md`

## Notas

- La lógica de cálculo de división igual (`_calculate_equal_split`) debe migrarse intacta
- Validar compatibilidad con `payment_service.finalize_payment` pronto-libs
- Mantener compatibilidad con frontend existente (sin cambios en contrato API)
