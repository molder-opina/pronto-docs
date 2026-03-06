ID: OPS-20260306-004
FECHA: 2026-03-06
PROYECTO: pronto-tests, pronto-static
SEVERIDAD: media
TITULO: Specs Playwright de employees asumen forma rígida de URL dashboard
DESCRIPCION:
  Varias pruebas Playwright de employees asumen que, tras login, la URL final debe ser
  exactamente `/<scope>/dashboard`. En la implementación actual del router compartido, la
  navegación autenticada puede resolver a rutas canónicas bajo `/dashboard/*` (por ejemplo
  `/dashboard/waiter` o `/dashboard/kitchen`) mientras mantiene compatibilidad con aliases
  scopeados. Esto provoca falsos negativos en pruebas aun cuando el login y el dashboard
  funcionan correctamente.
PASOS_REPRODUCIR:
  1. Ejecutar `npx playwright test tests/functionality/ui/playwright-tests/employees/orders.spec.ts -g "waiter can access orders page"`.
  2. Iniciar sesión como waiter.
  3. Observar navegación a `http://localhost:6081/dashboard/waiter`.
  4. Verificar timeout en `waitForURL(/\/waiter\/dashboard/)`.
RESULTADO_ACTUAL:
  Los tests fallan por esperar una forma rígida de URL aunque el dashboard haya cargado.
RESULTADO_ESPERADO:
  Las pruebas deben validar autenticación y carga de dashboard con una expectativa compatible
  con ambas formas soportadas de ruta (`/<scope>/dashboard` y `/dashboard/*`).
UBICACION:
  - `pronto-tests/tests/functionality/ui/playwright-tests/employees/orders.spec.ts`
  - `pronto-tests/tests/functionality/e2e/chef_notifications.spec.ts`
  - `pronto-tests/tests/functionality/ui/playwright-tests/employees/login-redirect-fix.spec.ts`
EVIDENCIA:
  - Timeout en `waitForURL(/\/waiter\/dashboard/)` con navegación real a `/dashboard/waiter`
HIPOTESIS_CAUSA:
  Las specs quedaron desalineadas tras cambios previos del router employees que introdujeron
  rutas canónicas bajo `/dashboard/*` y aliases scopeados para compatibilidad.
ESTADO: RESUELTO
SOLUCION: Se actualizaron specs Playwright de employees para aceptar forma canónica de URL dashboard (`/dashboard/*`) además de aliases scopeados, reemplazando `waitForURL` rígidos por patrón compatible y expectativas de path más tolerantes.
COMMIT: 6d17ea2
FECHA_RESOLUCION: 2026-03-06
