ID: STA-20260307-006
FECHA: 2026-03-07
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: frontend employees depende de endpoint publico /api/public/stats
DESCRIPCION:
  Los componentes de login de employees dependían de `/api/public/stats` para mostrar métricas iniciales,
  manteniendo acoplamiento con una superficie API anónima ya rechazada por guardrails.
PASOS_REPRODUCIR:
  1. Abrir `LoginShell.vue` y `StaffLogin.vue`.
  2. Verificar consumo de `/api/public/stats`.
RESULTADO_ACTUAL:
  El login employees ya no depende de `/api/public/stats` para bootstrap UI.
RESULTADO_ESPERADO:
  El login debe renderizar sin necesidad de endpoints API anónimos fuera de excepciones permitidas.
UBICACION:
  - `pronto-static/src/vue/employees/shared/components/LoginShell.vue`
  - `pronto-static/src/vue/employees/shared/views/StaffLogin.vue`
  - `pronto-static/src/vue/employees/shared/store/config.ts`
  - `pronto-employees/src/pronto_employees/templates/index.html`
ESTADO: RESUELTO
SOLUCION:
  Se eliminó el consumo de `/api/public/stats` en `LoginShell.vue` y `StaffLogin.vue`.
  Además, el bootstrap de configuración del frontend employees dejó de depender de `GET /api/public/config` vía fetch y ahora se hidrata desde `window.APP_CONFIG` inyectado por SSR (`index.html` + `app.py`).
  Esto permite endurecer los endpoints de `pronto-employees` sin romper login/register pages.
  Validación: `npm --prefix pronto-static run build` => OK; `npx playwright test tests/functionality/e2e/test_login_flows.spec.ts` => `10 passed`; `npx playwright test tests/functionality/ui/playwright-tests/employees/login-redirect-fix.spec.ts` => `18 passed`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
