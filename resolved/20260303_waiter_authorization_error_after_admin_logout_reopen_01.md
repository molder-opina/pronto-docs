ID: 20260303_waiter_authorization_error_after_admin_logout_reopen_01
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: Botón Ir a Login desde authorization-error puede relanzar loop de 403 en waiter
DESCRIPCION: Aunque se corrigió el bootstrap general de `/waiter`, al hacer clic en `Ir a Login` desde la pantalla de `authorization-error` el flujo puede volver a enviar al usuario a `/waiter/dashboard` y disparar nuevamente el 403, en lugar de llevarlo a una pantalla de login limpia.
PASOS_REPRODUCIR:
1. Llegar a la pantalla `authorization-error` de waiter
2. Hacer clic en `Ir a Login`
3. Observar navegación hacia waiter
4. Verificar que vuelve a aparecer `authorization-error` desde `/waiter/dashboard`
RESULTADO_ACTUAL: El botón intenta entrar a login sin limpiar primero el scope waiter y el flujo puede reciclar una sesión stale del scope, provocando un nuevo 403.
RESULTADO_ESPERADO: `Ir a Login` debe limpiar la sesión/cookies del scope actual y llevar siempre a `/${scope}/login` sin relanzar `authorization-error`.
UBICACION:
- /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/shared/views/AuthorizationError.vue
EVIDENCIA: Reporte de usuario con URL final `http://localhost:6081/waiter/authorization-error?...&from=%2Fwaiter%2Fdashboard` inmediatamente después de pulsar `Ir a Login`.
HIPOTESIS_CAUSA: El botón navega directo a `/${scope}/login`, lo que permite que cualquier cookie stale de ese scope reactive la ruta protegida o un redirect automático antes de que el usuario vea el formulario.
ESTADO: RESUELTO
SOLUCION: El botón `Ir a Login` de `AuthorizationError.vue` ahora pasa por `/${scope}/logout` en lugar de navegar directamente a `/${scope}/login`. De esa forma se eliminan primero las cookies namespaced del scope activo y el usuario aterriza en una pantalla de login limpia, sin reactivar un redirect stale hacia `/waiter/dashboard`. Se validó manualmente dentro de la SPA empujando la ruta `authorization-error` y pulsando el botón, y también se agregó una prueba Playwright específica.
COMMIT: pronto-static a5a32db / pronto-tests 35fea35
FECHA_RESOLUCION: 2026-03-03
