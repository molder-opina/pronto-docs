ID: 20260303_waiter_sidebar_should_hide_management_modules_and_show_sessions_tab
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Waiter muestra módulos de gestión en sidebar y no incluye Caja y Cierres en tabs
DESCRIPCION: En la consola `waiter`, los accesos de gestión siguen visibles en el menú lateral aunque esa navegación debe resolverse solo con los tabs superiores. Además, el strip superior de tabs no incluye `Caja y Cierres`.
PASOS_REPRODUCIR:
1. Entrar a `/waiter/dashboard/waiter`
2. Observar el sidebar izquierdo y el strip de tabs superior
RESULTADO_ACTUAL: El sidebar muestra productos, aditamientos, mesas, áreas y caja y cierres dentro de módulos, y el strip superior no muestra `Caja y Cierres`.
RESULTADO_ESPERADO: En `waiter`, la navegación de gestión debe vivir solo en los tabs superiores y el strip debe incluir `Caja y Cierres`.
UBICACION:
- /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/shared/components/Sidebar.vue
- /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/shared/components/DashboardView.vue
EVIDENCIA: Capturas de `/waiter/dashboard/waiter` con el bloque lateral de gestión visible y ausencia de `Caja y Cierres` en tabs.
HIPOTESIS_CAUSA: El sidebar compartido no distingue que el scope `waiter` debe usar tabs como navegación secundaria exclusiva, y `DashboardView` dejó fuera la ruta `sessions` del grupo waiter.
ESTADO: RESUELTO
SOLUCION: En `Sidebar.vue` se deshabilitó por completo el bloque `Módulos de operación` para el scope `waiter`, dejando la gestión accesible solo desde el strip de tabs. En `DashboardView.vue` se agregó `sessions` al grupo de tabs waiter para que `Caja y Cierres` quede visible junto a `Mesero`, `Productos`, `Aditamientos`, `Mesas` y `Áreas`. Validado con `npm run build:employees` y comprobación visual en `/waiter/dashboard/waiter`.
COMMIT: 0f78619, e5f3371
FECHA_RESOLUCION: 2026-03-03
