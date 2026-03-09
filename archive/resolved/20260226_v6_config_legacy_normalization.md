---
ID: V6_CONFIG_LEGACY_NORMALIZATION
FECHA: 20260226
PROYECTO: pronto-libs / pronto-api / pronto-scripts
SEVERIDAD: Crítica
TITULO: Inconsistencia estructural en gestión de parámetros (V6 Zero Legacy)
DESCRIPCION: Existen múltiples fuentes de verdad y convenciones de nombres inconsistentes para la configuración del sistema. Se detectó uso de tablas duplicadas (pronto_business_config vs pronto_system_settings), uso de llaves en UPPERCASE (RESTAURANT_NAME) en runtime, y falta de aislamiento de privilegios entre los roles 'admin' y 'system' para la modificación de parámetros técnicos vs. de negocio. Además, parámetros críticos como intervalos de polling y tiempos estimados están hardcodeados en el frontend.
PASOS_REPRODUCIR:
1. Revisar `pronto-api/src/api_app/routes/employees/config.py` y observar lectura de `RESTAURANT_NAME`.
2. Revisar `pronto-scripts/bin/python/create_test_data.py` y observar creación de tabla legacy `pronto_business_config`.
3. Intentar acceder a `/api/config` con rol `system` y observar que puede estar bloqueado o permitir edición de parámetros de negocio.
4. Inspeccionar `pronto-static/src/vue/employees/App.vue` y observar `interval = 2000` hardcodeado.
RESULTADO_ACTUAL: Sistema frágil, difícil de escalar, con deuda técnica de nombres (UPPERCASE) y riesgo de seguridad/operación por falta de RBAC granular en configuraciones.
RESULTADO_ESPERADO: Sistema parametrizado al 100%, con contrato único (lowercase), separación estricta de responsabilidades (Namespace system.*) y eliminación física de cualquier rastro legacy.
UBICACION:
- pronto-api/src/api_app/routes/employees/config.py
- pronto-scripts/bin/python/create_test_data.py
- pronto-scripts/bin/python/validate_and_seed.py
- pronto-static/src/vue/employees/App.vue
- pronto-static/src/vue/employees/store/orders.ts
- pronto-client/src/pronto_clients/app.py
HIPOTESIS_CAUSA: Migración incompleta hacia el estándar V6, permitiendo la coexistencia de patrones antiguos por "compatibilidad" temporal que se ha vuelto permanente.
ESTADO: PENDIENTE
---
