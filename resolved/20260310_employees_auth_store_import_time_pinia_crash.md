ID: BUG-20260310-EMPLOYEES-AUTH-STORE-IMPORT-TIME-PINIA-CRASH
FECHA: 2026-03-10
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: El bundle employees rompe login por `useAuthStore()` ejecutado en tiempo de import antes de instalar Pinia
DESCRIPCION: Al recompilar el bundle employees para corregir el flujo de admin-call, la pantalla `/waiter/login` quedó en blanco y el navegador reportó `Cannot read properties of undefined (reading '_s')`. El source map apuntó a `shared/store/auth.ts`, donde se ejecutaba `useAuthStore()` a nivel de módulo para asignar `window.refreshUserProfile`, antes de `app.use(pinia)`.
PASOS_REPRODUCIR:
1. Ejecutar `cd pronto-static && npm run build:employees` con el binding eager.
2. Abrir `/waiter/login`.
3. Observar `TypeError: Cannot read properties of undefined (reading '_s')` y ausencia del formulario.
RESULTADO_ACTUAL: Resuelto.
RESULTADO_ESPERADO: El store auth no debe instanciarse en tiempo de import; el login debe renderizar/hidratar correctamente.
UBICACION:
- pronto-static/src/vue/employees/shared/store/auth.ts
- pronto-static/src/vue/employees/bootstrap/create-app.ts
EVIDENCIA:
- Source map: `main.js:29:26997` -> `shared/store/auth.ts:251`.
- Búsqueda transversal del patrón en employees mostró este binding global como único caso módulo->window con `useStore()`.
- `auth.spec.ts` pasó 3/3 tras el fix y rebuild.
HIPOTESIS_CAUSA: El módulo auth se evaluaba antes de instalar Pinia; la llamada eager a `useAuthStore()` usaba un Pinia activo inexistente y rompía la inicialización del bundle.
ESTADO: RESUELTO
SOLUCION:
- Se reemplazó el binding eager por un wrapper lazy: `window.refreshUserProfile = async () => useAuthStore().refreshUserProfile()`.
- Se recompiló de nuevo `npm run build:employees` y se verificó que el login volvió a hidratar.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

