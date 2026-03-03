ID: ERR-20260303-ADMIN-WAITER-TAB-LABEL-SHOULD-BE-MESERO
FECHA: 2026-03-03
PROYECTO: pronto-static (employees/admin)
SEVERIDAD: baja
TITULO: Tab principal del tablero administrativo muestra "Tablero" en lugar de "Mesero"
DESCRIPCION: En el dashboard operativo de `/admin`, el primer tab superior aparece como `Tablero`, pero el usuario requiere que en ese contexto la etiqueta visible sea `Mesero`.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6081/admin/dashboard/waiter`.
2. Revisar el primer tab del strip superior.
3. Observar que la etiqueta visible actual es `Tablero`.
RESULTADO_ACTUAL: El tab muestra `Tablero`.
RESULTADO_ESPERADO: El tab debe mostrar `Mesero` solo en ese contexto visual.
UBICACION: pronto-static/src/vue/employees/shared/components/DashboardView.vue
EVIDENCIA: Captura compartida por el usuario en sesión.
HIPOTESIS_CAUSA: La definición compartida de tabs usa el label `Tablero` para la ruta `waiter`, también en el shell administrativo.
ESTADO: RESUELTO
SOLUCION: Se actualizó la definición del tab `waiter` en `DashboardView.vue` para que el label visible sea `Mesero`, manteniendo intacta la ruta y la estructura de navegación.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03

