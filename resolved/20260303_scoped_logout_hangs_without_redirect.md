ID: 20260303_scoped_logout_hangs_without_redirect
FECHA: 2026-03-03
PROYECTO: pronto-static, pronto-employees
SEVERIDAD: alta
TITULO: Logout por consola se queda colgado y no aterriza en login
DESCRIPCION: Al usar `Cerrar Sesión` desde las consolas de empleados, la navegación queda pensando en la ruta actual o tarda indefinidamente en completar el flujo, en lugar de limpiar sesión y aterrizar limpiamente en `/<scope>/login`.
PASOS_REPRODUCIR:
1. Iniciar sesión en `/waiter` o cualquier consola de empleados
2. Abrir el menú de usuario
3. Pulsar `Cerrar Sesión`
RESULTADO_ACTUAL: La vista queda cargando y el navegador no aterriza limpiamente en el login del scope.
RESULTADO_ESPERADO: La sesión debe cerrarse de forma inmediata y el usuario debe terminar en `/<scope>/login` sin quedar colgado.
UBICACION:
- /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/shared/store/auth.ts
- /Users/molder/projects/github-molder/pronto/pronto-employees/src/pronto_employees/routes/**/auth.py
EVIDENCIA: Reproducción manual en `http://localhost:6081/waiter/dashboard/waiter`; tras pulsar logout, la pestaña queda cargando en vez de redirigir limpiamente.
HIPOTESIS_CAUSA: El logout del header dependía por completo de JavaScript para redirigir; si el runtime del dashboard estaba degradado o el control quedaba con navegación local, el usuario no aterrizaba de forma confiable en `/<scope>/logout`.
ESTADO: RESUELTO
SOLUCION: El control `Cerrar Sesión` del header pasó a navegar con `href` real hacia `/<scope>/logout`, mientras `App.vue` detiene el runtime autenticado antes de salir sin volver a interceptar la redirección. Se validó manualmente desde el menú de usuario en `/waiter/dashboard` y con Playwright sobre la ruta de logout del scope.
COMMIT: b765299, c9d60e0, dc6bc64
FECHA_RESOLUCION: 2026-03-03
