ID: 20260303_admin_config_font_family_should_use_static_catalog
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: font_family_body y font_family_headings se editan como texto libre
DESCRIPCION: En `/admin/dashboard/config`, los parámetros `font_family_body` y `font_family_headings` se muestran como texto libre aunque deben seleccionarse desde un catálogo controlado de fuentes disponibles para la interfaz.
PASOS_REPRODUCIR:
1. Ingresar a `/admin/dashboard/config`.
2. Buscar `font`.
3. Editar `font_family_body` o `font_family_headings`.
RESULTADO_ACTUAL: La fuente se captura como texto libre.
RESULTADO_ESPERADO: La fuente debe editarse con un combo basado en un catálogo de fuentes disponible en contenido estático.
UBICACION: pronto-static/src/vue/employees/admin/components/config/ConfigItem.vue
EVIDENCIA: Solicitud de usuario indicando que las fuentes deben salir de un folder/catálogo seleccionable.
HIPOTESIS_CAUSA: El componente no tiene rama específica para parámetros `font_family_*` ni existe catálogo estático consumible por la vista.
ESTADO: RESUELTO
SOLUCION: Se creó el catálogo estático `src/static_content/assets/fonts/catalog.json` y `ConfigItem.vue` ahora lo consume para renderizar `font_family_body` y `font_family_headings` como combos controlados. La validación solo acepta familias presentes en ese catálogo.
COMMIT:
FECHA_RESOLUCION: 2026-03-03
