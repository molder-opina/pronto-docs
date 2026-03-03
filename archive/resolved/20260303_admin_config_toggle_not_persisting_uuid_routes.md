ID: 20260303_admin_config_toggle_not_persisting_uuid_routes
FECHA: 2026-03-03
PROYECTO: pronto-employees, pronto-libs
SEVERIDAD: alta
TITULO: Los toggles de configuración en /admin no persisten al guardar usando IDs UUID
DESCRIPCION: Al cambiar un parámetro booleano como `orders.show_estimated_time` desde `/admin/dashboard/config`, la UI envía el guardado al endpoint `/admin/api/config/<uuid>` pero el backend SSR de `pronto-employees` lo trata como llave legacy en lugar de ID canónico, provocando error de base de datos y evitando que el cambio se refleje en `pronto_system_settings`.
PASOS_REPRODUCIR:
1. Ingresar a `/admin/dashboard/config`.
2. Cambiar el toggle `show_estimated_time`.
3. Guardar la opción.
RESULTADO_ACTUAL: El endpoint responde `500 Error de base de datos` y el valor en `pronto_system_settings` permanece sin cambio.
RESULTADO_ESPERADO: El endpoint debe actualizar la fila canónica por su UUID y el valor debe persistir en base de datos.
UBICACION: pronto-employees/src/pronto_employees/routes/api/config.py, pronto-libs/src/pronto_shared/services/business_config_service.py
EVIDENCIA: Verificación end-to-end con Playwright devolviendo `500` en `/admin/api/config/3c535777-6620-45e1-9551-ba65c0ef0a6a`; logs de `pronto-employees-1` muestran inserción errónea usando el UUID como `key` y `updated_by` UUID sobre columna integer.
HIPOTESIS_CAUSA: La ruta SSR decide entre ID y llave con `isdigit()`, incompatible con PK UUID. Además `updated_by` recibe el `employee_id` UUID sin coerción para un esquema que aún usa columna integer.
ESTADO: RESUELTO
SOLUCION: `pronto-employees` ahora detecta IDs UUID y actualiza por la fila canónica en lugar de caer al fallback legacy. En `business_config_service` se normaliza `updated_by` para no escribir UUIDs en una columna integer legacy. Se validó end-to-end cambiando `orders.show_estimated_time` a `false` y confirmando el cambio en PostgreSQL, luego restaurándolo a `true`.
COMMIT:
FECHA_RESOLUCION: 2026-03-03
