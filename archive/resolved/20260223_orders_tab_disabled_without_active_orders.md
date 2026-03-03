ID: ERR-20260223-ORDERS-TAB-ACTIVE-WITHOUT-ORDERS
FECHA: 2026-02-23
PROYECTO: pronto-static / pronto-client
SEVERIDAD: media
TITULO: Tab Órdenes activo sin órdenes activas
DESCRIPCION: El tab `Órdenes` se mostraba habilitado aunque no existían órdenes activas, generando una vista vacía al hacer clic.
PASOS_REPRODUCIR:
1. Abrir cliente sin sesión/órdenes activas.
2. Hacer clic en tab `Órdenes`.
RESULTADO_ACTUAL: El tab está habilitado y puede mostrar sección vacía.
RESULTADO_ESPERADO: Debe permanecer deshabilitado sin órdenes activas y habilitarse solo cuando existan.
UBICACION: pronto-static/src/vue/clients/modules/client-base.ts; pronto-client/src/pronto_clients/templates/base.html
EVIDENCIA: Reporte de usuario en conversación.
HIPOTESIS_CAUSA: No existía control de estado habilitado/deshabilitado del tab según `orders` activos.
ESTADO: RESUELTO
SOLUCION: Se implementó `setOrdersTabState(enabled, count)` en `client-base.ts`, enlazado a `checkActiveOrdersGlobal`, `showMiniTrackerGlobal` y `updateMiniTrackerGlobal` para habilitar/deshabilitar dinámicamente el tab y su badge. Se añadió guard para impedir navegación a órdenes cuando está deshabilitado y estilo visual `view-tab--disabled`.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
