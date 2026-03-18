# Reglas de Auditoría UX Frontend (Canónicas)

## Propósito
Este documento define las reglas obligatorias que toda auditoría UX/frontend debe validar en PRONTO para proteger diseños establecidos y evitar regresiones visuales.

## Alcance
- `pronto-static/src/vue/clients/**`
- `pronto-static/src/vue/employees/**`
- `pronto-static/src/static_content/assets/css/**`
- `pronto-client/src/pronto_clients/templates/**`
- `pronto-employees/src/pronto_employees/templates/**`

## Regla de Enforcement
- Toda auditoría UX/frontend es inválida si no incluye evidencia de validación de estas reglas.
- Cada hallazgo debe referenciar el ID de regla (`FR-UX-XXX`) y evidencia concreta (archivo, selector, captura o prueba).

## Reglas Obligatorias

### FR-UX-001 — Jerarquía visual clara
- El CTA principal de cada flujo debe ser el elemento visual dominante.
- No se permite que resumenes secundarios (precio, metadata, hints) compitan con el CTA.

### FR-UX-002 — Modales con altura controlada
- Ningún modal crítico debe comportarse como página completa sin justificación de producto.
- Debe existir límite de alto visible y distribución por zonas (header, contenido, footer).

### FR-UX-003 — Footer sticky en flujos de compra
- En modales/paneles de compra, total + acción principal deben permanecer visibles.
- El footer debe mantenerse fijo/sticky mientras el contenido interno hace scroll.

### FR-UX-004 — Scroll interno en secciones extensas
- Listas extensas (extras, modificadores, historial) deben usar contenedor con `max-height` + `overflow-y`.
- Prohibido crecer indefinidamente empujando acciones fuera del viewport.

### FR-UX-005 — Controles de cantidad compactos y accesibles
- Controles `- / cantidad / +` deben mantener tamaño compacto, foco visible y feedback táctil.
- Botones deben conservar área táctil usable y estados hover/active/focus.

### FR-UX-006 — Imágenes de carrito compactas
- Miniaturas en carrito lateral deben ser pequeñas y consistentes (no dominar el alto del item).
- Se exige tamaño acotado y `object-fit: cover`.

### FR-UX-007 — No texto instructivo innecesario
- Prohibido depender de mensajes tipo “desliza para ver más” cuando el layout puede resolverlo.
- La interfaz debe ser autoexplicativa por estructura visual.

### FR-UX-008 — Valores de selección acotados
- Prohibido mostrar `∞` en selectores de UX de producto cuando el dominio es acotado por catálogo.
- El frontend debe mostrar un máximo efectivo derivado de reglas reales (`min/max/opciones`).

### FR-UX-009 — Consistencia SSR/Vue
- La misma experiencia visual crítica (modales, carrito, checkout) debe ser consistente entre SSR y Vue.
- Cualquier override temporal debe documentarse y no romper paridad visual.

### FR-UX-010 — Responsive obligatorio
- El diseño debe validarse al menos en desktop y mobile.
- No se aceptan desbordes horizontales ni cortes de CTA en breakpoints principales.

## Formato de salida obligatorio en auditoría
Para cada regla:
- `RULE_ID`
- `STATUS`: `PASS` | `FAIL`
- `EVIDENCE`: archivo + selector/linea + prueba/captura
- `IMPACT`: `P0|P1|P2`
- `ACTION`: corrección propuesta concreta

## Criterio de rechazo
- Si falta validar una regla: `REJECTED`.
- Si hay `FAIL` en `FR-UX-001`, `FR-UX-003`, `FR-UX-006` o `FR-UX-008`: `REJECTED` hasta corrección.
