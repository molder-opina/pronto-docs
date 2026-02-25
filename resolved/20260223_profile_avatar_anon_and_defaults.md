ID: ERR-20260223-PROFILE-AVATAR-ANON-DEFAULTS
FECHA: 2026-02-23
PROYECTO: pronto-client / pronto-static
SEVERIDAD: media
TITULO: Avatar de perfil no distingue estado anónimo y no permite seleccionar icono por defecto al autenticarse
DESCRIPCION: El botón de perfil muestra un icono no alineado al estado de sesión; se requiere avatar anónimo blanco/negro cuando no hay sesión y, tras autenticarse, asignar un icono por defecto editable desde perfil.
PASOS_REPRODUCIR:
1. Abrir cliente sin sesión.
2. Observar icono del botón perfil.
3. Iniciar sesión/registrarse.
4. Intentar cambiar icono por defecto desde perfil.
RESULTADO_ACTUAL: No existe separación visual consistente entre anónimo/autenticado ni selector de iconos por defecto.
RESULTADO_ESPERADO: Sin sesión: icono anónimo blanco/negro. Con sesión: icono por defecto asignado y selector de iconos en perfil.
UBICACION: pronto-client/src/pronto_clients/templates/base.html; pronto-static/src/vue/clients/modules/client-profile.ts
EVIDENCIA: Solicitud y captura compartida por usuario en conversación.
HIPOTESIS_CAUSA: Flujo actual solo usa `default-avatar.png` de forma genérica y no expone UI para selección de icono por defecto.
ESTADO: RESUELTO
SOLUCION: Se implementó set de iconos SVG embebidos en `client-profile.ts` con dos comportamientos: (1) avatar anónimo blanco/negro para estado sin sesión, (2) avatar por defecto para usuario autenticado con selector (`profile-avatar-picker`) en el modal de perfil. La selección persiste en `localStorage` (`pronto-profile-icon`) y se refleja en encabezado y modal.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
