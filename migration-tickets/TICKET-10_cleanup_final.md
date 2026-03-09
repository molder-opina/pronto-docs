# TICKET-10: Cleanup Final

**Prioridad**: ALTA
**Fase**: Fase 5 (Semana 8)
**Tiempo estimado**: 1 día
**Estado**: PLANIFICADO
**Fecha creación**: 2026-03-07

## Descripción

Eliminar archivos deprecated de pronto-client una vez completada la migración a pronto-api.

## Archivos a Eliminar

### Eliminar (migrados/validados a pronto-api):

1. ✅ `pronto-client/src/pronto_clients/routes/api/split_bills.py`
   - Migrado a `pronto-api/src/api_app/routes/customers/split_bills.py`

2. ✅ `pronto-client/src/pronto_clients/routes/api/stripe_payments.py`
   - Migrado a `pronto-api/src/api_app/routes/customers/payments.py`

3. ✅ `pronto-client/src/pronto_clients/routes/api/orders.py`
   - Validado que pronto-api cubre endpoints

4. ✅ `pronto-client/src/pronto_clients/routes/api/sessions.py`
   - Validado que pronto-api cubre endpoints

5. ✅ `pronto-client/src/pronto_clients/routes/api/notifications.py`
   - Validado que pronto-api cubre endpoints

6. ✅ `pronto-client/src/pronto_clients/routes/api/waiter_calls.py`
   - Migrado a `pronto-api/src/api_app/routes/customers/waiter_calls.py`

7. ✅ `pronto-client/src/pronto_clients/routes/api/feedback_email.py`
   - Validado que pronto-api cubre endpoints

8. ✅ `pronto-client/src/pronto_clients/routes/api/stripe_webhooks.py`
   - Validado que pronto-api cubre webhooks

### Mantener (BFF proxy/SSR-only):

1. ⚠️ `pronto-client/src/pronto_clients/routes/api/auth.py`
   - Mantener como BFF proxy a pronto-api
   - Actualizar header: "BFF Proxy to pronto-api" (eliminar DEPRECATED)

2. ⚠️ `pronto-client/src/pronto_clients/routes/api/health.py`
   - Mantener como healthcheck SSR-only
   - Actualizar header: "SSR Healthcheck - Permanente"

3. ⚠️ `pronto-client/src/pronto_clients/routes/api/shortcuts.py`
   - Mantener como UI-only (keyboard shortcuts)
   - Actualizar header: "UI-Only - Permanente"

4. ⚠️ `pronto-client/src/pronto_clients/routes/api/support.py`
   - Mantener como BFF proxy
   - Actualizar header: "BFF Proxy to pronto-api"

5. ⚠️ `pronto-client/src/pronto_clients/routes/api/tables.py`
   - Mantener como BFF cache
   - Actualizar header: "BFF Cache - Permanente"

6. ⚠️ `pronto-client/src/pronto_clients/routes/api/menu.py`
   - Mantener como BFF cache
   - Actualizar header: "BFF Cache - Permanente"

7. ⚠️ `pronto-client/src/pronto_clients/routes/api/business_info.py`
   - Mantener como BFF cache
   - Actualizar header: "BFF Cache - Permanente"

8. ⚠️ `pronto-client/src/pronto_clients/routes/api/config.py`
   - Mantener como BFF cache
   - Actualizar header: "BFF Cache - Permanente"

## Pasos de Implementación

1. **Eliminar archivos migrados**
   ```bash
   cd pronto-client/src/pronto_clients/routes/api
   rm split_bills.py
   rm stripe_payments.py
   rm orders.py
   rm sessions.py
   rm notifications.py
   rm waiter_calls.py
   rm feedback_email.py
   rm stripe_webhooks.py
   ```

2. **Actualizar __init__.py**
   - Remover imports de blueprints eliminados
   - Remover registros de blueprints eliminados

3. **Actualizar headers de archivos mantenidos**
   - Remover headers DEPRECATED de archivos BFF
   - Agregar headers descriptivos: "BFF Proxy", "BFF Cache", "SSR-Only", "UI-Only"

4. **Eliminar imports obsoletos**
   - Buscar imports de pronto-shared models/servicios ya no usados
   - Remover imports de `SplitBill`, `SplitBillPerson`, `SplitBillAssignment`
   - Remover imports de `DiningSession` (si ya no se usa directamente)
   - Remover imports de `WaiterCall`, `Notification` (si ya no se usa directamente)

5. **Validar pronto-client compila**
   ```bash
   cd pronto-client
   python -m pronto_clients
   ```
   - Validar que no hay errores de import

6. **Validar pronto-client funciona**
   - Ejecutar `./pronto-dev.sh client`
   - Validar que pronto-client levanta
   - Validar que /health responde
   - Validar que BFF proxies funcionan

7. **Ejecutar tests finales**
   ```bash
   ./pronto-scripts/bin/pronto-api-parity-check clients
   ```
   - Debe retornar ok: true

## Criterios de Aceptación

- [ ] 8 archivos eliminados de pronto-client
- [ ] pronto-client/src/pronto_clients/routes/api/__init__.py actualizado
- [ ] Headers de archivos mantenidos actualizados (sin DEPRECATED)
- [ ] Imports obsoletos eliminados
- [ ] pronto-client compila sin errores
- [ ] pronto-client levanta correctamente
- [ ] pronto-api-parity-check clients: ok: true
- [ ] pronto-client NO escribe a DB (validar con rg)

## Riesgos

- **Riesgo**: Eliminar un archivo que aún se necesita
  - **Mitigación**: Validar que pronto-api cubre TODOS los endpoints antes de eliminar

- **Riesgo**: Error de import en __init__.py
  - **Mitigación**: Validar compilación de pronto-client

## Referencias

- AGENTS.md sección 12.4.2 (API canónica)
- AGENTS.md sección 12.4.3 (BFF proxy técnico)
- AGENTS.md sección 6 (PRONTO-STATIC - Fuente Única de Estáticos)
- `pronto-docs/migration-plans/pronto-client-to-pronto-api-migration.md`

## Notas

- **IMPORTANTE**: No eliminar archivos hasta que TICKET-9 (Testing Integral) pase completamente
- Mantener copia de seguridad de archivos eliminados en caso de rollback
- Documentar cualquier edge case en archivo de notas de cleanup
