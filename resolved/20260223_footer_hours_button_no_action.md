ID: ERR-20260223-FOOTER-HOURS-BUTTON-NO-ACTION
FECHA: 2026-02-23
PROYECTO: pronto-static / pronto-client
SEVERIDAD: media
TITULO: Botón "Ver horarios de atención" sin acción en cliente
DESCRIPCION: El botón del footer `#footer-hours-btn` no ejecutaba ninguna acción visible al hacer clic en la página de cliente.
PASOS_REPRODUCIR:
1. Abrir cliente en menú principal.
2. Hacer clic en "Ver horarios de atención".
RESULTADO_ACTUAL: No ocurre acción visible.
RESULTADO_ESPERADO: Debe abrir modal de horarios si existe o mostrar claramente la sección de horarios.
UBICACION: pronto-static/src/vue/clients/modules/client-base.ts
EVIDENCIA: Reporte directo de usuario indicando que el botón no responde.
HIPOTESIS_CAUSA: Faltaba binding del evento click para `#footer-hours-btn` en el runtime principal de clientes.
ESTADO: RESUELTO
SOLUCION: Se implementó `bindBusinessHoursButton()` en `client-base.ts` y se ejecuta en `initClientBase()`. El handler intenta abrir modal de horarios (`showBusinessHoursModal`/`openBusinessHoursModal` o `#business-hours-modal`) y, si no existe modal, aplica fallback visible con scroll y resaltado temporal de `#business-hours-display`.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
