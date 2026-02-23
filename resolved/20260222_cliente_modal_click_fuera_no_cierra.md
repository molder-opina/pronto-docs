ID: ERR-20260222-CLIENTE-MODAL-BACKDROP-CLOSE
FECHA: 2026-02-22
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: Modal de producto no cierra al hacer clic fuera del formulario
DESCRIPCION: En la página de cliente, el modal de producto se cierra con tecla ESC, pero no se cierra al hacer clic fuera del contenido (backdrop).
PASOS_REPRODUCIR:
1. Abrir menú de cliente.
2. Hacer clic en un producto para abrir modal.
3. Hacer clic fuera del formulario/modal.
RESULTADO_ACTUAL: El modal permanece abierto.
RESULTADO_ESPERADO: El modal debe cerrarse al hacer clic fuera, igual que al presionar ESC.
UBICACION: pronto-client/src/pronto_clients/templates/index.html
EVIDENCIA: Reporte directo del usuario durante validación visual.
HIPOTESIS_CAUSA: Falta de listener explícito en backdrop del modal legacy `#item-modal`.
ESTADO: RESUELTO
SOLUCION: Se agregó binding idempotente del listener de backdrop en `openProductModal` para cerrar cuando `event.target === modal` (overlay).
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-22
