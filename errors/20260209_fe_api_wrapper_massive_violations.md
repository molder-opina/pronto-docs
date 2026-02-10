---
ID: FE_API_WRAPPER_REMAINING_VIOLATIONS
FECHA: 20260209
PROYECTO: pronto-static
SEVERIDAD: bloqueante
TITULO: 50+ archivos adicionales en frontend empleados usan fetch directo sin wrapper
DESCRIPCION: Después de corregir 3 managers específicos (BrandingManager, EmployeeEventsManager, MenuManager), se descubrió que existen 50+ archivos adicionales en `pronto-static/src/vue/employees` que aún realizan llamadas directas a `fetch()` sin usar el wrapper obligatorio `requestJSON` de `http.ts`. Esto representa una violación masiva y sistemática del mandato de AGENTS.md sección 15.2. Los archivos afectados incluyen componentes críticos de pagos, roles, órdenes, reportes, y configuración.

PASOS_REPRODUCIR:
1. Ejecutar: `grep -r "await fetch(" pronto-static/src/vue/employees --include="*.ts" --include="*.js" --include="*.vue"`
2. Observar 50+ resultados en múltiples archivos

RESULTADO_ACTUAL: Violación masiva del wrapper obligatorio en todo el frontend de empleados. Solo 3 archivos han sido corregidos de 50+.

RESULTADO_ESPERADO: Todos los archivos deben usar `requestJSON` o `authenticatedFetch` para llamadas API.

UBICACION: pronto-static/src/vue/employees/

ARCHIVOS_AFECTADOS:

## Críticos (Seguridad y Pagos) - 3 archivos
- components/PaymentFlow.vue (4 llamadas)
  - L175: POST /api/sessions/{id}/pay
  - L227: POST /api/sessions/{id}/tip
  - L275: POST /api/sessions/{id}/resend
  - L296: GET /api/sessions/{id}/ticket

- components/RolesManager.vue (4 llamadas)
  - L300: GET /api/roles?include_inactive=true
  - L395: PUT /api/roles/{id}
  - L408: POST /api/roles/{id}/permissions/bulk
  - L423: POST /api/roles

- modules/role-management.ts (8 llamadas)
  - L134: GET /api/employees/search
  - L194: GET /api/employees/{id}
  - L254: PUT /api/employees/{id}
  - L307: POST /api/roles/employees/{id}/revoke
  - L328: GET /api/permissions/system
  - L438: POST/PUT endpoints dinámicos
  - L461: POST /api/permissions/roles/{key}/reset

## Alta Prioridad (Operaciones Core) - 8 archivos
- modules/customers-manager.ts (5 llamadas)
  - L160: GET /api/customers/stats
  - L185: GET /api/customers/search
  - L255: GET /api/customers/{id}
  - L327: GET /api/customers/{id}/orders
  - L379: GET /api/customers/{id}/coupons

- modules/tables-manager.ts (5 llamadas)
  - L401: GET /api/areas
  - L552: GET /api/tables
  - L817: PUT /api/tables/{id}
  - L994: POST/PUT dinámico
  - L1022: DELETE /api/tables/{id}

- modules/orders-board.ts (2+ llamadas)
  - L441: GET /api/orders?include_closed=true&include_delivered=true
  - L627: GET /api/orders?include_closed=true&include_delivered=true

- modules/kitchen-board.ts (3+ llamadas)
  - L869: GET /api/orders?status=paid&status=cancelled
  - L1027: GET /api/orders?status=queued
  - L1284: GET /api/orders?status=queued

- modules/anonymous-sessions-manager.ts (3 llamadas)
  - L84: POST /api/sessions/anonymous
  - L216: PUT /api/sessions/{id}/anonymous
  - L252: POST /api/sessions/{id}/regenerate-anonymous

- modules/areas-manager.ts (2 llamadas)
  - L265: GET /api/areas
  - L383: POST/PUT dinámico

- components/BusinessConfig.vue (2 llamadas)
  - L247: GET /api/business-info
  - L311: PUT /api/business-info

- components/ReportsManager.vue (1 llamada)
  - L320: GET /api/reports

## Media Prioridad (Reportes y Configuración) - 4 archivos
- modules/reports-manager.ts (4 llamadas)
  - L155: GET endpoint dinámico
  - L232: GET endpoint dinámico
  - L301: GET /api/reports/peak-hours
  - L359: GET /api/reports/waiter-tips

- modules/config-manager.ts (2 llamadas)
  - L73: GET /api/config
  - L197: PUT /api/config/{id}

- modules/recommendations-manager.ts (3 llamadas)
  - L204: GET /api/menu-items/popular
  - L601: POST /api/menu-items/{id}/recommendations
  - L638: DELETE /api/menu-items/{id}/recommendations

- modules/promotions-manager.ts (2 llamadas)
  - L151: GET /api/promotions
  - L172: GET /api/discount-codes

## Baja Prioridad (Features Secundarios) - 1+ archivos
- modules/waiter/sounds.ts (1 llamada)
  - L13: GET /api/settings/public/waiter_notification_sound

- Y 20+ archivos adicionales no catalogados...

IMPACTO:
- **Seguridad**: Llamadas a endpoints de pagos y roles sin CSRF protection automático
- **Autenticación**: Manejo inconsistente de 401/403 en diferentes módulos
- **Mantenibilidad**: Código duplicado para manejo de errores y headers
- **Cumplimiento**: Violación masiva de AGENTS.md

PLAN_REMEDIACION:

## Fase 1: Críticos (Prioridad Inmediata) - 3-4 horas
1. PaymentFlow.vue - Refactorizar 4 llamadas
2. RolesManager.vue - Refactorizar 4 llamadas
3. role-management.ts - Refactorizar 8 llamadas

## Fase 2: Alta Prioridad - 6-8 horas
4. customers-manager.ts - 5 llamadas
5. tables-manager.ts - 5 llamadas
6. orders-board.ts - 2+ llamadas
7. kitchen-board.ts - 3+ llamadas
8. anonymous-sessions-manager.ts - 3 llamadas
9. areas-manager.ts - 2 llamadas
10. BusinessConfig.vue - 2 llamadas
11. ReportsManager.vue - 1 llamada

## Fase 3: Media Prioridad - 4-6 horas
12. reports-manager.ts - 4 llamadas
13. config-manager.ts - 2 llamadas
14. recommendations-manager.ts - 3 llamadas
15. promotions-manager.ts - 2 llamadas

## Fase 4: Baja Prioridad - 2-4 horas
16. waiter/sounds.ts - 1 llamada
17. Resto de archivos no catalogados

## Fase 5: Prevención
18. Agregar ESLint rule para prevenir nuevas violaciones
19. Agregar pre-commit hook para validar uso de wrapper
20. Documentar patrón en guía de desarrollo

ESTIMACION_TOTAL: 15-25 horas de trabajo

ESTADO: ABIERTO
PRIORIDAD_SIGUIENTE: Fase 1 (Críticos)
---
