ID: ERR-20260223-ORDERS-TAB-BLANK-AFTER-CONFIRM
FECHA: 2026-02-23
PROYECTO: pronto-static / pronto-client
SEVERIDAD: alta
TITULO: Tab Órdenes vacío tras confirmar pedido aunque existe orden activa
DESCRIPCION: Después de confirmar orden y activar el tab Órdenes, la vista quedaba en blanco aunque el mini tracker mostraba pedido activo.
PASOS_REPRODUCIR:
1) Confirmar pedido desde Detalles.
2) Ir a tab Órdenes.
RESULTADO_ACTUAL: Tab Órdenes sin tarjetas/listado de órdenes.
RESULTADO_ESPERADO: Tab Órdenes muestra tarjetas con productos, estatus y total de órdenes activas.
UBICACION: pronto-static/src/vue/clients/modules/client-base.ts
EVIDENCIA: Captura con tab Órdenes activo + badge de órdenes + área en blanco.
HIPOTESIS_CAUSA: Faltaba renderer/binding de lista de órdenes en flujo TS del cliente; solo mini tracker hacía polling.
ESTADO: RESUELTO
SOLUCION: Se agregó `renderActiveOrders` + `refreshActiveOrders`, exposición global `window.refreshActiveOrders`, recarga al entrar a `switchView('orders')` y sincronización de render durante polling de mini tracker.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
