ID: BUG-20260309-CLIENT-BASE-TRACKER-MODULARIZATION
FECHA: 2026-03-09
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: `client-base.ts` concentra lógica de tracker/historial UI que puede modularizarse sin tocar sesión ni proxies
DESCRIPCION: `pronto-static/src/vue/clients/modules/client-base.ts` seguía mezclando flujos sensibles de sesión con una capa de tracker/historial puramente frontend. La extracción se limitó al bloque visual del tracker, sin modificar requests, auth, `session_id`, transporte ni los proxies/BFF temporales.
PASOS_REPRODUCIR:
1. Abrir `pronto-static/src/vue/clients/modules/client-base.ts`.
2. Ubicar el bloque de tracker desde `TRACKER_STATUS_*` hasta `renderMiniTrackerControls(...)`.
3. Verificar que su responsabilidad es UI frontend y no requiere cambios de servicio.
RESULTADO_ACTUAL: `client-base.ts` mezclaba render/UI del tracker con lógica sensible de sesión, ampliando el blast radius de cualquier cambio.
RESULTADO_ESPERADO: La capa de tracker/historial UI debe vivir en un módulo auxiliar testeable, manteniendo intactos los flujos de sesión, auth, transporte y proxies/BFF.
UBICACION:
- pronto-static/src/vue/clients/modules/client-base.ts
- pronto-static/src/vue/clients/modules/order-tracker-helpers.ts
- pronto-static/src/vue/clients/modules/order-tracker-helpers.spec.ts
EVIDENCIA:
- `order-tracker-helpers.ts` no contiene `/api/`, `requestJSON`, `resolveCheckoutSessionId`, `getSessionId`, `setSessionId` ni `clearSessionId`.
- Validación: `PRONTO_TARGET=clients npm run test:run -- modules/order-tracker-helpers.spec.ts` OK.
- Validación: `cd pronto-static && npm run build` OK.
HIPOTESIS_CAUSA: El entrypoint del cliente absorbió progresivamente utilidades de UI del tracker por conveniencia operativa, sin extracción posterior de helpers estables.
ESTADO: RESUELTO
SOLUCION: Se creó `order-tracker-helpers.ts` para centralizar IDs/labels/status/progreso y generación de HTML del tracker/historial; `client-base.ts` quedó usando ese módulo sin tocar requests, auth ni sesiones. Se añadió `order-tracker-helpers.spec.ts` como cobertura focalizada.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09

