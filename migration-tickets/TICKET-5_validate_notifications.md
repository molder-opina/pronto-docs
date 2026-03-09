# TICKET-5: Validar notifications.py

**Prioridad**: MEDIA
**Fase**: Fase 2 (Semana 2)
**Tiempo estimado**: 1 día
**Estado**: PLANIFICADO
**Fecha creación**: 2026-03-07

## Descripción

Validar que pronto-api cubre todos los endpoints de notificaciones para clientes que actualmente expone pronto-client.

## Archivo Origen

`pronto-client/src/pronto_clients/routes/api/notifications.py`

## Archivo Destino

`pronto-api/src/api_app/routes/notifications.py` (ya existe)

## Endpoints a Validar

1. `GET /api/notifications`
   - Obtener notificaciones no leídas del cliente actual
   - Validar que pronto-api tiene este endpoint con scope "customer"

2. `POST /api/notifications/<int:notification>/read`
   - Marcar notificación como leída
   - Validar que pronto-api tiene este endpoint con ownership check

## Pasos de Implementación

1. **Analizar código existente**
   - Leer `pronto-client/src/pronto_clients/routes/api/notifications.py`
   - Listar todos los endpoints implementados

2. **Comparar con pronto-api**
   - Leer `pronto-api/src/api_app/routes/notifications.py`
   - Validar que cada endpoint existe en pronto-api
   - Verificar compatibilidad de request/response contracts

3. **Documentar gaps**
   - Si falta algún endpoint para clientes en pronto-api, crear TICKET-X
   - Si hay incompatibilidad de contrato, documentar y crear TICKET-Y

4. **Actualizar pronto-client proxy**
   - Convertir `pronto-client/src/pronto_clients/routes/api/notifications.py`
   - Reemplazar lógica de negocio con proxy simple
   - Usar `_forward_to_api` helper

5. **Testing**
   - Ejecutar `pronto-api-parity-check clients`
   - Ejecutar tests de notificaciones en pronto-tests
   - Testing manual de flujo de notificaciones

## Criterios de Aceptación

- [ ] Todos los endpoints de notifications.py existen en pronto-api
- [ ] pronto-client hace proxy sin lógica de negocio
- [ ] pronto-api-parity-check clients: ok: true
- [ ] Tests de notificaciones pasan
- [ ] Ownership check de notificaciones funciona

## Riesgos

- **Riesgo**: Incompatibilidad de contrato API
  - **Mitigación**: Versioning de API, migración gradual

## Referencias

- AGENTS.md sección 12.4.2 (API canónica)
- AGENTS.md sección 12.4.3 (BFF proxy técnico)
- `pronto-docs/migration-plans/pronto-client-to-pronto-api-migration.md`

## Notas

- Validar que auth con X-PRONTO-CUSTOMER-REF funciona
- Ownership check debe validar recipient_id
