ID: TEST-20260308-026
FECHA: 2026-03-08
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: Playwright cliente menu-runtime aún espera .menu-page aunque el SSR actual exige login previo
DESCRIPCION:
  El browser test `menu-runtime.spec.ts` navegaba al cliente y esperaba ver `.menu-page`,
  pero el cliente actual expone un gate de autenticación con links a `/login` y `/register`.
PASOS_REPRODUCIR:
  1. Ejecutar `npx playwright test tests/functionality/ui/playwright-tests/clients/menu-runtime.spec.ts`.
  2. Observar fallo en la expectativa de `.menu-page`.
RESULTADO_ACTUAL:
  El test fallaba aunque la página cliente respondía correctamente con el gate de autenticación obligatorio.
RESULTADO_ESPERADO:
  El test debe validar el gate/login actual y comprobar fetches same-origin a `/api/shortcuts` y `/api/menu`.
UBICACION:
  - `pronto-tests/tests/functionality/ui/playwright-tests/clients/menu-runtime.spec.ts`
EVIDENCIA:
  - snapshot Playwright mostrando "Para continuar debes iniciar sesión o registrarte.".
HIPOTESIS_CAUSA:
  Drift del test frente al acceso autenticado obligatorio definido en AGENTS.md.
ESTADO: RESUELTO
SOLUCION:
  Se actualizó el spec para validar el gate visible real (`/login`) y se añadieron fetches browser-level
  a `/api/shortcuts` y `/api/menu` verificando same-origin sin CORS a `:6082`.
COMMIT: 491a50f
FECHA_RESOLUCION: 2026-03-08

