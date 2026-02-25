ID: ERR-20260223-REGISTER-FORM-LAYOUT-INCOMPLETE
FECHA: 2026-02-23
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: Formulario de registro no se visualiza completo en modal de perfil
DESCRIPCION: En el modal de perfil (vista no autenticada), el tab Registrarse mostraba layout incompleto/ajustado, con scroll y márgenes que afectaban visibilidad de campos y CTA.
PASOS_REPRODUCIR:
1. Abrir modal de perfil en cliente.
2. Cambiar al tab Registrarse.
3. Revisar visualización completa del formulario.
RESULTADO_ACTUAL: Visual incompleta y con scroll poco usable.
RESULTADO_ESPERADO: Formulario completo, padding consistente, scroll interno limpio y CTA visible.
UBICACION: pronto-client/src/pronto_clients/templates/base.html
EVIDENCIA: Captura compartida por usuario.
HIPOTESIS_CAUSA: Configuración de overflow/altura del modal y paddings insuficientes en vista no autenticada.
ESTADO: RESUELTO
SOLUCION: Se ajustó CSS del modal de perfil para usar layout columnar, scroll interno dedicado a `#profile-not-logged-in`, padding lateral superior, `scrollbar-gutter` estable, espaciado de header/tabs/form y margen del CTA principal para mejorar lectura y completar el formulario visualmente.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
