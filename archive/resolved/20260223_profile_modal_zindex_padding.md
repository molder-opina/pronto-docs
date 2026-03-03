ID: ERR-20260223-PROFILE-MODAL-ZINDEX-PADDING
FECHA: 2026-02-23
PROYECTO: pronto-client / pronto-static
SEVERIDAD: alta
TITULO: Modal flotante de login/registro queda detrás del menú y con formulario sin padding interno
DESCRIPCION: Al abrir el modal de perfil para login/registro desde el flujo de checkout, el panel se renderiza por detrás del menú sticky y el formulario se ve pegado a las orillas, afectando usabilidad.
PASOS_REPRODUCIR:
1. Abrir cliente en http://localhost:6080.
2. Activar modal de login/registro desde checkout.
3. Observar superposición con tabs sticky y espaciado interno.
RESULTADO_ACTUAL: Modal detrás de capas del menú y campos pegados a bordes.
RESULTADO_ESPERADO: Modal por encima de toda UI y formulario con padding/márgenes internos cómodos.
UBICACION: pronto-client/src/pronto_clients/templates/base.html
EVIDENCIA: Captura compartida por usuario en la conversación actual.
HIPOTESIS_CAUSA: Bloque CSS final (`Profile Modal Styles - FORCED LOCATION`) define `z-index: 2000` y layout interno sin padding para `.profile-view`.
ESTADO: RESUELTO
SOLUCION: Se actualizó el bloque CSS final para priorizar superposición y espaciado: `profile-modal` usa `z-index: 11050 !important`, `profile-modal-content` agrega `max-height` + `overflow-y`, y `.profile-view` aplica padding interno con ajuste responsive móvil. Además, en modo compacto (`profile-modal--compact`) se mantiene `padding: 0` para no romper el dropdown de usuario logueado.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
