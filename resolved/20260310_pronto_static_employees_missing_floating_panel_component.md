ID: BUG-20260310-PRONTO-STATIC-EMPLOYEES-MISSING-FLOATING-PANEL-COMPONENT
FECHA: 2026-03-10
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: `KitchenBoard.vue` importa `FloatingPanel.vue` inexistente y rompe `build:employees`
DESCRIPCION: Durante la validación del lote restante de `pronto-static`, `npm run build:employees` falló porque `src/vue/employees/chef/components/KitchenBoard.vue` importa `@emp-shared/components/FloatingPanel.vue`, pero ese componente no existía en `src/vue/employees/shared/components/`.
PASOS_REPRODUCIR:
1. Ejecutar `cd pronto-static && npm run build:employees`.
2. Observar error ENOENT para `shared/components/FloatingPanel.vue`.
RESULTADO_ACTUAL: Corregido.
RESULTADO_ESPERADO: `build:employees` compila y `KitchenBoard.vue` resuelve su panel flotante desde shared/components.
UBICACION:
- pronto-static/src/vue/employees/chef/components/KitchenBoard.vue
- pronto-static/src/vue/employees/shared/components/FloatingPanel.vue
EVIDENCIA:
- Vite reportó `Could not load ... FloatingPanel.vue`.
- Búsqueda transversal de `FloatingPanel` mostró uso en KitchenBoard y ausencia del archivo.
HIPOTESIS_CAUSA: Refactor del board de cocina que asumió la extracción del panel flotante compartido, pero el componente no se materializó en el repo.
ESTADO: RESUELTO
SOLUCION:
- Se creó `src/vue/employees/shared/components/FloatingPanel.vue` con la API esperada por `KitchenBoard.vue` (`title`, `subtitle`, `bodyHtml`, evento `close`).
- Se incluyó estilo responsive y soporte para el HTML estructurado que ya renderizan los boards.
- Se verificó con `npm run build:employees` y Vitest focalizado de employees.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

