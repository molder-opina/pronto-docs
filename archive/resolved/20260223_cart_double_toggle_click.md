ID: ERR-20260223-CART-DOUBLE-TOGGLE-CLICK
FECHA: 2026-02-23
PROYECTO: pronto-client, pronto-static
SEVERIDAD: alta
TITULO: Carrito no abre por doble binding de click
DESCRIPCION: El carrito muestra la alerta de productos antiguos pero no abre el panel al hacer click en el icono. El click ejecuta dos handlers de toggle (fallback SSR y binding Vue), abriendo y cerrando en la misma interacción.
PASOS_REPRODUCIR:
1. Ingresar al menú de clientes autenticado.
2. Tener al menos 1 producto en carrito.
3. Hacer click en el botón de carrito del header.
RESULTADO_ACTUAL: Se muestra notificación naranja de productos antiguos, pero el panel lateral no queda abierto.
RESULTADO_ESPERADO: El panel del carrito debe abrirse y permanecer visible tras un solo click.
UBICACION: pronto-client/src/pronto_clients/templates/base.html, pronto-static/src/vue/clients/entrypoints/base.ts
EVIDENCIA: Reporte visual del usuario y revisión de código con dos listeners activos sobre [data-toggle-cart] con claves de dataset distintas.
HIPOTESIS_CAUSA: Doble binding sobre el mismo botón; ambos ejecutan toggle y el segundo revierte el estado del primero.
ESTADO: RESUELTO
SOLUCION: Eliminado el inline script de legacy cart fallback de base.html (versión 1.0216). El binding duplicado sobre [data-toggle-cart] ya no existe. Ahora solo queda el handler único en base.ts → initCartBindings() que usa bindOnce con guardia cartToggleBound.
COMMIT: (incluido en cambio de versión 1.0215→1.0216)
FECHA_RESOLUCION: 2026-02-26
