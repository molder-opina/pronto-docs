# Índice de Tickets de Migración

Migración de pronto-client → pronto-api según plan de retiro.

**Fecha de inicio**: 2026-03-07
**Fecha de sunset**: 2026-04-30
**Plazo**: 8 semanas

## Tickets por Fase

### Fase 1: Semana 1 (2026-03-07 → 2026-03-13)

**Objetivo**: Migrar endpoints críticos de pagos y división de cuentas

- [ ] [TICKET-1: Migrar split_bills.py](./TICKET-1_migrate_split_bills.md) - PRIORIDAD ALTA - 3 días
- [ ] [TICKET-2: Migrar stripe_payments.py](./TICKET-2_migrate_stripe_payments.md) - PRIORIDAD ALTA - 2 días

### Fase 2: Semana 2-3 (2026-03-14 → 2026-03-27)

**Objetivo**: Migrar endpoints de órdenes, sesiones y notificaciones

- [ ] [TICKET-3: Validar orders.py](./TICKET-3_validate_orders.md) - PRIORIDAD MEDIA - 1 día
- [ ] [TICKET-4: Validar sessions.py](./TICKET-4_validate_sessions.md) - PRIORIDAD MEDIA - 1 día
- [ ] [TICKET-5: Validar notifications.py](./TICKET-5_validate_notifications.md) - PRIORIDAD MEDIA - 1 día

### Fase 3: Semana 4-5 (2026-03-28 → 2026-04-10)

**Objetivo**: Migrar endpoints de feedback y webhooks

- [ ] [TICKET-6: Migrar waiter_calls.py](./TICKET-6_migrate_waiter_calls.md) - PRIORIDAD MEDIA - 2 días
- [ ] [TICKET-7: Validar feedback_email.py](./TICKET-7_validate_feedback_email.md) - PRIORIDAD MEDIA - 1 día
- [ ] [TICKET-8: Validar stripe_webhooks.py](./TICKET-8_validate_stripe_webhooks.md) - PRIORIDAD MEDIA - 0.5 días

### Fase 4: Semana 6-7 (2026-04-11 → 2026-04-24)

**Objetivo**: Testing integral y validación de paridad

- [ ] [TICKET-9: Testing Integral](./TICKET-9_testing_integral.md) - PRIORIDAD ALTA - 3 días

### Fase 5: Semana 8 (2026-04-25 → 2026-04-30)

**Objetivo**: Cleanup y eliminación de archivos deprecated

- [ ] [TICKET-10: Cleanup Final](./TICKET-10_cleanup_final.md) - PRIORIDAD ALTA - 1 día

## Resumen

| Ticket | Descripción | Prioridad | Fase | Tiempo |
|--------|-------------|-----------|-------|--------|
| TICKET-1 | Migrar split_bills.py | ALTA | Fase 1 | 3 días |
| TICKET-2 | Migrar stripe_payments.py | ALTA | Fase 1 | 2 días |
| TICKET-3 | Validar orders.py | MEDIA | Fase 2 | 1 día |
| TICKET-4 | Validar sessions.py | MEDIA | Fase 2 | 1 día |
| TICKET-5 | Validar notifications.py | MEDIA | Fase 2 | 1 día |
| TICKET-6 | Migrar waiter_calls.py | MEDIA | Fase 3 | 2 días |
| TICKET-7 | Validar feedback_email.py | MEDIA | Fase 3 | 1 día |
| TICKET-8 | Validar stripe_webhooks.py | MEDIA | Fase 3 | 0.5 días |
| TICKET-9 | Testing Integral | ALTA | Fase 4 | 3 días |
| TICKET-10 | Cleanup Final | ALTA | Fase 5 | 1 día |

**Total de tiempo estimado**: 15.5 días (~3 semanas)

## Estado Actual

- ✅ Plan de migración creado
- ✅ 10 tickets documentados
- ⏳ Fase 1: Pendiente
- ⏳ Fase 2: Pendiente
- ⏳ Fase 3: Pendiente
- ⏳ Fase 4: Pendiente
- ⏳ Fase 5: Pendiente

## Criterios de Completación

Para dar por completada la migración, se deben cumplir:

- [ ] Todos los tickets TICKET-1 a TICKET-10 están en estado COMPLETADO
- [ ] pronto-api-parity-check clients: ok: true
- [ ] pronto-client NO escribe a DB (rg retorna vacío)
- [ ] Todos los tests funcionales pasan
- [ ] 8 archivos eliminados de pronto-client (migrados/validados)
- [ ] Headers DEPRECATED eliminados de archivos BFF mantenidos
- [ ] AGENTS.md actualizado (sección 12.4.2)

## Documentación Relacionada

- [Plan de Migración Completo](../migration-plans/pronto-client-to-pronto-api-migration.md)
- [Error Resuelto: PRONTO-CLIENT-001](../resolved/20260307_pronto-client-business-logic.md)
- [Bitácora de Versión](../versioning/AI_VERSION_LOG.md)

## Notas

- Cada ticket debe completarse antes de pasar al siguiente en la misma fase
- Tickets de validación (TICKET-3, TICKET-4, TICKET-5, TICKET-7, TICKET-8) pueden convertirse en tickets de implementación si pronto-api no tiene los endpoints necesarios
- TICKET-9 (Testing Integral) debe completarse antes de TICKET-10 (Cleanup Final)
- TICKET-10 (Cleanup Final) debe completarse solo cuando TICKET-9 pase completamente
