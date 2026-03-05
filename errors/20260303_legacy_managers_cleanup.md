ID: CODE-20260303-026
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: Módulos "Manager" legacy en employees (Vanilla JS) candidatos a Vue

DESCRIPCION: |
  Se han identificado varios archivos en `src/vue/employees/shared/modules/` que siguen un patrón de programación imperativa (clases que manipulan el DOM manualmente) y que parecen ser remanentes de una migración parcial. Algunos de estos módulos (`PromotionsManager`, `ReportsManager`) ya tienen contrapartes modernas en componentes Vue, pero los archivos originales persisten.

RESULTADO_ACTUAL: |
  Archivos detectados:
  - `customers-manager.ts`
  - `promotions-manager.ts` (Legacy)
  - `recommendations-manager.ts`
  - `role-management.ts`
  - `reports-manager.ts` (Legacy)
  
  Estos archivos utilizan `innerHTML`, `document.getElementById` y `addEventListener` directos, lo que rompe el flujo de datos de Vue y dificulta el mantenimiento.

RESULTADO_ESPERADO: |
  Completar la migración de estos módulos a componentes Vue funcionales y eliminar los archivos `.ts` que contienen manipulación directa del DOM.

UBICACION: |
  - `pronto-static/src/vue/employees/shared/modules/`

ESTADO: ABIERTO

ACCIONES_PENDIENTES:
  - [ ] Validar qué partes de `customers-manager.ts` y `recommendations-manager.ts` no han sido migradas a componentes Vue.
  - [ ] Crear las vistas Vue correspondientes para estos módulos.
  - [ ] Eliminar los archivos legacy mencionados tras asegurar paridad de funcionalidades.
