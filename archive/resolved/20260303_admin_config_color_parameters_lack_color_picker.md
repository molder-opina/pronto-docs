ID: ERR-20260303-ADMIN-CONFIG-COLOR-PARAMETERS-LACK-COLOR-PICKER
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Parámetros de color en configuración no muestran selector visual de color
DESCRIPCION: En `/admin/dashboard/config`, los parámetros de color como `brand_color_primary` y `brand_color_secondary` no ofrecen un color picker al editarlos, obligando al usuario a trabajar solo con valores hexadecimales.
PASOS_REPRODUCIR:
1. Entrar a `/admin/dashboard/config`.
2. Buscar parámetros de color.
3. Intentar modificarlos.
RESULTADO_ACTUAL: Los parámetros se editan como texto plano sin selector visual de color.
RESULTADO_ESPERADO: Los parámetros de color deben ofrecer un color picker al modificarlos, manteniendo el valor hexadecimal visible.
UBICACION: pronto-static/src/vue/employees/admin/components/config/ConfigItem.vue
EVIDENCIA: Captura del usuario mostrando `Brand Color Primary` y `Brand Color Secondary` sin selector visual.
HIPOTESIS_CAUSA: El componente reutiliza el input genérico de texto para todos los tipos string y no detecta claves/valores de color para renderizar un control especializado.
ESTADO: RESUELTO
SOLUCION: `ConfigItem.vue` ahora detecta parámetros de color y, en modo edición, renderiza un `input type=\"color\"` sincronizado con el valor hexadecimal visible. Cada opción mantiene el color picker y el campo de texto para editar/confirmar el valor con mayor claridad.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
