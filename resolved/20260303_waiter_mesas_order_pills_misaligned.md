ID: 20260303_waiter_mesas_order_pills_misaligned
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Las órdenes dentro de las tarjetas de mesa se ven desalineadas en el tab Mesas
DESCRIPCION: En el tablero de mesero, dentro del tab `Mesas`, las órdenes se renderizan como texto corrido dentro de pills y el resultado visual es inconsistente, con pesos tipográficos y separaciones que dificultan la lectura.
PASOS_REPRODUCIR:
1. Ingresar a `/waiter/dashboard/waiter` o `/admin/dashboard/waiter`.
2. Abrir el tab `Mesas`.
3. Observar la lista de órdenes dentro de una tarjeta de mesa ocupada.
RESULTADO_ACTUAL: Las órdenes se muestran con una sola línea de texto dentro de pills poco consistentes y visualmente desalineadas.
RESULTADO_ESPERADO: Cada orden debe verse consistente, con segmentos alineados para número, estado y total, manteniendo legibilidad y jerarquía visual.
UBICACION: pronto-static/src/vue/employees/waiter/components/WaiterBoard.vue
EVIDENCIA: Captura del usuario mostrando pills de órdenes desalineadas dentro de la tarjeta de mesa.
HIPOTESIS_CAUSA: El tab Mesas compacta demasiada información en una sola cadena de texto y el CSS actual no define una estructura interna estable para cada orden.
SOLUCION: Se cambió la representación de cada orden dentro de la tarjeta de mesa para usar segmentos internos alineados para código, estado y total, en lugar de una sola cadena de texto. También se ajustó el CSS para que cada pill ocupe todo el ancho disponible con grid estable y fallback responsivo en móvil.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
ESTADO: RESUELTO
