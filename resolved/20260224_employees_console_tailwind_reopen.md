ID: ERR-20260224-EMPLOYEES-CONSOLE-TAILWIND-ORB-REOPEN-01
FECHA: 2026-02-24
PROYECTO: pronto-static / pronto-employees
SEVERIDAD: media
TITULO: Reapertura - dashboard employees sigue cargando CSS hash viejo con @tailwind y presenta ruido por polling realtime duplicado
DESCRIPCION: Reapertura del incidente ERR-20260224-EMPLOYEES-CONSOLE-TAILWIND-ORB. El navegador sigue reportando parseo de `@tailwind` sobre `main-CZ8J4KUk.css` y se observan múltiples requests periódicos a endpoints realtime.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6081/waiter/dashboard`.
2. Revisar consola y red del navegador.
3. Observar error CSS sobre `main-CZ8J4KUk.css` y repetición de llamadas a `/api/realtime/orders` y `/api/realtime/notifications`.
RESULTADO_ACTUAL: Persisten warnings/errores de CSS hash viejo y ruido de polling realtime.
RESULTADO_ESPERADO: Solo debe cargarse el CSS hash vigente sin directivas Tailwind runtime y el polling realtime debe ejecutarse sin duplicaciones.
UBICACION: pronto-employees/src/pronto_employees/templates/index.html; pronto-employees/src/pronto_employees/app.py; pronto-static/src/vue/employees/core/realtime.ts; pronto-static/src/vue/employees/store/orders.ts; pronto-static/src/vue/employees/App.vue
EVIDENCIA: Reporte de consola del usuario con `main-CZ8J4KUk.css` y secuencias repetidas `GET /api/realtime/*`.
HIPOTESIS_CAUSA: Uso de referencia stale de CSS hash antiguo en cliente y falta de aislamiento/singleton en clientes realtime (storage key y/o múltiple inicialización).
ESTADO: RESUELTO
SOLUCION: Se agregó canonicalización defensiva de CSS hash legacy en `assets_passthrough` para mapear cualquier `main-*.css` antiguo al hash vigente del manifest, se agregó query de versión en link CSS SSR, y se reforzó realtime con storage key por endpoint + singleton de clientes globales (`ProntoRealtime`/`ProntoNotifications`) para evitar duplicación de polling.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-24
