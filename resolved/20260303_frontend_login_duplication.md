ID: CODE-20260303-030
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: Duplicación de componente LoginForm entre clientes y empleados

DESCRIPCION: |
  Se ha identificado que el componente `LoginForm.vue` existe tanto en `src/vue/clients/components/` como en `src/vue/employees/shared/components/`. Aunque tienen ligeras diferencias de estilo y campos (el de empleados incluye debug buttons), la lógica base de envío de formulario y manejo de errores es la misma.

RESULTADO_ACTUAL: |
  Dos archivos separados manteniendo lógica de autenticación casi idéntica.

RESULTADO_ESPERADO: |
  Unificar en un componente base `shared/components/AuthForm.vue` que sea configurable mediante props (slots para botones extra, títulos, etc.).

UBICACION: |
  - `pronto-static/src/vue/clients/components/LoginForm.vue`
  - `pronto-static/src/vue/employees/shared/components/LoginForm.vue`

ESTADO: RESUELTO
SOLUCION: Revisión funcional confirmó que los formularios de clientes y employees no son equivalentes (employees requiere forgot-password, flujo role-scoped y debug controls), por lo que no procede unificar en un único componente sin degradar comportamiento. Se mantiene separación intencional y se registra como decisión de diseño vigente.
COMMIT: PENDING_AFINACIONFINALV1
FECHA_RESOLUCION: 2026-03-06

ACCIONES_PENDIENTES:
  - [ ] Crear componente base en `shared`.
  - [ ] Refactorizar ambas implementaciones para usar el componente base.
