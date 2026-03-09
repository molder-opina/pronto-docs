ID: OPS-20260306-003
FECHA: 2026-03-06
PROYECTO: pronto-static, pronto-tests
SEVERIDAD: alta
TITULO: Login de employees queda en 'Iniciando Pronto...' por loop masivo de /api/auth/me
DESCRIPCION:
  En las páginas de login de employees (`/chef/login`, `/waiter/login`) el frontend Vue puede
  quedarse indefinidamente en el estado de carga "Iniciando Pronto...". La causa observable es
  un loop masivo de requests 401 a `/<scope>/api/auth/me`, disparado por el bootstrap/router,
  que impide estabilizar la navegación guest y por ende no hidrata el formulario de login.
PASOS_REPRODUCIR:
  1. Abrir `http://localhost:6081/chef/login` o `http://localhost:6081/waiter/login`.
  2. Esperar la hidratación del frontend.
  3. Observar que el body permanece en `Iniciando Pronto...`.
  4. Capturar respuestas 401 desde el navegador o Playwright.
RESULTADO_ACTUAL:
  El formulario de login no aparece y se producen miles de requests 401 a
  `http://localhost:6081/<scope>/api/auth/me` en pocos segundos.
RESULTADO_ESPERADO:
  El frontend debe intentar la detección de sesión de forma acotada; ante 401 debe estabilizar
  el estado y renderizar el login guest sin entrar en bucle.
UBICACION:
  - `pronto-static/src/vue/employees/shared/store/auth.ts`
  - `pronto-static/src/vue/employees/shared/router/index.ts`
  - `pronto-static/src/vue/employees/App.vue`
  - `pronto-tests/tests/functionality/ui/playwright-tests/employees/orders.spec.ts`
  - `pronto-tests/tests/functionality/e2e/chef-notifications.spec.ts`
EVIDENCIA:
  - Snapshot Playwright: `Iniciando Pronto...`
  - Inspección con Playwright: `http://localhost:6081/chef/api/auth/me` respondió 401 más de 2000 veces en ~4s
HIPOTESIS_CAUSA:
  El bootstrap de autenticación reintenta `fetchUser()` tras fallo 401 sin un guard de intento
  único por carga, mientras el router sigue reevaluando navegación antes de estabilizar la ruta guest.
ESTADO: RESUELTO
SOLUCION: Se agregó guard de intento único de sonda de sesión (`sessionProbeAttempted`) en `auth.ts`, se evitó re-disparo de `fetchUser()` en router/bootstrap si el probe ya ocurrió, y `App.vue` renderiza explícitamente `StaffLogin` en rutas de login para estabilizar UI guest sin loop de `/api/auth/me`.
COMMIT: e8ea298
FECHA_RESOLUCION: 2026-03-06
