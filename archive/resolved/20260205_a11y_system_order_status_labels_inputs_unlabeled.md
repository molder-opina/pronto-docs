---
ID: ERR-20260205-A11Y-SYS-STATUS-LABELS
FECHA: 2026-02-05
PROYECTO: pronto-employees
SEVERIDAD: baja
TITULO: Inputs sin label/aria-label en consola /system/config/order-status-labels
DESCRIPCION: La vista de consola para editar etiquetas de estados renderiza inputs de texto sin `<label for>` asociado ni `aria-label`/`aria-labelledby`. Esto reduce accesibilidad para lectores de pantalla.
PASOS_REPRODUCIR: 1) Abrir /system/config/order-status-labels. 2) Inspeccionar DOM. 3) Ver inputs sin label/aria.
RESULTADO_ACTUAL: Inputs sin nombre accesible.
RESULTADO_ESPERADO: Cada input con label explícito o `aria-label`/`aria-labelledby` (puede referenciar el `<th>` correspondiente).
UBICACION: pronto-employees/src/pronto_employees/templates/system_order_status_labels.html:23-44
EVIDENCIA: `<input type=\"text\" ... class=\"client-label\">` sin label/aria-label.
HIPOTESIS_CAUSA: UI interna construida rápido sin checklist de accesibilidad.
ESTADO: RESUELTO
---

