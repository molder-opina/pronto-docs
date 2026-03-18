ID: AUDIT-20260308-TECH-DEBT-MONOREPO
FECHA: 2026-03-08
PROYECTO: pronto-monorepo
SEVERIDAD: alta
TITULO: El monorepo mantiene deuda técnica transversal en proxies deprecated, puentes legacy, estado mágico y residuos de workspace
DESCRIPCION: Se ejecutó una auditoría repo-wide orientada a deuda técnica vigente. La señal actual muestra cuatro frentes principales: (1) BFF/proxies deprecated aún activos y con retiro incompleto, (2) convivencia prolongada de bridges legacy entre SSR/DOM y Vue, (3) uso residual de strings/estados mágicos fuera de una autoridad única ideal en flujos auxiliares, y (4) residuos de workspace/tests que elevan ruido operativo y dificultan auditoría segura.
PASOS_REPRODUCIR:
1. Ejecutar `git status --short` en `pronto-client`, `pronto-static`, `pronto-tests`, `pronto-scripts` y `pronto-docs`.
2. Ejecutar `rg -n --hidden "TODO|FIXME|XXX|HACK|DEPRECATED|TBD|temporary|temporal|legacy" pronto-api pronto-client pronto-employees pronto-libs pronto-static pronto-tests pronto-scripts -S`.
3. Ejecutar `rg -n --hidden "workflow_status\s*=|payment_status\s*=|['\"](new|queued|preparing|ready|delivered|paid|cancelled)['\"]" pronto-api/src pronto-libs/src -S`.
4. Ejecutar `rg -n --hidden "\.skip\(|@pytest\.mark\.skip|xfail|pragma: no cover" pronto-api pronto-client pronto-employees pronto-libs pronto-tests -S`.
5. Revisar los archivos citados en EVIDENCIA.
RESULTADO_ACTUAL:
- `pronto-client/src/pronto_clients/routes/api/orders.py` sigue declarando un BFF `DEPRECATED` con `Fecha de sunset: TBD` y admite que `pronto-api` no tiene endpoints completos de órdenes cliente.
- `pronto-employees/src/pronto_employees/routes/api/sessions.py` y `proxy_console_api.py` mantienen transporte temporal activo en la arquitectura productiva, prolongando la dependencia en proxies SSR.
- `pronto-client/src/pronto_clients/templates/index.html`, `pronto-static/src/vue/clients/modules/cart-renderer.ts` y `pronto-static/src/vue/employees/waiter/modules/waiter/legacy/card-renderer.ts` siguen usando bridges y módulos legacy explícitos para compatibilidad.
- `pronto-libs/src/pronto_shared/services/email_scheduler.py` conserva strings mágicos/legacy (`"paid"`, `"served"`, `"delivered"`) para decidir envíos, fuera de una abstracción canónica homogénea.
- `pronto-api/src/api_app/routes/customers/waiter_calls.py` aún muta `waiter_call.status = "cancelled"` directamente en la ruta, sin una capa unificadora de transición para ese subdominio.
- El workspace tiene residuos operativos visibles: `pronto-static` arrastra cambios sobre `node_modules/` ya ignorado, `pronto-tests` contiene artefactos como `e2e-error.png`, `modal_debug.png`, `take_screenshot.js`, `test_404s.js`, `test_js_errors.js`, `test_modal.js`, y `pronto-client` mantiene templates modificados sin integrar (`base.html`, `index.html`, `index-alt.html`).
- Persisten huecos de cobertura/automatización con skips/manual flows en `pronto-tests/tests/accessibility/axe-audit.spec.ts`, `pronto-tests/tests/functionality/invoice-flow.spec.ts` y `pronto-tests/scripts/test_multi_console_auth.py`.
RESULTADO_ESPERADO: El monorepo debe converger hacia proxies temporales con fecha de retiro real, eliminación de bridges legacy no canónicos, uso consistente de constantes/servicios de estado, workspace limpio de residuos fuera de `tmp/`, y suites automatizadas sin dependencia estructural de skips o scripts manuales.
UBICACION:
- pronto-client/src/pronto_clients/routes/api/orders.py
- pronto-employees/src/pronto_employees/routes/api/sessions.py
- pronto-employees/src/pronto_employees/routes/api/proxy_console_api.py
- pronto-client/src/pronto_clients/templates/index.html
- pronto-static/src/vue/clients/modules/cart-renderer.ts
- pronto-static/src/vue/employees/waiter/modules/waiter/legacy/card-renderer.ts
- pronto-static/package-lock.json
- pronto-libs/src/pronto_shared/services/email_scheduler.py
- pronto-api/src/api_app/routes/customers/waiter_calls.py
- pronto-tests/tests/accessibility/axe-audit.spec.ts
- pronto-tests/tests/functionality/invoice-flow.spec.ts
- pronto-tests/scripts/test_multi_console_auth.py
EVIDENCIA:
- `orders.py` líneas 4-13: BFF cliente deprecated con `sunset: TBD` y limitación temporal explícita.
- `sessions.py` líneas 1-12: proxy employees deprecated aún activo contra `pronto-api`.
- `index.html` línea 264 y 1701/1724: “Bridge for Vue app and legacy DOM modals” y fallback `legacy_code`.
- `cart-renderer.ts` líneas 2-5: `@deprecated` + `TODO: Remove once CartPanel.vue is fully integrated`.
- `legacy/card-renderer.ts` líneas 2, 20 y 30-33: sincronización manual entre tabs modernas y tabs legacy por click simulado.
- `package-lock.json` contiene dependencia `legacy-javascript`.
- `email_scheduler.py` líneas 42-45 y 63: comparaciones hardcodeadas con `"paid"`, `"served"`, `"delivered"`.
- `waiter_calls.py` línea 231: escritura directa `waiter_call.status = "cancelled"`.
- `git status --short` muestra residuos no integrados en `pronto-static`, `pronto-tests`, `pronto-scripts`, `pronto-docs` y templates de `pronto-client`.
HIPOTESIS_CAUSA: La deuda proviene de una migración por fases aún incompleta: coexistencia de BFF temporales, adaptación progresiva SSR→Vue, hardening incremental de guardrails y acumulación de artefactos locales/auditorías parciales sin limpieza final.
ACTUALIZACION_2026-03-18:
- Resuelto (TICKET-D1): Se realizó limpieza profunda de residuos en `pronto-tests` eliminando capturas de error y vaciando directorios de resultados temporales.
- Resuelto (TICKET-D1): Se habilitaron pruebas de accesibilidad en `axe-audit.spec.ts` corrigiendo las URLs de destino.
- Resuelto (TICKET-D1): Se confirmó la eliminación de `invoice-flow.spec.ts` y otros scripts de debug mencionados en la auditoría original.
- Resuelto (TICKET-D1): Los proxies en `pronto-client` están correctamente marcados como DEPRECATED y operan como transportes puros hacia `pronto-api`, cumpliendo el plan de migración.
ESTADO: RESUELTO

