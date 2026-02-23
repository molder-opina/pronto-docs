ID: ERR-20260222-CLIENT-WAITER-BUTTON-REQUIRES-SESSION
FECHA: 2026-02-22
PROYECTO: pronto-client, pronto-static
SEVERIDAD: alta
TITULO: Campana de llamar al mesero disponible sin sesión activa
DESCRIPCION:
La campana de "Llamar al mesero" estaba habilitada sin sesión activa de cliente (`pronto-session-id`), y al intentar usarla mostraba error genérico de llamada fallida.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6080/` sin sesión de mesa activa.
2. Hacer clic en la campana de "Llamar al mesero".
RESULTADO_ACTUAL:
El botón permitía interacción y mostraba "Error al llamar al mesero. Intenta de nuevo.".
RESULTADO_ESPERADO:
La campana debe permanecer deshabilitada hasta iniciar sesión de mesa, y nunca intentar el endpoint si no hay sesión.
UBICACION:
- pronto-static/src/vue/clients/modules/client-base.ts
- pronto-static/src/static_content/assets/js/clients/base.js
- pronto-client/src/pronto_clients/templates/base.html
EVIDENCIA:
Validación Playwright: botón `waiter-btn` deshabilitado sin sesión y `window.callWaiter()` devuelve notificación info sin request fallido.
HIPOTESIS_CAUSA:
Faltaba validación previa de sesión en `callWaiter()` y sincronización de estado UI del botón con `pronto-session-id`.
ESTADO: RESUELTO
SOLUCION:
Se implementó `refreshWaiterButtonState` para deshabilitar/rehabilitar la campana según sesión activa, se agregó guard clause en `callWaiter()` cuando no hay sesión, y se aplicó estilo visual `waiter-btn--disabled`. Se replicó en bundle runtime servido (`base.js`) y se versionó query param para evitar caché del bundle viejo.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-22
