ID: ERR-20260224-EMPLOYEES-TABS-DUAL-ACTIVE
FECHA: 2026-02-24
PROYECTO: pronto-static (employees)
SEVERIDAD: media
TITULO: Selección de módulos mostraba doble activo y diseño incómodo en dashboard de empleados
DESCRIPCION: En el dashboard de empleados, al cambiar a módulos de gestión, `Meseros` seguía resaltado por coincidencia parcial de rutas. Además, la selección se percibía demasiado rígida/cuadrada.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6081/waiter/dashboard`.
2. Seleccionar `Aditamientos`, `Mesas` o `Áreas`.
3. Observar que `Meseros` permanece activo junto con el módulo seleccionado.
RESULTADO_ACTUAL: Doble resaltado de selección y experiencia visual poco cómoda.
RESULTADO_ESPERADO: Solo un módulo activo según la vista actual y estilos de selección más cómodos.
UBICACION: pronto-static/src/vue/employees/components/Sidebar.vue; pronto-static/src/vue/employees/components/DashboardView.vue
EVIDENCIA: Captura y reporte del usuario en sesión.
HIPOTESIS_CAUSA: Uso de `active-class` (match parcial) en enlaces con ruta base `/dashboard`, lo que mantiene activo el módulo raíz en rutas hijas.
ESTADO: RESUELTO
SOLUCION: Se migró a `exact-active-class="active"` para selección exacta en sidebar y tabs de dashboard. Se refinó el diseño de selección (pill nav, hover/active states, bordes y sombras) para mejor legibilidad y confort.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-24
