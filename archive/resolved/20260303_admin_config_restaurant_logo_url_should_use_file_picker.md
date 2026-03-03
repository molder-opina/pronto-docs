ID: 20260303_admin_config_restaurant_logo_url_should_use_file_picker
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: restaurant_logo_url se edita como texto libre en configuración administrativa
DESCRIPCION: En `/admin/dashboard/config`, el parámetro `restaurant_logo_url` se muestra como texto editable libre aunque debe seleccionarse mediante file picker y colocar la ruta resultante del upload de branding.
PASOS_REPRODUCIR:
1. Ingresar a `/admin/dashboard/config`.
2. Buscar `logo`.
3. Editar `restaurant_logo_url`.
RESULTADO_ACTUAL: La ruta del logo se captura manualmente como texto libre.
RESULTADO_ESPERADO: Debe existir un file picker que suba el archivo y coloque la ruta resultante.
UBICACION: pronto-static/src/vue/employees/admin/components/config/ConfigItem.vue
EVIDENCIA: Solicitud de usuario con captura del parámetro `restaurant_logo_url`.
HIPOTESIS_CAUSA: El componente no tiene rama específica para el logo ni integra el endpoint canónico `/api/branding/logo`.
ESTADO: RESUELTO
SOLUCION: `ConfigItem.vue` ahora detecta `restaurant_logo_url`, muestra un file picker y sube la imagen al endpoint canónico `/api/branding/logo`. Al terminar, coloca la ruta devuelta por el backend en el campo y la refleja en la configuración.
COMMIT:
FECHA_RESOLUCION: 2026-03-03
