ID: BUG-20260310-ADMIN-CALL-VISUAL-FEEDBACK-REQUEST-NOT-FIRING
FECHA: 2026-03-10
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: El caso visual de admin-call waiter no observa el request esperado al disparar `Llamar admin`
DESCRIPCION: Durante la curación de `pronto-tests`, el spec `admin-call-confirmation.spec.ts` quedó con 1/2 verde. El caso API principal pasaba, pero el caso visual/UI del botón `Llamar admin` fallaba esperando un POST que no se observaba en runtime.
PASOS_REPRODUCIR:
1. Ejecutar `npx playwright test tests/functionality/ui/playwright-tests/employees/admin-call-confirmation.spec.ts --workers=1` con el bundle employees stale.
2. Observar timeout del caso visual esperando request/response POST.
RESULTADO_ACTUAL: Resuelto.
RESULTADO_ESPERADO: Al pulsar `Llamar admin`, debe emitirse el request POST esperado y reflejarse el feedback visual.
UBICACION:
- pronto-tests/tests/functionality/ui/playwright-tests/employees/admin-call-confirmation.spec.ts
- pronto-static/src/vue/employees/shared/components/NotificationPanel.vue
- pronto-static/src/static_content/assets/js/employees/main.js
EVIDENCIA:
- Probe Playwright confirmó que con el bundle viejo no salía ningún request al click.
- Tras recompilar employees, el runtime emitió `POST /waiter/api/notifications/admin/call` con `200`.
- `admin-call-confirmation.spec.ts` pasó 2/2 tras el fix.
HIPOTESIS_CAUSA: El bundle servido de employees estaba stale y no contenía la lógica actual de `handleCallAdmin`.
ESTADO: RESUELTO
SOLUCION:
- Se recompiló `pronto-static` con `npm run build:employees` para actualizar `assets/js/employees/main.js`.
- Durante esa recompilación apareció y se corrigió una regresión separada de Pinia en `auth.ts` para que el bundle nuevo pudiera hidratar correctamente.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

