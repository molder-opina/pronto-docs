ID: 20260303_admin_reports_chartjs_not_loaded
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Reportes en /admin no carga Chart.js y queda degradado
DESCRIPCION: La vista `/admin/dashboard/reports` carga datos y responde a la búsqueda, pero registra warning de `Chart.js not loaded`, por lo que la visualización queda degradada y no puede renderizar gráficos cuando se esperan.
PASOS_REPRODUCIR:
1. Iniciar sesión en `/admin`
2. Ir a `/admin/dashboard/reports`
3. Pulsar `Buscar`
4. Revisar la consola del navegador
RESULTADO_ACTUAL: La vista muestra datos tabulares, pero la consola registra `[ReportsManager] Chart.js not loaded`.
RESULTADO_ESPERADO: Chart.js debe estar disponible o la vista debe resolver su carga de forma explícita, sin warnings ni degradación accidental.
UBICACION:
- /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/shared/components/ReportsManager.vue
- /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/App.vue
EVIDENCIA: Validación manual en navegador real sobre `http://localhost:6081/admin/dashboard/reports`; al pulsar `Buscar` aparece el warning `Chart.js not loaded`.
HIPOTESIS_CAUSA: El componente dependía de `window.Chart`, pero no resolvía explícitamente la carga del asset local `chart.umd.min.js`, por lo que el render quedaba degradado cuando la librería no estaba preinyectada por el shell.
ESTADO: RESUELTO
SOLUCION: `ReportsManager.vue` ahora carga `Chart.js` desde el asset local `/assets/lib/chart.umd.min.js`, destruye instancias previas antes de redibujar y renderiza las gráficas sin depender de una inyección implícita en el shell.
COMMIT: 386f27b / b7d5535
FECHA_RESOLUCION: 2026-03-03
