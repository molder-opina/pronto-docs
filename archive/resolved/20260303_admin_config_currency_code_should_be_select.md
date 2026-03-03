ID: 20260303_admin_config_currency_code_should_be_select
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: currency_code se edita como texto libre en configuración administrativa
DESCRIPCION: En `/admin/dashboard/config`, el parámetro `currency_code` se muestra como campo libre aunque debe seleccionarse desde un catálogo controlado de monedas.
PASOS_REPRODUCIR:
1. Ingresar a `/admin/dashboard/config`.
2. Buscar `currency`.
3. Editar el parámetro `currency_code`.
RESULTADO_ACTUAL: El valor de moneda se captura como texto libre.
RESULTADO_ESPERADO: El valor debe editarse mediante un combo con monedas predefinidas.
UBICACION: pronto-static/src/vue/employees/admin/components/config/ConfigItem.vue
EVIDENCIA: Solicitud de usuario con captura del parámetro `currency_code` mostrando valor `MXN` sin selector dedicado.
HIPOTESIS_CAUSA: El componente solo contempla toggles, JSON, un select hardcodeado para `items_per_page`, color picker y input genérico, sin rama específica para moneda.
ESTADO: RESUELTO
SOLUCION: Se agregó una rama específica para `currency_code` en `ConfigItem.vue` que renderiza un `select` con monedas canónicas (`MXN`, `USD`, `EUR`, `CAD`), normaliza el valor entrante a ISO uppercase y valida que solo se guarden opciones del catálogo permitido.
COMMIT:
FECHA_RESOLUCION: 2026-03-03
