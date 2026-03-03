ID: 20260303_waiter_authorization_error_after_admin_logout
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: /waiter cae en authorization-error y mantiene polling realtime tras cerrar admin
DESCRIPCION: Al salir de la consola de admin y navegar a /waiter, el usuario termina en la pantalla de authorization-error con codigo 403. La pantalla de error sigue disparando requests realtime protegidos, lo que mantiene el estado de error y evita caer limpiamente al login de waiter.
PASOS_REPRODUCIR:
1. Iniciar sesion en /admin
2. Cerrar sesion de admin
3. Navegar a /waiter o /waiter/dashboard/waiter
4. Observar redireccion a /waiter/authorization-error y requests /api/realtime/*
RESULTADO_ACTUAL: La app muestra Acceso Denegado y sigue haciendo polling a endpoints realtime/orders y realtime/notifications desde la pantalla de error.
RESULTADO_ESPERADO: Si no existe sesion valida para waiter, debe redirigir a /waiter/login. La pantalla de authorization-error no debe inicializar ni mantener realtime ni llamadas protegidas.
UBICACION:
- /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/App.vue
- /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/shared/core/http.ts
- /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/shared/router/index.ts
EVIDENCIA: Consola reporta AuthorizationError con from=/waiter/dashboard/waiter y XHR a /api/realtime/notifications y /api/realtime/orders aun estando en /waiter/authorization-error.
HIPOTESIS_CAUSA: El redirect de 403 usa /authorization-error sin scope explicito y el runtime autenticado de App.vue no se desmonta ni detiene realtime al cambiar a una ruta guest/error, por lo que las suscripciones siguen activas tras la navegacion.
ESTADO: RESUELTO
SOLUCION: Se corrigieron tres causas relacionadas. Primero, el shell de employees deja de pedir configuracion autorizada `/api/config` en scopes no autorizados como `waiter`, evitando un 403 espurio durante el bootstrap. Segundo, el runtime autenticado de `App.vue` ahora desmonta realtime/notificaciones al entrar a rutas guest o de error y al perder autenticacion. Tercero, `RealtimeClient` deja de construir URLs absolutas que descopeaban los polls hacia `/api/realtime/*` y ahora mantiene el scope correcto `/<scope>/api/realtime/*`. Se verifico manualmente que despues de `admin/logout`, navegar a `/waiter` entra al dashboard waiter si existe sesion waiter valida y, si no existe, redirige a `/waiter/login` en lugar de caer a authorization-error. Tambien se agrego cobertura Playwright para evitar regresion.
COMMIT: pronto-static a41a5ab / pronto-tests 2dfb16d
FECHA_RESOLUCION: 2026-03-03
