ID: ERR-20260303-ADMIN-TABS-SIDEBAR-REOPEN-02
FECHA: 2026-03-03
PROYECTO: pronto-static (employees/admin)
SEVERIDAD: media
TITULO: Reapertura: tabs de admin no gobiernan completamente el shell lateral en vistas internas
DESCRIPCION: En vistas internas de administración como `Productos`, el shell podía seguir resolviendo un scope incorrecto y reintroducir navegación lateral duplicada en lugar de dejar el manejo exclusivamente a los tabs persistentes.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6081/admin/dashboard`.
2. Navegar a `Productos`, `Aditamientos`, `Mesas`, `Áreas` o `Caja y Cierres`.
3. Observar que aparece navegación lateral duplicada en vez de usar solo tabs persistentes.
RESULTADO_ACTUAL: Las tabs no gobiernan de forma exclusiva la navegación entre vistas internas del dashboard admin.
RESULTADO_ESPERADO: El shell de admin debe persistir con tabs como navegación de esas vistas y sin menú lateral duplicado.
UBICACION: pronto-static/src/vue/employees/App.vue
EVIDENCIA: Capturas compartidas por el usuario en sesión.
HIPOTESIS_CAUSA: `App.vue` prioriza detección por ruta antes que el `app_context` SSR, dejando margen a resolver el scope equivocado en navegación interna.
ESTADO: RESUELTO
SOLUCION: `App.vue` ahora prioriza `document.body.dataset.appContext` y `window.APP_CONTEXT` antes de inferir el scope por ruta. Con eso, las vistas internas de `admin` conservan el mismo shell lateral compacto y la navegación queda gobernada por tabs persistentes.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
