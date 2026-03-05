ID: ERR-20260303-ADMIN-CASHIER-SESSIONS-SIDEBAR-NOT-ACTIVE
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Caja no permanece activa en el lateral al entrar a Caja y Cierres
DESCRIPCION: En `/admin/dashboard/sessions`, el lateral no mantiene seleccionado `Caja` aunque `Caja y Cierres` es parte del mismo grupo operativo de caja. El comportamiento sí funciona correctamente en `/admin/dashboard/cashier`.
PASOS_REPRODUCIR:
1. Entrar a `/admin/dashboard/cashier` y verificar `Caja` activa.
2. Entrar a `/admin/dashboard/sessions`.
3. Observar que `Caja` deja de verse activa en el lateral.
RESULTADO_ACTUAL: El foco lateral no marca `Caja` dentro de `Caja y Cierres`.
RESULTADO_ESPERADO: `Caja` debe permanecer activa tanto en `/admin/dashboard/cashier` como en `/admin/dashboard/sessions`.
UBICACION: pronto-static/src/vue/employees/shared/components/Sidebar.vue
EVIDENCIA: Capturas del usuario mostrando estado activo correcto en `cashier` e incorrecto en `sessions`.
HIPOTESIS_CAUSA: El sidebar no está asociando la ruta `sessions` con el item principal de `Caja` en todos los flujos de render.
ESTADO: RESUELTO
SOLUCION: El sidebar ahora considera `sessions` como parte del bloque activo de `cashier` mediante `cashierDashboardRouteIds = {'cashier','sessions'}` y `isCashierDashboardRouteActive`, por lo que `Caja` permanece activa tanto en `/admin/dashboard/cashier` como en `/admin/dashboard/sessions`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-04
