ID: 20260303_waiter_sidebar_duplicates_meseros_in_operation_group
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: El sidebar de mesero duplica Meseros en navegación principal y en Operación
DESCRIPCION: En la consola `/waiter`, el sidebar muestra `Meseros` en la navegación principal y vuelve a renderizar `Meseros` dentro del grupo `OPERACIÓN`, generando redundancia visual.
PASOS_REPRODUCIR:
1. Entrar a `/waiter/dashboard/waiter`
2. Observar el sidebar izquierdo
RESULTADO_ACTUAL: `Meseros` aparece dos veces, una en navegación principal y otra en `Módulos de operación > Operación`.
RESULTADO_ESPERADO: En el scope `waiter`, `Meseros` debe aparecer una sola vez en la navegación principal.
UBICACION:
- /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/shared/components/Sidebar.vue
EVIDENCIA: Captura del sidebar de `/waiter` mostrando ambos accesos simultáneamente.
HIPOTESIS_CAUSA: El agrupado de módulos reutiliza la misma lista de secciones visibles del scope `waiter` sin excluir la entrada primaria `waiter`.
ESTADO: RESUELTO
SOLUCION: `Sidebar.vue` ahora excluye la sección `waiter` del bloque `Módulos de operación` cuando el scope actual es `waiter`, dejando `Meseros` solo en la navegación principal. El cambio no altera rutas ni permisos; únicamente evita la duplicidad visual del sidebar. Validado con `npm run build:employees`.
COMMIT: ae59949, 8d5e5a2
FECHA_RESOLUCION: 2026-03-03
