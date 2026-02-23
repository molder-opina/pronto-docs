ID: ERR-20260222-CLIENT-MENU-RESPONSIVE-UNEVEN-CARDS
FECHA: 2026-02-22
PROYECTO: pronto-client, pronto-static
SEVERIDAD: alta
TITULO: Front de clientes descuadrado y cards de menú con tamaños visuales inconsistentes
DESCRIPCION: En la vista de menú de clientes, el grid no se adapta de forma uniforme entre resoluciones y aparecen cards con anchos/alturas percibidos desiguales, afectando legibilidad y UX.
PASOS_REPRODUCIR:
1) Abrir http://localhost:6080 en desktop.
2) Entrar al tab Menú.
3) Observar el grid de productos al cambiar ancho de ventana.
RESULTADO_ACTUAL: El layout se ve descuadrado y algunas cards se perciben más anchas/gordas que otras.
RESULTADO_ESPERADO: Grid responsive estable y cards uniformes (ancho/alto consistentes por fila y comportamiento predecible en breakpoints).
UBICACION: pronto-static/src/static_content/assets/css/clients/menu-updates.css, pronto-client/src/pronto_clients/templates/base.html
EVIDENCIA: Reporte visual del usuario con capturas del menú cliente en localhost:6080.
HIPOTESIS_CAUSA: Reglas CSS superpuestas entre overrides de template y estilos de menu-updates; breakpoints y sizing de grid/card sin estrategia única.
SOLUCION: Se unificó la estrategia responsive del menú: grid fluido con auto-fit/minmax, ajuste de breakpoints mobile/tablet, estiramiento de grid-item, y normalización de width/height/min-height en product-card para evitar variaciones visuales. Además se actualizó cache-busting en index.html para forzar carga de CSS nuevo.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-22
ESTADO: RESUELTO
