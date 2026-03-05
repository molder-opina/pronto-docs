ID: 20260304_client_login_modal_low_contrast
FECHA: 2026-03-04
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: Modal de login cliente 6080 con bajo contraste y legibilidad deficiente
DESCRIPCION: El modal de acceso (login/registro) en `http://localhost:6080` muestra texto y labels con contraste insuficiente sobre fondo claro, lo que dificulta leer encabezado y campos del formulario.
PASOS_REPRODUCIR: 1) Abrir cliente en `:6080` 2) Abrir modal de perfil/login 3) Revisar encabezado, labels y tabs del bloque no autenticado.
RESULTADO_ACTUAL: Título/subtítulo y etiquetas de formulario se perciben muy tenues o casi invisibles por mezcla de variables de tema oscuro con fondo blanco del modal.
RESULTADO_ESPERADO: El modal de login debe mantener contraste AA visualmente claro en título, labels, tabs, inputs y acciones.
UBICACION: pronto-client/src/pronto_clients/templates/base.html
EVIDENCIA: Captura aportada por usuario mostrando texto deslavado en modal de login.
HIPOTESIS_CAUSA: El modal usa `background: white` pero hereda variables globales dark (`--text`, `--muted`, `--background`) pensadas para fondo oscuro.
ESTADO: RESUELTO
SOLUCION: Se aplicaron overrides CSS scopeados a `#profile-not-logged-in` para forzar paleta clara legible en encabezado, tabs, labels, inputs, foco y link de recuperación dentro del modal de login, sin alterar el modal compacto de usuario autenticado.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-04
