ID: ERR-20260223-SUPPORT-LINK-NO-ACTION
FECHA: 2026-02-23
PROYECTO: pronto-static / pronto-client
SEVERIDAD: media
TITULO: Link de soporte técnico no abre modal en cliente
DESCRIPCION: El botón/link `Soporte técnico` en el footer no mostraba ninguna acción al hacer clic.
PASOS_REPRODUCIR:
1. Abrir cliente.
2. Clic en `Soporte técnico` del footer.
RESULTADO_ACTUAL: No abre modal ni hay interacción visible.
RESULTADO_ESPERADO: Debe abrir modal de soporte y permitir cerrar/enviar formulario.
UBICACION: pronto-static/src/vue/clients/modules/client-profile.ts
EVIDENCIA: Reporte del usuario en conversación.
HIPOTESIS_CAUSA: Funciones `setupSupportModal`, `openSupportModal` y `closeSupportModal` quedaron como stubs vacíos.
ESTADO: RESUELTO
SOLUCION: Se implementó wiring completo del modal de soporte: bind de `[data-open-support]`, cierre por botón/overlay/Escape, submit del formulario con validación básica y notificación de éxito, más reset/cierre del modal.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
