ID: 20260303_operational_boards_missing_filters_button_and_floating_form
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: Los tableros operativos perdieron el botón de filtros y el formulario flotante
DESCRIPCION: Las vistas operativas de mesero, cocina y caja ya no muestran el botón de filtros rápidos ni el formulario flotante que permitía controlar la visibilidad de órdenes desde la UI. La regresión impacta `/waiter`, `/chef`, `/cashier` y sus variantes bajo `/admin`.
PASOS_REPRODUCIR:
1. Ingresar a `/waiter/dashboard/waiter` o `/admin/dashboard/waiter`.
2. Revisar la barra de búsqueda y acciones del tablero.
3. Repetir en `/chef/dashboard/kitchen`, `/cashier/dashboard/cashier` y sus variantes de admin.
RESULTADO_ACTUAL: No existe botón de filtros ni modal flotante para configurar visibilidad de órdenes y filtros rápidos.
RESULTADO_ESPERADO: Debe existir un botón visible de filtros en cada tablero operativo y al hacer clic debe abrir un formulario flotante para ajustar filtros rápidos por tablero.
UBICACION: pronto-static/src/vue/employees/waiter/components/WaiterBoard.vue, pronto-static/src/vue/employees/chef/components/KitchenBoard.vue, pronto-static/src/vue/employees/cashier/components/CashierBoard.vue
EVIDENCIA: Reporte del usuario con captura donde la barra del tablero ya no muestra el botón de filtros.
HIPOTESIS_CAUSA: La migración de tableros a componentes Vue SFC conservó la búsqueda y tabs, pero omitió el control flotante de filtros que sí existía en la implementación anterior.
ESTADO: RESUELTO
SOLUCION: Se restauró el patrón de filtros rápidos con un modal compartido `FloatingFiltersModal.vue` y se reintegró el botón `Filtros` en los tableros Vue de mesero, cocina y caja. Cada tablero recupera filtros rápidos persistidos por `localStorage` y mantiene el mismo comportamiento tanto en scopes directos como en `/admin` al reutilizar los mismos componentes.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
