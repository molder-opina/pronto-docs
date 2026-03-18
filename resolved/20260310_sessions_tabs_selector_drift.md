ID: BUG-20260310-SESSIONS-TABS-SELECTOR-DRIFT
FECHA: 2026-03-10
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: sessions-tabs.spec.ts espera data-testid de tabs que no aparecen en runtime actual
DESCRIPCION: La prueba `sessions-tabs.spec.ts` fallaba porque `/waiter/dashboard/sessions` no aterrizaba en la vista `SessionsBoard`; la URL scoped perdía el subpath y terminaba en el dashboard raíz, por lo que los `data-testid` del board de sesiones nunca aparecían.
PASOS_REPRODUCIR:
1. Ejecutar `npx playwright test tests/functionality/ui/playwright-tests/employees/sessions-tabs.spec.ts --workers=1`.
2. Observar timeout esperando `data-testid="sessions-tab-active"`.
RESULTADO_ACTUAL: Resuelto.
RESULTADO_ESPERADO: La vista de sesiones debe abrir correctamente y exponer los test ids esperados.
UBICACION:
- pronto-tests/tests/functionality/ui/playwright-tests/employees/sessions-tabs.spec.ts
- pronto-static/src/vue/employees/shared/router/index.ts
EVIDENCIA:
- El spec `sessions-tabs.spec.ts` pasó 1/1 tras el fix.
- El probe Playwright confirmó que la URL dejó de colapsar al dashboard raíz después de recompilar el bundle employees.
HIPOTESIS_CAUSA: El problema visible de selectors era un síntoma del bug de redirect scope-aware que perdía el subpath `sessions`.
ESTADO: RESUELTO
SOLUCION:
- Se corrigió el router employees para preservar `subpath + query + hash` en aliases `/{scope}/dashboard/...`.
- Se recompiló `pronto-static` con `npm run build:employees` para actualizar los assets servidos.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

