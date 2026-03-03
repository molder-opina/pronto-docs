ID: ERR-20260303-DASHBOARD-MODULE-SCROLL-BLOCKED-MODIFIERS
FECHA: 2026-03-03
PROYECTO: pronto-static (employees/shared)
SEVERIDAD: media
TITULO: Vistas largas del dashboard no permiten scroll vertical en Aditamientos
DESCRIPCION: Al entrar a `/admin/dashboard/modifiers`, la vista de `Aditamientos` queda recortada y no permite bajar para seguir viendo grupos/opciones. El problema proviene del contenedor compartido del dashboard, que oculta el overflow vertical del módulo activo.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6081/admin/dashboard/modifiers`.
2. Intentar bajar en la vista de aditamientos.
3. Observar que el contenido inferior queda bloqueado.
RESULTADO_ACTUAL: La vista queda truncada y no hace scroll vertical.
RESULTADO_ESPERADO: El área del módulo debe permitir scroll vertical cuando el contenido supere la altura disponible.
UBICACION: pronto-static/src/vue/employees/shared/components/DashboardView.vue
EVIDENCIA: Captura compartida por el usuario en sesión.
HIPOTESIS_CAUSA: `.dashboard-module-container` usa `overflow: hidden`, lo que bloquea el desplazamiento de vistas largas renderizadas dentro del dashboard.
ESTADO: RESUELTO
SOLUCION: Se cambió `DashboardView.vue` para que `.dashboard-module-container` deje de usar `overflow: hidden` y pase a `overflow-y: auto` con `overflow-x: hidden`. Con esto, las vistas largas del dashboard como `Aditamientos` pueden hacer scroll vertical dentro del shell compartido.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
