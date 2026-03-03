ID: BUG-20260213-PLACEHOLDER-RESTAURANT-404
FECHA: 2026-02-13
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Placeholder de menú cliente apunta a ruta de restaurante inexistente y genera 404/ORB
DESCRIPCION: En el flujo de menú cliente, cuando un producto no tiene imagen, el frontend construye el placeholder con `restaurant_assets/icons/placeholder.png`. En restaurantes sin ese archivo (ej. `cafeteria-de-prueba`) se disparan 404 repetidos y mensajes OpaqueResponseBlocking.
PASOS_REPRODUCIR: 1) Abrir menú cliente en localhost:6080 con restaurante `cafeteria-de-prueba`. 2) Cargar productos sin `image_path`. 3) Revisar consola/red para `GET /assets/cafeteria-de-prueba/icons/placeholder.png`.
RESULTADO_ACTUAL: Respuesta 404 para placeholder de restaurante, múltiples reintentos y ruido en consola (NS_BINDING_ABORTED / OpaqueResponseBlocking).
RESULTADO_ESPERADO: Si no hay imagen de producto, usar placeholder global válido (`/assets/pronto/icons/placeholder.png`) sin 404.
UBICACION: pronto-static/src/vue/clients/modules/menu-flow.ts; pronto-static/src/vue/clients/modules/modal-manager.ts
EVIDENCIA: Traza de navegador compartida por usuario con 404 en `http://localhost:9088/assets/cafeteria-de-prueba/icons/placeholder.png`.
HIPOTESIS_CAUSA: Selector de fallback prioriza `restaurant_assets` sin verificar existencia del recurso y sin fallback preventivo en ruta inicial.
ESTADO: RESUELTO
SOLUCION: Se actualizó la resolución de imagen en módulos cliente para que, cuando `image_path` no esté presente, use directamente el placeholder global canónico (`/assets/pronto/icons/placeholder.png`) en lugar del placeholder por restaurante. Archivos corregidos: `menu-flow.ts` y `modal-manager.ts`.
COMMIT: N/A (cambios locales, sin commit solicitado)
FECHA_RESOLUCION: 2026-02-13
