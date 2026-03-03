ID: ERR-20260303-WAITER-MESAS-TAB-BROKEN-LAYOUT-AND-NAN-TOTALS
FECHA: 2026-03-03
PROYECTO: pronto-static (employees/waiter)
SEVERIDAD: media
TITULO: Tab Mesas de mesero en admin y waiter muestra layout roto, zona incorrecta y totales NaN
DESCRIPCION: En `/admin/dashboard/waiter` y `/waiter/dashboard`, el tab `Mesas` del tablero de mesero renderiza tarjetas demasiado estrechas, agrupa todo bajo `Sin zona` y puede mostrar `$NaN` como total acumulado de la mesa.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6081/admin/dashboard/waiter` o la consola `/waiter`.
2. Entrar al tab `Mesas`.
3. Observar la tarjeta de la mesa ocupada.
RESULTADO_ACTUAL: El diseño se ve roto, la zona no se resuelve desde el catálogo real y el total de la mesa puede terminar en `$NaN`.
RESULTADO_ESPERADO: El tab `Mesas` debe mostrar tarjetas amplias y legibles, agrupadas por área real, con total monetario válido y estados de órdenes presentados de forma consistente.
UBICACION: pronto-static/src/vue/employees/waiter/components/WaiterBoard.vue
EVIDENCIA: Captura compartida por el usuario en sesión.
HIPOTESIS_CAUSA: `occupiedTables` calcula el área como `Sin zona` por diseño, no usa el catálogo real cargado en `mesasData/tableInfoCache`, y suma importes a partir de campos opcionales sin normalización robusta; además el grid y la tarjeta usan dimensiones demasiado pequeñas para la cantidad de contenido.
ESTADO: RESUELTO
SOLUCION: Se rediseñó el tab `Mesas` en `WaiterBoard.vue`, que es compartido por `/admin/dashboard/waiter` y la consola `/waiter`: ahora el total por orden se normaliza con `getOrderTotal()`, las mesas se enriquecen con el catálogo real para resolver área/color, el agrupado por área usa datos efectivos del catálogo y las tarjetas se ampliaron con layout horizontal, KPI superior y pills legibles por orden. Se recompiló `employees` y se validó visualmente el tab `Mesas` en `/admin/dashboard/waiter`, confirmando zona real `Area-07b83a7d` y total válido `$90.93`.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
