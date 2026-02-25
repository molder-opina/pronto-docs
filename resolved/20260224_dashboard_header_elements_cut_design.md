ID: ERR-20260224-DASHBOARD-HEADER-ELEMENTS-CUT
FECHA: 2026-02-24
PROYECTO: pronto-static (employees)
SEVERIDAD: media
TITULO: Elementos del header/dashboard se recortan y el bloque principal carece de jerarquía visual
DESCRIPCION: En el dashboard de empleados se observaban elementos cortados en cabecera por alturas rígidas e inline styles, además de una presentación visual plana en el bloque “Panel de Operaciones”.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6081/waiter/dashboard`.
2. Observar cabecera superior (restaurante/usuario) y bloque “Panel de Operaciones”.
3. Ver recortes en algunos escenarios y diseño con baja jerarquía visual.
RESULTADO_ACTUAL: Elementos susceptibles a recorte por `height/max-height` rígidos y layout poco consistente.
RESULTADO_ESPERADO: Cabecera sin recortes, con espaciado responsive y diseño claro en dashboard.
UBICACION: pronto-static/src/vue/employees/components/Header.vue; pronto-static/src/vue/employees/components/DashboardView.vue
EVIDENCIA: Captura compartida por usuario en sesión.
HIPOTESIS_CAUSA: Combinación de estilos inline con alturas fijas y line-height ajustado demasiado bajo en contenedores de cabecera.
ESTADO: RESUELTO
SOLUCION: Se retiraron estilos inline rígidos, se ajustaron alturas a min-height/padding flexibles, se mejoró la tipografía y overflow responsive, y se rediseñó el bloque `dashboard-header` con estructura visual (eyebrow, subtítulo y badge de módulo activo).
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-24
