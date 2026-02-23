ID: AUDIT-20260221-001
FECHA: 2026-02-21
PROYECTO: pronto-static, pronto-client, pronto-libs
SEVERIDAD: alta
TITULO: Auditoría frontend - código vanilla e inline scripts
DESCRIPCION: |
  El frontend tiene código legacy vanilla JS mezclado con Vue, 
  inline scripts en templates, y archivos CSS potencialmente conflictivos.

HALLAZGOS:

## 1. Vanilla JS en pronto-libs (4626 líneas totales)

| Archivo | Líneas | Estado | Acción |
|---------|--------|--------|--------|
| business_config.js | 1011 | Legacy | Migrar a Vue composable |
| reports.js | 875 | Legacy | Migrar a Vue component |
| roles_management.js | 432 | Legacy | Ya existe Vue version |
| pagination.js | 431 | Legacy | Migrar a Vue component |
| employees_manager_vanilla.js | 372 | Legacy | Ya existe Vue version |
| roles_manager_vanilla.js | 330 | Legacy | Ya existe Vue version |
| keyboard-shortcuts.js | 306 | OK | Necesario para init global |
| feedback_dashboard.js | 247 | Legacy | Migrar a Vue |
| shortcuts_admin.js | 233 | Legacy | Migrar a Vue |
| notifications.js | 180 | OK | Usado globalmente |
| realtime.js | 118 | OK | Usado globalmente |
| loading.js | 91 | OK | Usado globalmente |

## 2. Inline Scripts en Templates

| Template | Scripts | Prioridad |
|----------|---------|-----------|
| base.html | 7 | Alta |
| index.html | 5 | Alta |
| index-alt.html | 4 | Media |
| checkout.html | 3 | Media |
| kiosk.html | 1 | Baja |
| feedback.html | 1 | Baja |
| debug_panel.html | 1 | Baja |
| thank_you.html | 1 | Baja |

## 3. CSS Issues

- Múltiples archivos CSS con nombres similares (qa-fixes.css, qa-error-fixes.css, qa-error-fixes-updated.css)
- Selectores potencialmente conflictivos
- Archivos CSS no referenciados

## 4. Warnings en Consola

- "El objeto Components es obsoleto"
- "KeyboardShortcutsManager no disponible" (FIXED)
- "Juego de reglas ignoradas por mal selector"

ESTADO: EN_PROGRESO

ACCIONES_COMPLETADAS:
  - [x] Consolidar archivos CSS duplicados (qa-fixes.css + qa-error-fixes-updated.css → qa-consolidated.css)
  - [x] Eliminar vanilla JS duplicado (roles_manager_vanilla.js, employees_manager_vanilla.js)
  - [x] Agregar keyboard-shortcuts.js a template
  - [x] Mover inline scripts a módulos Vue (useAppConfig, useShortcutsModal, domCleanup)
  - [x] Fix TypeScript errors en client-base.ts, thank-you.ts, config.ts
  - [x] Actualizar tipos en global.d.ts

ACCIONES_PENDIENTES:
  - [ ] Migrar business_config.js a Vue composable
  - [ ] Migrar reports.js a Vue component
  - [ ] Migrar pagination.js a Vue component
  - [ ] Eliminar inline scripts restantes de templates

COMMITS:
  - f4d3524 (pronto-libs): refactor: remove vanilla JS files with Vue equivalents
  - 382049b (pronto-client): fix: consolidate CSS includes and add keyboard-shortcuts
  - b4e6142 (pronto-static): refactor: migrate inline scripts to Vue composables

NUEVOS_ARCHIVOS:
  - src/vue/clients/composables/useAppConfig.ts
  - src/vue/clients/composables/useShortcutsModal.ts
  - src/vue/clients/utils/domCleanup.ts

VERIFICACION:
  - TypeScript: 0 errores ✅
  - Client health: OK ✅
  - Menu API: OK ✅
  - Static assets: 200 OK ✅
