ID: ERR-20260303-ADMIN-SIDEBAR-THEME-INCONSISTENCY
FECHA: 2026-03-03
PROYECTO: pronto-static (employees/admin)
SEVERIDAD: media
TITULO: Sidebar de admin usa diseño azul hardcodeado y no respeta el tema configurable
DESCRIPCION: En `/admin/dashboard/*`, el menú lateral muestra estilos azules hardcodeados que rompen la consistencia visual con el tema general configurable desde `/admin` y con el lenguaje visual ya aplicado en `/waiter`.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6081/admin/dashboard/config`.
2. Comparar el sidebar lateral con el de `/waiter/dashboard`.
3. Observar que el estado activo en admin usa un azul fijo y que el fondo no reutiliza los colores de branding configurables.
RESULTADO_ACTUAL: El sidebar de admin se percibe como una variante azul ajena al tema general y distinta al diseño de waiter.
RESULTADO_ESPERADO: El sidebar de admin debe usar el mismo lenguaje visual del dashboard de empleados y derivar sus colores del tema configurable (`brand_color_primary` y `brand_color_secondary`).
UBICACION: pronto-static/src/vue/employees/shared/components/Sidebar.vue
EVIDENCIA: Capturas compartidas por el usuario en sesión mostrando la discrepancia entre `/admin` y `/waiter`.
HIPOTESIS_CAUSA: El componente compartido `Sidebar.vue` conserva gradientes, hover y estados activos hardcodeados en azul/pizarra, sin enlazarse al branding cargado por `configStore`.
ESTADO: RESUELTO
SOLUCION: Se conectó `Sidebar.vue` al `configStore` para derivar sus tokens visuales desde `brand_color_primary` y `brand_color_secondary`. El fondo, hover, pills activos, botón de colapso y FAB dejan de usar azules hardcodeados y adoptan el mismo lenguaje visual del dashboard waiter, con navegación principal suave y módulos activos en el color de marca.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
