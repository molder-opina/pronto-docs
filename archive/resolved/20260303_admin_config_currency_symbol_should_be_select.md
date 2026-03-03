ID: 20260303_admin_config_currency_symbol_should_be_select
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: currency_symbol se edita como texto libre en configuración administrativa
DESCRIPCION: En `/admin/dashboard/config`, el parámetro `currency_symbol` se muestra como texto editable libre aunque debe seleccionarse desde un catálogo controlado de símbolos válidos.
PASOS_REPRODUCIR:
1. Ingresar a `/admin/dashboard/config`.
2. Buscar `symbol`.
3. Editar el parámetro `currency_symbol`.
RESULTADO_ACTUAL: El símbolo de moneda se captura como texto libre.
RESULTADO_ESPERADO: El símbolo debe editarse mediante un combo con opciones predefinidas.
UBICACION: pronto-static/src/vue/employees/admin/components/config/ConfigItem.vue
EVIDENCIA: Solicitud de usuario con captura del parámetro `currency_symbol` mostrando valor `$` sin selector dedicado.
HIPOTESIS_CAUSA: El componente solo tiene rama específica para `currency_code`; `currency_symbol` sigue cayendo en el input genérico.
ESTADO: RESUELTO
SOLUCION: Se agregó una rama específica para `currency_symbol` en `ConfigItem.vue` que renderiza un `select` con símbolos canónicos (`$`, `EUR`, `CAD`), normaliza el valor entrante y valida que solo se guarden opciones del catálogo permitido.
COMMIT:
FECHA_RESOLUCION: 2026-03-03
