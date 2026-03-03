ID: ERR-20260303-ADMIN-SYSTEM-SETTINGS-FLAT-MAP-SHAPE-NOT-RENDERED
FECHA: 2026-03-03
PROYECTO: pronto-static, pronto-employees
SEVERIDAD: alta
TITULO: Vista de Configuración en admin no renderiza parámetros cuando /admin/api/config devuelve mapa plano
DESCRIPCION: Reapertura relacionada con `ERR-20260303-ADMIN-SYSTEM-SETTINGS-NOT-LOADING`. La vista `/admin/dashboard/config` queda en estado vacío aun con parámetros existentes porque `SystemSettings.vue` solo interpreta respuestas con `data.configs[]` o `configs[]`, mientras en runtime `/admin/api/config` está devolviendo un mapa plano de llaves y valores dentro de `data`.
PASOS_REPRODUCIR:
1. Ingresar como admin en `/admin/dashboard/config`.
2. Observar que aparece `Sin coincidencias` con el buscador vacío.
3. Inspeccionar la respuesta de `/admin/api/config` y verificar que contiene `data` como objeto plano en lugar de `data.configs`.
RESULTADO_ACTUAL: La vista no muestra ningún parámetro del sistema.
RESULTADO_ESPERADO: La vista debe renderizar los parámetros aunque el backend/proxy entregue un mapa plano de configuración.
UBICACION: pronto-static/src/vue/employees/admin/views/config/SystemSettings.vue
EVIDENCIA: Validación runtime en `/admin/dashboard/config` y payload de `/admin/api/config` con llaves como `brand_color_primary`, `restaurant_name`, `tax_rate`, etc. dentro de `data`.
HIPOTESIS_CAUSA: El frontend quedó acoplado a un shape antiguo (`configs[]`) y no normaliza el contrato plano actualmente expuesto en la consola admin.
ESTADO: RESUELTO
SOLUCION: Se corrigió el endpoint SSR de `pronto-employees` para que `/admin/api/config` use el contrato canónico de `get_all_system_settings()` y devuelva `data.configs[]` con metadata completa. Además, `SystemSettings.vue` quedó con normalización defensiva para aceptar tanto el contrato canónico como el mapa plano legacy si reaparece, y `ConfigItem.vue` admite IDs string o numéricos.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
