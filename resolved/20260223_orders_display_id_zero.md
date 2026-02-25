ID: ERR-20260223-ORDERS-DISPLAY-ID-ZERO
FECHA: 2026-02-23
PROYECTO: pronto-static / pronto-client
SEVERIDAD: alta
TITULO: Órdenes activas se muestran como #0 por coerción numérica de ID UUID
DESCRIPCION: El tracker y el tab de órdenes mostraban múltiples órdenes como `Orden #0`, generando confusión y percepción de duplicados.
PASOS_REPRODUCIR:
1) Confirmar pedidos en sesión activa.
2) Abrir tab Órdenes o mini-tracker.
3) Observar que los pedidos aparecen como `Orden #0`.
RESULTADO_ACTUAL: IDs visibles de orden muestran `#0` aunque la orden existe y fue creada correctamente.
RESULTADO_ESPERADO: Mostrar identificador de orden estable y no ambiguo (order_number/display/public id o fallback UUID corto), nunca `#0` por parseo.
UBICACION: pronto-static/src/vue/clients/modules/client-base.ts
EVIDENCIA: Capturas del usuario con múltiples tarjetas `Orden #0` y selector del mini-tracker con entradas `Orden #0` repetidas.
HIPOTESIS_CAUSA: Conversión `Number(order.id/order_id)` en frontend; con UUID la conversión falla y cae a `0`.
ESTADO: RESUELTO
SOLUCION: Se eliminó coerción numérica de ID y se implementó `getTrackerOrderDisplayId` + uso de string IDs en tab, mini-tracker, highlight y modal de cancelación. Se recompiló y redeployó stack para publicar bundle actualizado.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
