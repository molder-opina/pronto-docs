ID: ERR-20260303-ADMIN-DASHBOARD-TABS-PRODUCTS-MODIFIERS-SWITCH-TO-KITCHEN-GROUP
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Productos y Aditamientos en admin cambian al grupo de tabs de Cocina en lugar del grupo de Meseros
DESCRIPCION: En `/admin/dashboard/products` y `/admin/dashboard/modifiers` el shell superior muestra los tabs de `Cocina` (`Cocina`, `Productos`, `Aditamientos`) en vez de conservar el grupo principal de `Mesero` (`Mesero`, `Productos`, `Aditamientos`, `Mesas`, `Áreas`), aunque `Mesas` y `Áreas` sí preservan el grupo correcto.
PASOS_REPRODUCIR:
1. Entrar a `/admin/dashboard/waiter`.
2. Navegar a `Productos` o `Aditamientos`.
3. Observar que el tabstrip cambia a `Cocina / Productos / Aditamientos`.
RESULTADO_ACTUAL: `Productos` y `Aditamientos` saltan al grupo de tabs de cocina.
RESULTADO_ESPERADO: `Productos`, `Aditamientos`, `Mesas` y `Áreas` deben mantener el mismo grupo principal de tabs de `Mesero`.
UBICACION: pronto-static/src/vue/employees/shared/components/DashboardView.vue
EVIDENCIA: Capturas del usuario mostrando inconsistencia entre `/admin/dashboard/waiter`, `/products`, `/modifiers`, `/tables` y `/areas`.
HIPOTESIS_CAUSA: La detección de `isKitchenView` considera `products` y `modifiers` como tabs de cocina también para `admin/system`, en vez de tratar el contexto principal real de la vista.
ESTADO: RESUELTO
SOLUCION: `DashboardView.vue` ya no trata `products` y `modifiers` como contexto de cocina para `admin/system`; solo `kitchen` activa el grupo de tabs de cocina y `cashier/sessions` el de caja. `Products`, `Modifiers`, `Tables` y `Areas` vuelven a permanecer en el grupo principal de `Mesero`. También `Sidebar.vue` renombró el acceso principal de `Dashboard` a `Meseros`.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
