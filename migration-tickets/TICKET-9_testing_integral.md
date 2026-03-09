# TICKET-9: Testing Integral

**Prioridad**: ALTA
**Fase**: Fase 4 (Semana 6-7)
**Tiempo estimado**: 3 días
**Estado**: PLANIFICADO
**Fecha creación**: 2026-03-07

## Descripción

Ejecutar testing integral de la migración de pronto-client a pronto-api para validar que todo funciona correctamente.

## Pasos de Implementación

### Día 1: API Parity y Guards

1. **Ejecutar API Parity Check**
   ```bash
   ./pronto-scripts/bin/pronto-api-parity-check clients
   ```
   - Validar que retorna `ok: true`
   - Validar `missing_unknown_method`: vacío
   - Validar `warnings`: vacío

2. **Ejecutar Guards de Arquitectura**
   - Verificar que pronto-client NO escribe a DB:
   ```bash
   rg -n "db_session\.(add|commit)" pronto-client/src/pronto_clients/routes/api/
   ```
   - Debe retornar vacío

3. **Verificar Headers DEPRECATED**
   - Validar que todos los archivos en pronto-client tienen header DEPRECATED
   - Validar que pronto-api NO tiene headers DEPRECATED

### Día 2: Tests Funcionales

1. **Ejecutar Tests de Clientes**
   ```bash
   cd pronto-tests
   npx playwright test clientes
   ```
   - Validar que todos los tests pasan
   - Validar que no hay tests skipped por timeout

2. **Ejecutar Tests Específicos**
   ```bash
   npx playwright test split-bills.spec.ts
   npx playwright test payments.spec.ts
   npx playwright test orders.spec.ts
   ```
   - Validar que todos pasan

3. **Validar Tests de Integración**
   - Validar que pronto-tests incluye tests de pronto-api
   - Validar que tests cubren endpoints migrados

### Día 3: Testing Manual

1. **Flujo Completo de Cliente**
   - Login/registro de cliente
   - Abrir sesión de mesa
   - Navegar menú y agregar items al carrito
   - Confirmar orden
   - Probar split bills (dividir cuenta)
   - Probar pagos (Stripe/Clip)
   - Probar feedback post-pago
   - Validar que pronto-client NO escribe a DB

2. **Validar Headers de Request**
   - Usar DevTools para validar que X-PRONTO-CUSTOMER-REF se envía
   - Validar que X-CSRFToken se envía en mutaciones
   - Validar que X-Correlation-ID se propaga

3. **Validar Logs**
   - Validar que pronto-api tiene logs estructurados
   - Validar que pronto-client tiene logs de proxy (sin business logic)
   - Validar que pronto-logs/ contiene logs de ambos servicios

## Criterios de Aceptación

- [ ] pronto-api-parity-check clients: ok: true
- [ ] pronto-client NO escribe a DB (rg retorna vacío)
- [ ] Todos los tests funcionales de clientes pasan
- [ ] split-bills tests pasan
- [ ] payments tests pasan
- [ ] orders tests pasan
- [ ] Flujo completo de cliente funciona sin errores
- [ ] X-PRONTO-CUSTOMER-REF se envía en todos los requests
- [ ] X-CSRFToken se envía en todas las mutaciones
- [ ] X-Correlation-ID se propiga en todos los endpoints
- [ ] Logs estructurados en pronto-api y pronto-client
- [ ] pronto-logs/ contiene logs de ambos servicios

## Riesgos

- **Riesgo**: Tests fallan por incompatibilidad de contrato
  - **Mitigación**: Documentar incompatibilidades, crear tickets de fix

- **Riesgo**: Flujo manual falla por edge cases
  - **Mitigación**: Testing exploratorio, agregar tests para edge cases

## Referencias

- AGENTS.md sección 12.4.2 (API canónica)
- AGENTS.md sección 12.4.3 (BFF proxy técnico)
- AGENTS.md sección 0.6 (Trazabilidad y Observabilidad)
- `pronto-docs/migration-plans/pronto-client-to-pronto-api-migration.md`

## Notas

- Documentar todos los hallazgos en `pronto-docs/testing/migration-test-results.md`
- Si hay tests que fallan, crear tickets de fix
- Validar que pronto-tests está actualizado con los nuevos endpoints
