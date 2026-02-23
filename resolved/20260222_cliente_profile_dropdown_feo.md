ID: ERR-20260222-CLIENTE-PROFILE-DROPDOWN-UGLY
FECHA: 2026-02-22
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Menú de perfil al hacer clic en avatar se ve descompuesto y poco usable
DESCRIPCION: Al hacer clic en la imagen/avatar de perfil en cliente, el desplegable aparece con layout roto (panel grande y sin estilo consistente), en lugar de un dropdown limpio.
PASOS_REPRODUCIR:
1. Abrir página de cliente con sesión iniciada.
2. Hacer clic en avatar de perfil.
RESULTADO_ACTUAL: Menú visualmente descompuesto/feo, con jerarquía y posición inconsistentes.
RESULTADO_ESPERADO: Desplegable compacto, alineado al avatar, legible y consistente con el tema.
UBICACION: pronto-static/src/vue/clients/modules/client-profile.ts; pronto-static/src/static_content/assets/css/clients/menu-updates.css
EVIDENCIA: Captura del usuario mostrando panel de perfil desalineado.
HIPOTESIS_CAUSA: Conflictos de CSS global entre modal legacy y overrides de runtime sin un modo visual específico para usuario logueado.
ESTADO: RESUELTO
SOLUCION: Se añadió modo `profile-modal--compact` en JS para sesión logueada y estilos forzados para dropdown visual consistente (desktop) y fallback tipo sheet en mobile. Se persistió el estilo en `pronto-client/templates/base.html` (archivo trackeado) y se aplicó cache-busting en `index.html` para evitar estilos viejos en navegador.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-22
