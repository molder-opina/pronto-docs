ID: ERR-20260303-ADMIN-WAITER-TABLE-MODAL-USES-ASSIGNED-TABLES-ONLY
FECHA: 2026-03-03
PROYECTO: pronto-static (employees/waiter, employees/chef)
SEVERIDAD: media
TITULO: Modal de mesa en admin consulta solo mesas asignadas y no encuentra la mesa de la orden
DESCRIPCION: En `/admin/dashboard/waiter`, al hacer clic sobre una mesa desde la tabla de órdenes, el modal muestra `No encontramos información de esta mesa` aunque la orden sí contiene `table_number`.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6081/admin/dashboard/waiter`.
2. Hacer clic en una mesa de la tabla de órdenes, por ejemplo `A-07b83a7d`.
3. Observar el modal de detalle.
RESULTADO_ACTUAL: El modal abre en estado `Sin registro` y no resuelve la información de la mesa.
RESULTADO_ESPERADO: El modal debe resolver la mesa desde el catálogo real disponible para admin/system y mostrar al menos zona, estado, capacidad y número de mesa.
UBICACION: pronto-static/src/vue/employees/waiter/components/WaiterBoard.vue; pronto-static/src/vue/employees/chef/components/KitchenBoard.vue
EVIDENCIA: Captura compartida por el usuario en sesión.
HIPOTESIS_CAUSA: `openTableInfo()` consulta únicamente `/api/table-assignments/my-tables`; en `admin/system` esa lista puede venir vacía aunque la mesa exista en `/api/tables`, por lo que el lookup falla por diseño.
ESTADO: RESUELTO
SOLUCION: Se actualizó la resolución de mesas en `WaiterBoard.vue` y `KitchenBoard.vue` para mezclar el resultado de `/api/table-assignments/my-tables` con el catálogo global de `/api/tables`, deduplicando por identidad de mesa y usando `area_name` como fallback de zona. También `fetchMesas()` en waiter dejó de depender solo de asignaciones. Se recompiló `employees` y se validó en runtime que la mesa `A-07b83a7d` ahora muestra zona, estado, capacidad y número de mesa en el modal.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
