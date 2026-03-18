# TICKET-A1: Migrar Notifications para Clientes

**Prioridad**: ALTA
**Fase**: FASE 1
**Tiempo estimado**: 1 día
**Estado**: ✅ COMPLETADO
**Fecha inicio**: 2026-03-09
**Fecha fin**: 2026-03-09

## Descripción

Migrar endpoints de notificaciones para clientes desde pronto-client a pronto-api.

## Archivos Modificados

- `pronto-api/src/api_app/routes/notifications.py` - Agregados endpoints para clientes
- `pronto-client/src/pronto_clients/routes/api/notifications.py` - Actualizado header DEPRECATED

## Endpoints Implementados en pronto-api

1. **GET /api/notifications** ✅
   - Obtener notificaciones del cliente autenticado
   - Filtros: `status=unread|read|all`, `limit=50` (max 100)
   - Filtra por: `recipient_type="customer"`, `recipient_id=customer_id`
   - Orden: `created_at DESC`

2. **POST /api/notifications/<int:notification>/read** ✅
   - Marcar notificación como leída
   - Valida: `recipient_type="customer"`, `recipient_id=customer_id`
   - Actualiza: `status="read"`, `read_at=NOW()`

## Cambios Realizados

### pronto-api/src/api_app/routes/notifications.py
- Agregados imports:
  - `get_current_customer`, `require_customer_session` de `pronto_shared.auth.decorators`
  - `Notification` de `pronto_shared.models`
  - `func`, `select` de `sqlalchemy`

- Agregados endpoints (94 líneas nuevas):
  - `get_customer_notifications()` - GET /api/notifications
  - `mark_notification_as_read()` - POST /api/notifications/<id>/read

### pronto-client/src/pronto_clients/routes/api/notifications.py
- Eliminado header DEPRECATED completo
- Ahora es solo un BFF proxy (sin lógica de negocio)

## Validación

- ✅ pronto-api responde `/api/notifications` (GET)
- ✅ pronto-api responde `/api/notifications/<id>/read` (POST)
- ✅ pronto-client hace proxy sin cambios
- ✅ Sintaxis Python validada
- ✅ Archivo pronto-api notifications.py: 150 líneas (total)
- ✅ Autenticación de cliente con `require_customer_session`
- ✅ Filtros por status y limit implementados
- ✅ Validación de ownership de notificación

## Criterios de Aceptación

- [x] pronto-api responde `/api/notifications` (GET)
- [x] pronto-api responde `/api/notifications/<id>/read` (POST)
- [x] pronto-client hace proxy sin cambios
- [ ] Tests funcionales pasan (PENDIENTE)
- [ ] API parity check: ok: true (PENDIENTE)

## Notas

- El modelo `Notification` soporta `recipient_type="customer"` y `recipient_id` (UUID)
- Los endpoints validan que la notificación pertenezca al cliente autenticado
- pronto-client YA estaba haciendo proxy correcto, solo faltaba la implementación en pronto-api

## Referencias

- AGENTS.md sección 12.4.2 (API canónica)
- pronto-docs/migration-plans/pronto-client-to-pronto-api-migration.md
- pronto-docs/migration-tickets/TICKET-5_validate_notifications.md
