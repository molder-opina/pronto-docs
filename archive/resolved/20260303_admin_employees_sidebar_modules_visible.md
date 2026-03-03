ID: ERR-20260303-ADMIN-EMPLOYEES-SIDEBAR-MODULES-VISIBLE
FECHA: 2026-03-03
PROYECTO: pronto-static (employees/admin)
SEVERIDAD: media
TITULO: Sidebar sigue mostrando módulos de operación dentro de Empleados en admin
DESCRIPCION: En la sección `Empleados` de admin, el sidebar todavía puede renderizar el bloque `Módulos de operación` con opciones operativas y de gestión, aunque esa navegación no debe aparecer dentro de las secciones administrativas.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6081/admin/dashboard/employees`.
2. Revisar el menú lateral.
3. Observar que aparece el bloque `Módulos de operación`.
RESULTADO_ACTUAL: El sidebar de `Empleados` duplica navegación con módulos que no corresponden a la sección administrativa.
RESULTADO_ESPERADO: En `Empleados` y demás secciones administrativas, el sidebar solo debe mostrar navegación principal administrativa.
UBICACION: pronto-static/src/vue/employees/shared/components/Sidebar.vue
EVIDENCIA: Reporte del usuario en sesión.
HIPOTESIS_CAUSA: El sidebar solo depende del scope y de las secciones disponibles; falta una guarda explícita por ruta administrativa activa para ocultar el bloque de módulos.
ESTADO: RESUELTO
SOLUCION: Se agregó una guarda explícita en `Sidebar.vue` para ocultar `Módulos de operación` cuando la ruta activa corresponde a una sección administrativa (`employees`, `roles`, `reports`, `config`), incluso si el componente recibe secciones operativas por props.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
