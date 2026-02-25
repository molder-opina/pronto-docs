ID: ERR-20260223-CHECKOUT-DETALLES-MINIMIZAR
FECHA: 2026-02-23
PROYECTO: pronto-static / pronto-client
SEVERIDAD: alta
TITULO: Botón de minimizar en tab Detalles no colapsa acordeones
DESCRIPCION: En la vista de checkout (tab Detalles), al hacer clic en el encabezado con flecha del acordeón no se minimiza el bloque.
PASOS_REPRODUCIR:
1. Abrir cliente y navegar a tab Detalles.
2. Hacer clic en la flecha/encabezado de "Datos de la Mesa" o "Orden Actual".
RESULTADO_ACTUAL: El contenido permanece expandido; no cambia el estado collapsed.
RESULTADO_ESPERADO: El acordeón debe alternar entre expandido/colapsado al hacer clic (y con teclado Enter/Espacio).
UBICACION: pronto-static/src/vue/clients/modules/client-base.ts; pronto-client/src/pronto_clients/templates/base.html
EVIDENCIA: Reporte del usuario con captura mostrando el control de minimizado sin respuesta.
HIPOTESIS_CAUSA: El HTML usa `data-action="toggle-parent-class"`, pero el flujo runtime no garantizaba el binding delegado para ese comportamiento en todos los casos.
ESTADO: RESUELTO
SOLUCION: Se agregó binding explícito en `initClientBase()` con `bindCheckoutAccordions()`, que enlaza listeners `click` y `keydown` (Enter/Espacio) a `.checkout-accordion-header`, alterna la clase `collapsed` en el contenedor y sincroniza `aria-expanded`.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
