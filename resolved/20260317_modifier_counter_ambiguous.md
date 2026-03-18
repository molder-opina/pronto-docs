ID: ERR-20260317-002
FECHA: 2026-03-17
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Contador de aditamientos no indica claramente el mínimo requerido
DESCRIPCION:
En el modal de detalle de producto, el contador de aditamientos muestra formato "X/Y" (ej: "0/3").
Cuando hay un mínimo requerido (min_selection > 0 o is_required = true), el contador es ambiguo.
El usuario puede interpretar "0/3" como "0 de 3 máximo permitido" cuando en realidad significa "0 seleccionados, mínimo requerido: 3".
PASOS_REPRODUCIR:
1. Abrir un producto con aditamientos que tienen min_selection > 0
2. Observar el contador de selección (ej: "0/3")
3. El contador no indica claramente que 3 es el mínimo requerido
RESULTADO_ACTUAL:
El contador muestra "0/3" sin indicar si 3 es el mínimo o el máximo.
RESULTADO_ESPERADO:
El contador debería indicar claramente cuando hay un mínimo requerido, por ejemplo:
- "0/3 (mínimo: 3)" o "0/3 seleccionados (mínimo requerido)"
- "3/3" cuando se cumple el mínimo
UBICACION:
pronto-static/src/vue/clients/components/menu/ProductDetailModal.vue:462, 546
EVIDENCIA:
Líneas 462 y 546 muestran formato "X/Y" sin contexto de mínimo requerido.
HIPOTESIS_CAUSA:
Falta una función helper que formatee el contador con información clara del mínimo requerido.
ESTADO: RESUELTO
SOLUCION:
Agregadas funciones helper para formatear el contador de selección:
- getGroupMinSelection(): Obtiene el mínimo requerido de un grupo
- getComponentGroupMinSelection(): Obtiene el mínimo requerido de un grupo de componentes
- formatSelectionCounter(): Formatea el contador mostrando "mín: X" cuando hay un mínimo > 0
- formatComponentSelectionCounter(): Formatea el contador para componentes

Lógica de formato:
- Si min = max (ej: 1/1): Muestra solo "1/1"
- Si min > 0 (ej: 0/5 con min=3): Muestra "0/5 (mín: 3)"
- Si min = 0 (opcional): Muestra solo "0/5"

Actualizados templates para usar las nuevas funciones en:
- Líneas 461-464: Contador de grupos de modificación base
- Líneas 564-566: Contador de componentes
COMMIT: pendiente
FECHA_RESOLUCION: 2026-03-17
NOTAS:
- Actualizado script pronto-scripts/init/sql/40_seeds/generate_modifiers.py con datos de prueba que demuestran varios escenarios de min/max selection
- Se agregaron casos como: min=3 max=5 (requiere mínimo de 3), min=0 max=5 (opcional hasta 5), min=1 max=1 (exactamente 1)
- Actualizado 0340__modifiers.sql con datos de prueba reales generados desde el script Python
