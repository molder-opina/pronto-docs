ID: ERR-20260222-CLIENTE-MENU-PLUS-AGOTADO
FECHA: 2026-02-22
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Botón + poco visible y estado de agotado no evidente en cards del menú cliente
DESCRIPCION: En la página de cliente, el icono de agregar (+) en productos no se percibe claramente y los productos no disponibles no muestran una marca suficientemente visible de agotado.
PASOS_REPRODUCIR:
1. Abrir la vista de menú de clientes.
2. Revisar cards de productos en desktop/mobile.
3. Validar visibilidad del botón de agregar y marca de agotado.
RESULTADO_ACTUAL: El botón + no se distingue bien y el estado agotado es sutil.
RESULTADO_ESPERADO: El botón + debe verse de forma clara y consistente. Todo producto agotado debe mostrar marca visual evidente de "Agotado".
UBICACION: pronto-static/src/vue/clients/components/menu/ProductCard.vue
EVIDENCIA: Reporte visual del usuario en capturas de la vista de cliente.
HIPOTESIS_CAUSA: Contraste/jerarquía visual insuficiente en CTA de agregar y señalización de disponibilidad dependiente de estilos poco notorios.
ESTADO: RESUELTO
SOLUCION: Se reforzó `ProductCard.vue` con botón flotante `+` en la imagen, CTA inferior con icono `+` consistente y badge+overlay de `Agotado` de alto contraste. Además se normalizó `is_available` de forma defensiva para cubrir valores string/numéricos.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-22
