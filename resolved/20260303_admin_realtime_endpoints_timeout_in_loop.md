ID: 20260303_admin_realtime_endpoints_timeout_in_loop
FECHA: 2026-03-03
PROYECTO: pronto-static, pronto-employees
SEVERIDAD: alta
TITULO: Shell de /admin dispara realtime en loop contra endpoints que responden 504
DESCRIPCION: Las vistas de `/admin` cargan, pero el shell sigue disparando polling/realtime a `/admin/api/realtime/notifications` y `/admin/api/realtime/orders`, lo que produce `504 GATEWAY TIMEOUT` de forma repetida y llena la consola con errores y warnings.
PASOS_REPRODUCIR:
1. Iniciar sesión en `/admin`
2. Ir a `/admin/dashboard/employees` o `/admin/dashboard/cashier`
3. Esperar unos segundos
4. Revisar consola y red
RESULTADO_ACTUAL: Se registran errores repetidos contra `/admin/api/realtime/notifications?after_id=0-0` y `/admin/api/realtime/orders?after_id=0-0`, ambos con `504`.
RESULTADO_ESPERADO: El shell administrativo no debe entrar en loop de timeout; debe usar un endpoint funcional o desactivar ese realtime en scopes donde no está disponible.
UBICACION:
- /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/App.vue
- /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/shared/core/realtime.ts
- /Users/molder/projects/github-molder/pronto/pronto-employees/src/pronto_employees/routes/api/proxy_console_api.py
EVIDENCIA: Validación manual en `http://localhost:6081/admin/dashboard/employees` y `http://localhost:6081/admin/dashboard/cashier`; red muestra `504 GATEWAY TIMEOUT` repetidos en `/admin/api/realtime/*`.
HIPOTESIS_CAUSA: El shell de `admin` estaba inicializando el mismo runtime operativo de mesero, incluyendo polling de órdenes y notificaciones sobre endpoints realtime inexistentes o no soportados para ese scope.
ESTADO: RESUELTO
SOLUCION: `App.vue` ahora separa runtime de llamadas pendientes y runtime realtime. El scope `admin` deja de inicializar polling continuo de `/api/realtime/orders` y `/api/realtime/notifications`; solo `waiter` mantiene ese realtime. `admin` conserva una carga puntual de llamadas pendientes sin loop de timeout.
COMMIT: 386f27b / b7d5535
FECHA_RESOLUCION: 2026-03-03
