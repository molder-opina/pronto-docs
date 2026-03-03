ID: ERR-20260303-ADMIN-KITCHEN-TABS-SHARE-PRODUCTS-MODIFIERS-ROUTES-WITH-WAITER
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: Tabs de Cocina comparten rutas de Productos y Aditamientos con Meseros y rompen el foco del shell
DESCRIPCION: En `/admin/dashboard/kitchen`, al hacer clic en `Productos` o `Aditamientos`, la navegación cae en las rutas compartidas `products` y `modifiers`, que también pertenecen al grupo `Meseros`. Como el shell no puede distinguir el origen, el foco principal cambia a `Meseros` en lugar de mantenerse en `Cocina`.
PASOS_REPRODUCIR:
1. Entrar a `/admin/dashboard/kitchen`.
2. Hacer clic en el tab `Productos`.
3. Observar que la vista queda asociada al grupo de `Meseros` y no al grupo de `Cocina`.
RESULTADO_ACTUAL: El tabstrip y el foco principal saltan al contexto de `Meseros`.
RESULTADO_ESPERADO: `Cocina -> Productos` y `Cocina -> Aditamientos` deben tener rutas propias y mantener el grupo de tabs de `Cocina`.
UBICACION: pronto-static/src/vue/employees/shared/router/index.ts, pronto-static/src/vue/employees/shared/components/DashboardView.vue, pronto-static/src/vue/employees/shared/components/Sidebar.vue
EVIDENCIA: Validación visual del usuario mostrando `Cocina` activo, luego click en `Productos` y foco incorrecto en `Meseros`.
HIPOTESIS_CAUSA: `products` y `modifiers` son nombres/rutas compartidos entre `Meseros` y `Cocina`, impidiendo distinguir el contexto de navegación.
ESTADO: RESUELTO
SOLUCION: Se agregaron rutas exclusivas `kitchen-products` y `kitchen-modifiers` en el router compartido, `DashboardView.vue` dejó de reutilizar `products/modifiers` para el grupo de cocina y `Sidebar.vue` ahora considera esas rutas como parte del foco principal de `Cocina`. La validación en navegador confirmó que `/admin/dashboard/kitchen/products` y `/admin/dashboard/kitchen/modifiers` conservan el strip `Cocina/Productos/Aditamientos` y mantienen el lateral activo en `Cocina`.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
