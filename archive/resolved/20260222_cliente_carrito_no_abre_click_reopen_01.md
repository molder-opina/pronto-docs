ID: ERR-20260222-CLIENTE-CART-NO-OPEN-CLICK-REOPEN-01
FECHA: 2026-02-22
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: Reapertura - carrito sigue sin abrir al hacer clic en cliente
DESCRIPCION: Reaparición del bug ERR-20260222-CLIENTE-CART-NO-OPEN-CLICK. Aunque se aplicó fix previo, el carrito sigue sin abrir al hacer clic en la página de cliente.
PASOS_REPRODUCIR:
1. Abrir página de cliente.
2. Hacer clic en icono de carrito del header.
RESULTADO_ACTUAL: No abre panel de carrito.
RESULTADO_ESPERADO: Debe abrir panel de carrito inmediatamente.
UBICACION: pronto-client/src/pronto_clients/templates/base.html
EVIDENCIA: Reporte directo del usuario posterior al fix anterior.
HIPOTESIS_CAUSA: El binding del carrito en TypeScript no está siendo ejecutado en runtime actual (cache/build), faltando un fallback inline robusto en template SSR.
ESTADO: RESUELTO
SOLUCION: Se agregó fallback SSR en `base.html` que vincula clic en `[data-toggle-cart]` y `#sticky-cart-btn`, expone `window.showCart`, `window.toggleCart`, `window.closeCart` cuando faltan, y alterna clases `open` en `#cart-panel`/`#cart-backdrop` como modo legacy.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-22
