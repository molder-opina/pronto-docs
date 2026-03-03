ID: ERR-20260303-ADMIN-NAVIGATION-COCINA-CAJA-SHOULD-BE-PRIMARY
FECHA: 2026-03-03
PROYECTO: pronto-static (employees/admin)
SEVERIDAD: media
TITULO: Cocina y Caja siguen mezcladas como tabs del dashboard en lugar de vivir en navegación principal
DESCRIPCION: En la consola `/admin`, `Cocina` y `Caja` siguen apareciendo dentro del tabstrip superior junto con `Tablero` y módulos de gestión. La navegación esperada es que ambas secciones existan como entradas propias de la navegación principal y que, una vez dentro, muestren sus tabs secundarios.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6081/admin/dashboard/waiter`.
2. Revisar los tabs superiores.
3. Observar que `Cocina` y `Caja` aparecen allí en vez de estar en la navegación principal lateral.
RESULTADO_ACTUAL: `Cocina` y `Caja` están mezcladas con los tabs del tablero principal.
RESULTADO_ESPERADO: `Cocina` y `Caja` deben estar en la navegación principal lateral; al abrir cada una, se deben mostrar sus opciones como tabs secundarios.
UBICACION: pronto-static/src/vue/employees/App.vue; pronto-static/src/vue/employees/shared/components/Sidebar.vue; pronto-static/src/vue/employees/shared/components/DashboardView.vue
EVIDENCIA: Captura compartida por el usuario en sesión.
HIPOTESIS_CAUSA: La lógica actual de `admin/system` usa un único set de tabs operativos (`waiter`, `kitchen`, `cashier`, `products`, `modifiers`, `tables`, `areas`, `sessions`) y el sidebar administrativo filtra en exceso las secciones visibles del menú principal.
ESTADO: RESUELTO
SOLUCION: Se ajustó la navegación administrativa para que `App.vue` exponga `kitchen` y `cashier` en las secciones visibles del menú principal, `Sidebar.vue` las ordene como entradas primarias junto a `Dashboard` y módulos administrativos, y `DashboardView.vue` separe los tabsets de `Tablero`, `Cocina` y `Caja`. Con esto, `Cocina` muestra tabs `Cocina/Productos/Aditamientos`, `Caja` muestra `Caja/Caja y Cierres`, y el tablero principal conserva solo `Tablero/Productos/Aditamientos/Mesas/Áreas`.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03

