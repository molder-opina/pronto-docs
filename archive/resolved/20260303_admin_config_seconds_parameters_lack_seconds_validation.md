ID: ERR-20260303-ADMIN-CONFIG-SECONDS-PARAMETERS-LACK-SECONDS-VALIDATION
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Parámetros de segundos en configuración no validan valores coherentes
DESCRIPCION: En `/admin/dashboard/config`, parámetros como `checkout_prompt_duration_seconds` y `client.checkout.redirect_seconds` permiten edición numérica sin una validación específica para segundos enteros coherentes con esa unidad.
PASOS_REPRODUCIR:
1. Entrar a `/admin/dashboard/config`.
2. Editar un parámetro de segundos.
3. Introducir valores no coherentes con segundos (decimales, vacíos o fuera de rango razonable).
RESULTADO_ACTUAL: El control no comunica ni impone una validación específica de segundos.
RESULTADO_ESPERADO: Los parámetros de segundos deben validarse como enteros en segundos, con límites razonables y feedback claro.
UBICACION: pronto-static/src/vue/employees/admin/components/config/ConfigItem.vue
EVIDENCIA: Captura del usuario mostrando parámetros `*_seconds` sin validación especializada visible.
HIPOTESIS_CAUSA: El componente trata estos parámetros como numéricos genéricos y no detecta semánticamente llaves/unidades de segundos para validar enteros y rango.
ESTADO: RESUELTO
SOLUCION: `ConfigItem.vue` ahora detecta parámetros cuyo `config_key` o `unit` corresponden a segundos y los valida específicamente como enteros entre `1` y `3600`, forzando `step=1` y mostrando feedback visible cuando el valor no representa segundos válidos.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
