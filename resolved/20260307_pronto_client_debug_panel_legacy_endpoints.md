ID: CLIENT-20260307-009
FECHA: 2026-03-07
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: debug_panel.html contiene llamadas a endpoints legacy/no definidos
DESCRIPCION:
  El panel de debug frontend seguía llamando rutas no implementadas en el BFF actual, incluyendo `/api/session/...`,
  `/api/debug/...`, `/api/support-tickets` y `/api/promotions`. Eso producía requests fallidas y ruido en una herramienta
  interna de diagnóstico.
PASOS_REPRODUCIR:
  1. Abrir `pronto-client/src/pronto_clients/templates/debug_panel.html`.
  2. Ejecutar acciones de avance de orden, solicitud de cuenta, pago simulado, ticket soporte o promociones.
  3. Ver requests a endpoints inexistentes/legacy.
RESULTADO_ACTUAL:
  Esas acciones ya no llaman endpoints inexistentes; muestran mensajes informativos y redirigen conceptualmente al panel de empleados cuando aplica.
RESULTADO_ESPERADO:
  El panel debe usar solo rutas soportadas o eliminar/degradar acciones obsoletas.
UBICACION:
  - `pronto-client/src/pronto_clients/templates/debug_panel.html`
ESTADO: RESUELTO
SOLUCION:
  Se retiraron las llamadas a `/api/session/...`, `/api/debug/...`, `/api/support-tickets` y `/api/promotions` dentro del panel debug,
  reemplazándolas por mensajes `showStatus(...)` que informan que la acción fue retirada o debe hacerse desde el panel de empleados.
  Validación: `rg -n '/api/session/|/api/debug/|/api/support-tickets|/api/promotions' pronto-client/src/pronto_clients/templates/debug_panel.html` => sin resultados;
  verificación textual confirma presencia de los mensajes informativos nuevos.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
