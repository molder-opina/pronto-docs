ID: ERR-20260303-ADMIN-CASHIER-BOARD-UNSTYLED-LAYOUT
FECHA: 2026-03-03
PROYECTO: pronto-static (employees/cashier)
SEVERIDAD: media
TITULO: Vista de Caja en admin renderiza layout roto y elementos sobredimensionados
DESCRIPCION: Al abrir `/admin/dashboard/cashier`, el tablero de caja se ve descompuesto: el icono del buscador aparece gigantesco, la tabla pierde su estructura y el contenido queda mal posicionado dentro del panel.
PASOS_REPRODUCIR:
1. Iniciar sesión en la consola administrativa.
2. Abrir `http://localhost:6081/admin/dashboard/cashier`.
3. Observar el módulo de caja.
RESULTADO_ACTUAL: El layout aparece roto, con SVG sobredimensionado y controles sin estilos.
RESULTADO_ESPERADO: Caja debe mantener una tarjeta/tablero consistente con el resto de módulos operativos del dashboard.
UBICACION: pronto-static/src/vue/employees/cashier/components/CashierBoard.vue
EVIDENCIA: Capturas compartidas por el usuario en sesión.
HIPOTESIS_CAUSA: `CashierBoard.vue` usa clases estructurales (`waiter-toolbar`, `orders-table`, etc.) pero no define ningún bloque de estilos scoped propio, así que el componente se renderiza sin CSS efectivo.
ESTADO: RESUELTO
SOLUCION: Se reescribió `CashierBoard.vue` con layout y estilos scoped propios: encabezado operativo, métricas, buscador con icono dimensionado, toolbar, tabla de órdenes, badges de pago y acciones de cobro/división coherentes con el shell administrativo. Luego se recompiló `employees` y se reinició `pronto-employees-1` para validar la vista limpia en runtime.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03

