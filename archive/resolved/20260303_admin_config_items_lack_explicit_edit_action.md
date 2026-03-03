ID: ERR-20260303-ADMIN-CONFIG-ITEMS-LACK-EXPLICIT-EDIT-ACTION
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Parámetros de configuración no muestran botón explícito de editar por opción
DESCRIPCION: En `/admin/dashboard/config`, cada parámetro de negocio solo muestra la acción `Guardar`, lo que no comunica claramente que primero se debe entrar en modo edición por opción.
PASOS_REPRODUCIR:
1. Entrar a `/admin/dashboard/config`.
2. Revisar cualquier card de parámetro en la sección de negocio.
RESULTADO_ACTUAL: Cada opción muestra solo `Guardar` y no existe un botón explícito de `Editar` por parámetro.
RESULTADO_ESPERADO: Cada opción debe tener un botón visible de `Editar` para indicar claramente la intención de modificar ese parámetro antes de guardarlo.
UBICACION: pronto-static/src/vue/employees/admin/components/config/ConfigItem.vue, pronto-static/src/vue/employees/admin/views/config/SystemSettings.vue
EVIDENCIA: Captura del usuario mostrando tarjetas con solo `Guardar` a la derecha.
HIPOTESIS_CAUSA: El componente de configuración deja los inputs siempre editables o no expone un estado visual claro de edición por item.
ESTADO: RESUELTO
SOLUCION: `ConfigItem.vue` ahora renderiza cada parámetro en modo lectura por defecto y expone un botón explícito `Editar` por fila. Al entrar en edición se habilitan los controles del parámetro y aparecen las acciones `Cancelar` y `Guardar`, dejando más clara la intención de modificar cada opción de negocio.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
