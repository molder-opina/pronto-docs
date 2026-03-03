ID: 20260213_menu_uuid_click_and_placeholder_404
FECHA: 2026-02-13
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: Click en tarjeta de menú falla con UUID y placeholders de restaurante generan 404
DESCRIPCION: En clientes, los cards de menú reciben `data-item-id` con UUID (string) pero el flujo convierte a número, resultando en `NaN` y evitando abrir modal/quick-add. Adicionalmente, cuando falta `assets/<restaurant>/icons/placeholder.png`, el frontend no cae a un placeholder global válido y dispara múltiples 404.
PASOS_REPRODUCIR: 1) Abrir menú de clientes en localhost:6080. 2) Click en imagen o contenido de una tarjeta con `data-item-id` UUID. 3) Ver log `[MenuFlow] Card clicked, itemId: NaN`. 4) Ver requests 404 a `http://localhost:9088/assets/cafeteria-de-prueba/icons/placeholder.png`.
RESULTADO_ACTUAL: El modal no abre para tarjetas afectadas, quick-add puede fallar con IDs no numéricos y se repiten errores de carga de imagen placeholder.
RESULTADO_ESPERADO: El modal y quick-add funcionan con IDs numéricos o UUID, y toda imagen faltante cae a placeholder global existente sin 404 repetitivos.
UBICACION: pronto-static/src/vue/clients/modules/menu-flow.ts; pronto-static/src/vue/clients/modules/modal-manager.ts; pronto-static/src/vue/clients/modules/menu-shortcuts.ts; pronto-static/src/vue/clients/modules/cart-persistence.ts
EVIDENCIA: Consola: `__CLICK_DEBUG__PRONTO__ ... attrValue: "33f0aad8-..."` y `[MenuFlow] Card clicked, itemId: NaN`; Network: 404 en `/assets/cafeteria-de-prueba/icons/placeholder.png`.
HIPOTESIS_CAUSA: Asunción rígida de ID numérico en event handlers/filtros, más construcción de URL de placeholder dependiente de assets por restaurante sin fallback canónico.
ESTADO: RESUELTO
SOLUCION: Se normalizó el manejo de IDs a `string|number` en menú/atajos/carrito para evitar conversiones a NaN. Se reemplazó el manejo inline de errores de imagen en cards por listeners que aplican fallback a `/assets/pronto/icons/placeholder.png` una sola vez. En modal también se agregó fallback de dos pasos con prevención de loops.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-13
