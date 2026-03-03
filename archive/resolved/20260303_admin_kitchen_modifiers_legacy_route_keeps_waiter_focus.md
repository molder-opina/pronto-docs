ID: ERR-20260303-ADMIN-KITCHEN-MODIFIERS-LEGACY-ROUTE-KEEPS-WAITER-FOCUS
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: Aditamientos de Cocina sigue entrando por la ruta compartida modifiers y conserva foco de Meseros
DESCRIPCION: En `/admin/dashboard/kitchen`, al abrir el tab `Aditamientos`, algunos flujos siguen aterrizando en `/admin/dashboard/modifiers` en vez de la ruta exclusiva de cocina. Eso hace que el sidebar marque `Meseros/Dashboard` aunque el strip superior muestre el grupo de `Cocina`.
PASOS_REPRODUCIR:
1. Entrar a `/admin/dashboard/kitchen`.
2. Abrir el tab `Aditamientos`.
3. Observar URL `/admin/dashboard/modifiers` o foco lateral incorrecto.
RESULTADO_ACTUAL: La navegación puede permanecer en la ruta compartida `modifiers` y el foco del shell queda inconsistente.
RESULTADO_ESPERADO: El tab debe resolver siempre a `/admin/dashboard/kitchen/modifiers` y mantener activo `Cocina`.
UBICACION: pronto-static/src/vue/employees/shared/components/DashboardView.vue, pronto-static/src/vue/employees/shared/components/Sidebar.vue, pronto-static/src/vue/employees/shared/router/index.ts
EVIDENCIA: Captura del usuario mostrando `Aditamientos` con URL `/admin/dashboard/modifiers` y sidebar activo en `Dashboard`.
HIPOTESIS_CAUSA: Persisten accesos legacy a la ruta compartida `modifiers` sin redirección al namespace de cocina.
ESTADO: RESUELTO
SOLUCION: Se endureció el guard del router compartido para detectar navegación heredada desde el contexto `Cocina` hacia `products` o `modifiers` y redirigirla automáticamente a `kitchen-products` o `kitchen-modifiers`. Esto protege el flujo incluso si el navegador conserva bundles viejos o un enlace stale dispara la ruta compartida.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
