ID: 20260303_sessions_tabs_active_state_is_not_visually_clear
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Los tabs de Caja y Cierres no dejan claro cuál opción está seleccionada
DESCRIPCION: En la vista `Caja y Cierres`, los tabs `Cuentas por Pagar` y `Órdenes Cerradas` tienen contraste insuficiente entre estados activo e inactivo, dificultando identificar qué panel está seleccionado.
PASOS_REPRODUCIR:
1. Entrar a `/waiter/dashboard/sessions` o cualquier consola que reutilice `SessionsBoard`
2. Alternar entre `Cuentas por Pagar` y `Órdenes Cerradas`
3. Observar el selector superior
RESULTADO_ACTUAL: El estado activo se percibe débil y visualmente similar al inactivo.
RESULTADO_ESPERADO: El tab activo debe tener tratamiento claro de color, elevación y contraste para distinguirse de inmediato del inactivo.
UBICACION:
- /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/cashier/views/sessions/SessionsBoard.vue
EVIDENCIA: Capturas de `/waiter/dashboard/sessions` muestran el selector superior sin diferencia clara entre ambos estados.
HIPOTESIS_CAUSA: El estilo actual usa fondo blanco para el contenedor y un estado activo muy cercano en contraste, sin borde, sombra ni jerarquía suficiente para el tab seleccionado.
ESTADO: RESUELTO
SOLUCION: Se reforzó el selector de tabs en `SessionsBoard.vue` con contenedor diferenciado, estados `aria-selected`, elevación y gradiente para el tab activo, hover legible para el inactivo y badges consistentes. Como la vista es compartida, el cambio aplica a `waiter`, `cashier`, `admin` y cualquier consola que reutilice `Caja y Cierres`. Se agregó un spec de Playwright que valida el cambio de estado activo entre ambos tabs.
COMMIT: 5fb3c6e, d6177fe, 8d33e3d
FECHA_RESOLUCION: 2026-03-03
