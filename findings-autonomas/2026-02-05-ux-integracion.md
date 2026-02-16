# Findings Autonomas - 2026-02-05 (UX + Integración Cross-Module)

Alcance: pronto-client, pronto-employees, pronto-static, pronto-api.

Reglas: sin cambios de arquitectura/negocio/DB/Redis; solo auditoría + tracking en `pronto-pronto-pronto-docs/errors/`.

## Resumen

- Roles canónicos: OK (waiter, chef, cashier, admin, system)
- Estados/flows: OK en catálogo (OrderStatus/SessionStatus en `pronto_shared.constants`), pero hay drift de endpoints para avanzar órdenes/sesiones
- Contratos UI↔backend: múltiples llamadas `/api/*` sin backend en el servicio que las atiende
- Estáticos: nginx de pronto-static sirve `/assets/*` (no `/static/*`); hay referencias `/static/*` en Vue
- Accesibilidad mínima: inputs sin label/aria-label en consola `/system`

## Hallazgos (por severidad)

### BLOQUEANTE

1) Empleados: login pages llaman `/api/stats/public` sin endpoint

- Archivo: `pronto-employees/src/pronto_employees/templates/login.html:585-598`
- Evidencia: `fetch('/api/stats/public')`
- Impacto: request 404 en login; UX rota y ruido en consola
- Tracking: `pronto-pronto-pronto-docs/errors/20260205_employees_stats_public_missing.md` (ERR-20260205-STATS-PUBLIC)

2) Empleados: UI avanza órdenes (accept/kitchen/deliver) vía `/api/orders/*` sin endpoints

- Archivo: `pronto-static/src/vue/employees/modules/kitchen-board.ts:77-86`
- Evidencia: endpoints `/api/orders/${id}/kitchen/start`, `/api/orders/${id}/kitchen/ready`, `/api/orders/${id}/deliver`
- Impacto: botones/acciones críticas de cocina/mesero no funcionan (404). Nota: `core/http.ts` reescribe `/api/*` -> `/<scope>/api/*` en requests autenticadas.
- Tracking: `pronto-pronto-pronto-docs/errors/20260205_employees_order_actions_missing.md` (ERR-20260205-EMP-ORDER-ACTIONS)

3) Empleados: pagos/tickets consumen `/api/sessions/*` sin endpoints (más allá de `/api/sessions/all`)

- Archivo: `pronto-static/src/vue/employees/modules/payments-flow.ts:154-206`
- Evidencia: `/api/sessions/${id}`, `/api/sessions/${id}/ticket`
- Impacto: checkout/tickets/tip/pago fallan (404). Nota: `core/http.ts` reescribe `/api/*` -> `/<scope>/api/*` en requests autenticadas.
- Tracking: `pronto-pronto-pronto-docs/errors/20260205_employees_sessions_payments_missing.md` (ERR-20260205-EMP-SESSIONS-PAYMENTS)
- Relacionado: `pronto-pronto-pronto-docs/errors/20260204_employees_sessions_all_missing.md` (ERR-20260204-SESSIONS-ALL)

4) Cliente: módulo mesas/áreas llama `/api/areas` y `/api/tables` sin endpoints en pronto-client

- Archivo: `pronto-static/src/vue/clients/modules/tables-manager.ts:392-407`, `:544-559`
- Evidencia: `fetch(\"/api/areas\")`, `fetch(\"/api/tables\")`
- Impacto: administración/visualización de mesas/áreas falla (404) salvo que exista endpoint externo no documentado
- Tracking: `pronto-pronto-pronto-docs/errors/20260205_client_tables_areas_endpoints_missing.md` (ERR-20260205-CLIENT-TABLES-AREAS)

### ALTA

5) Estáticos: Vue usa rutas `/static/*` pero el contenedor sirve `/assets/*`

- Evidencia: nginx `location /assets/` solamente
- Impacto: audio/favicon/placeholder 404 fuera de dev-proxy
- Tracking existente: `pronto-pronto-pronto-docs/errors/20260203_static_paths_pronto_static.md` (ERR-20260203-STATIC-PATHS)

6) Cliente: descarga PDF usa `/api/sessions/<id>/ticket.pdf` sin endpoint

- Archivo: `pronto-static/src/vue/clients/modules/active-orders.ts:1825-1849`
- Evidencia: `fetch(\`/api/sessions/${sessionId}/ticket.pdf\`)`
- Impacto: descarga de ticket PDF falla (404)
- Tracking: `pronto-pronto-pronto-docs/errors/20260205_client_ticket_pdf_missing.md` (ERR-20260205-CLIENT-TICKET-PDF)

### MEDIA

7) Cliente debug-panel: llama `/api/promotions` pero pronto-client expone `/api/promotions/active`

- Archivo: `pronto-client/src/pronto_clients/templates/debug_panel.html:809-819`
- Evidencia: `fetch('/api/promotions')`
- Impacto: debug/QA misleading; false negatives en validaciones manuales
- Tracking: `pronto-pronto-pronto-docs/errors/20260205_client_promotions_endpoint_mismatch.md` (ERR-20260205-CLIENT-PROMOTIONS-MISMATCH)

8) Cliente: fallback hardcodeado a `http://localhost:9088` en producción si falla `static_host_url`

- Archivo: `pronto-static/src/vue/clients/modules/client-profile.ts:386-390`
- Evidencia: `window.APP_CONFIG?.static_host_url || 'http://localhost:9088'`
- Impacto: en prod puede romper avatar/cargar assets apuntando a localhost
- Tracking: `pronto-pronto-pronto-docs/errors/20260205_client_static_host_hardcode.md` (ERR-20260205-CLIENT-STATIC-HARDCODE)

### BAJA

9) Empleados: logo usa `.png` pero assets base (demo) usa `.jpg`

- Archivo: `pronto-employees/src/pronto_employees/templates/base.html:1456-1457`
- Evidencia: `.../branding/logo.png` mientras `assets/**/branding/logo.jpg`
- Impacto: fallback se activa (degrada UX, no bloquea)
- Tracking: `pronto-pronto-pronto-docs/errors/20260205_employees_logo_extension_mismatch.md` (ERR-20260205-EMP-LOGO-EXT)

10) Accesibilidad: inputs sin label/aria-label en `/system/config/order-status-labels`

- Archivo: `pronto-employees/src/pronto_employees/templates/system_order_status_labels.html:23-44`
- Evidencia: `<input type="text" ...>` sin `<label for>` y sin `aria-label`
- Impacto: baja accesibilidad para lectores de pantalla
- Tracking: `pronto-pronto-pronto-docs/errors/20260205_a11y_system_order_status_labels_inputs_unlabeled.md` (ERR-20260205-A11Y-SYS-STATUS-LABELS)

## Nota de cobertura

Existen más endpoints `/api/*` referenciados en `pronto-static/src/vue/employees/**` (roles/permisos, áreas/mesas, catálogo, reportes, config, branding IA) que no aparecen implementados en `pronto-employees` ni `pronto-api` según escaneo de rutas. Esta auditoría prioriza flujos críticos y crea tracking por feature.
