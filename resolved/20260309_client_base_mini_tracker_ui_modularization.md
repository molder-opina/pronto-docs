ID: BUG-20260309-CLIENT-BASE-MINI-TRACKER-UI-MODULARIZATION
FECHA: 2026-03-09
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: `client-base.ts` mantiene la UI del mini-tracker embebida en el entrypoint cliente
DESCRIPCION: `client-base.ts` todavía contenía la lógica DOM/UI del mini-tracker: visibilidad, binding de abrir/cerrar, select de órdenes, estado visual/progreso y acciones visuales de cancelar/cobrar. Se extrajo a un helper dedicado sin tocar sesión, auth, requests, transporte ni proxies/BFF temporales. La persistencia del estado minimizado y el estado local del tracker permanecieron en `client-base.ts`.
PASOS_REPRODUCIR:
1. Abrir `pronto-static/src/vue/clients/modules/client-base.ts`.
2. Ubicar `renderMiniTrackerVisibility`, `bindMiniTrackerControls`, `getSelectedMiniTrackerOrderId` y `renderMiniTrackerControls`.
3. Verificar que la capa extraída es UI y que la persistencia `localStorage` del estado minimizado sigue dentro del entrypoint.
RESULTADO_ACTUAL: El entrypoint cliente mezclaba UI del mini-tracker con estado local/persistencia visual.
RESULTADO_ESPERADO: La UI del mini-tracker debe vivir en un helper aislado y testeable, manteniendo el estado local y la persistencia visual dentro de `client-base.ts`.
UBICACION:
- pronto-static/src/vue/clients/modules/client-base.ts
- pronto-static/src/vue/clients/modules/mini-tracker-ui.ts
- pronto-static/src/vue/clients/modules/mini-tracker-ui.spec.ts
EVIDENCIA:
- `mini-tracker-ui.ts` no contiene `/api/`, `requestJSON`, auth, `session_id`, `localStorage`, `sessionStorage` ni `CartPersistence`.
- Validación: `PRONTO_TARGET=clients npm run test:run -- modules/mini-tracker-ui.spec.ts` OK.
- Validación: `cd pronto-static && npm run build` OK.
HIPOTESIS_CAUSA: La UI del mini-tracker se dejó dentro del entrypoint por cercanía con el polling/tracker antes de separar responsabilidades visuales del estado local.
ESTADO: RESUELTO
SOLUCION: Se creó `mini-tracker-ui.ts` para encapsular visibilidad, binding de controles, binding del select, lectura del order id seleccionado y render visual del mini-tracker. `client-base.ts` conserva `miniTrackerMinimized`, persistencia `localStorage`, polling y estado. Se añadió `mini-tracker-ui.spec.ts` como cobertura focalizada.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09

