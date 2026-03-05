ID: ERR-CLIENT-CART-BLOCKED-BY-PROFILE-OVERLAY-20260305
FECHA: 2026-03-05
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: Botón de carrito bloqueado por overlay del modal de perfil
DESCRIPCION: En cliente `:6080`, el botón de carrito del header no recibe click cuando el modal de perfil/login está activo porque `profile-modal-overlay` intercepta eventos.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6080/?view=profile&tab=login`
2. Intentar click en botón de carrito del header sin cerrar modal
RESULTADO_ACTUAL: El click es interceptado por `.profile-modal-overlay`.
RESULTADO_ESPERADO: El botón del carrito en header debe ser clickeable.
UBICACION: pronto-client/src/pronto_clients/templates/base.html
EVIDENCIA: Diagnóstico `elementFromPoint` sobre botón de carrito devuelve `DIV.profile-modal-overlay`; Playwright reporta `intercepts pointer events`.
HIPOTESIS_CAUSA: Overlay del modal cubre toda la pantalla incluyendo header.
ESTADO: RESUELTO
SOLUCION: Se elevó el `z-index` del header (`.header`) por encima del modal de perfil para que los botones del header (incluyendo carrito) sigan recibiendo eventos de click aun con `#profile-modal.active`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
