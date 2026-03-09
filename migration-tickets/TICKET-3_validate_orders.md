# TICKET-3: Validar orders.py

**Prioridad**: MEDIA
**Fase**: Fase 2 (Semana 2)
**Tiempo estimado**: 1 día
**Estado**: PLANIFICADO
**Fecha creación**: 2026-03-07

## Descripción

Validar que pronto-api cubre todos los endpoints de órdenes que actualmente expone pronto-client.

## Archivo Origen

`pronto-client/src/pronto_clients/routes/api/orders.py`

## Archivo Destino

`pronto-api/src/api_app/routes/customers/orders.py` (ya existe)

## Endpoints a Validar

1. `GET /api/orders`
   - Obtener órdenes del cliente actual
   - Validar que pronto-api tiene este endpoint

2. `POST /api/orders`
   - Crear nueva orden
   - Validar que pronto-api tiene este endpoint

3. `POST /api/orders/<uuid:order_id>/items`
   - Agregar ítem a orden existente
   - Validar que pronto-api tiene este endpoint

4. `DELETE /api/orders/<uuid:order_id>/items/<uuid:item_id>`
   - Eliminar ítem de orden
   - Validar que pronto-api tiene este endpoint

## Pasos de Implementación

1. **Analizar código existente**
   - Leer `pronto-client/src/pronto_clients/routes/api/orders.py`
   - Listar todos los endpoints implementados

2. **Comparar con pronto-api**
   - Leer `pronto-api/src/api_app/routes/customers/orders.py`
   - Validar que cada endpoint existe en pronto-api
   - Verificar compatibilidad de request/response contracts

3. **Documentar gaps**
   - Si falta algún endpoint en pronto-api, crear TICKET-X
   - Si hay incompatibilidad de contrato, documentar y crear TICKET-Y

4. **Actualizar pronto-client proxy**
   - Convertir `pronto-client/src/pronto_clients/routes/api/orders.py`
   - Reemplazar lógica de negocio con proxy simple
   - Usar `_forward_to_api` helper

5. **Testing**
   - Ejecutar `pronto-api-parity-check clients`
   - Ejecutar tests de órdenes en pronto-tests
   - Testing manual de flujo de órdenes

## Criterios de Aceptación

- [ ] Todos los endpoints de orders.py existen en pronto-api
- [ ] pronto-client hace proxy sin lógica de negocio
- [ ] pronto-api-parity-check clients: ok: true
- [ ] Tests de órdenes pasan
- [ ] Contrato API compatible con frontend

## Riesgos

- **Riesgo**: Incompatibilidad de contrato API
  - **Mitigación**: Versioning de API, migración gradual

## Referencias

- AGENTS.md sección 12.4.2 (API canónica)
- AGENTS.md sección 12.4.3 (BFF proxy técnico)
- `pronto-docs/migration-plans/pronto-client-to-pronto-api-migration.md`

## Notas

- Si pronto-api no tiene algún endpoint, crear nuevo ticket de implementación
- Mantener compatibilidad con frontend existente
