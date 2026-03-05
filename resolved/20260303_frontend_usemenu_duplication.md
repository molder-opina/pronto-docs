ID: CODE-20260303-020
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: Duplicación de composable useMenu en el frontend

DESCRIPCION: |
  Se ha detectado que el composable `useMenu`, encargado de la lógica de obtención y filtrado del menú, está implementado de forma independiente en dos ubicaciones diferentes dentro de `pronto-static`.

RESULTADO_ACTUAL: |
  Duplicación en:
  1. `src/vue/clients/composables/use-menu.ts`
  2. `src/vue/shared/utils/use-menu.ts`

RESULTADO_ESPERADO: |
  Unificar la lógica en `src/vue/shared/composables/useMenu.ts` (siguiendo el canon de nomenclatura de carpetas) y reutilizarlo tanto en la aplicación de clientes como en la de empleados.

UBICACION: |
  - `pronto-static/src/vue/clients/composables/use-menu.ts`
  - `pronto-static/src/vue/shared/utils/use-menu.ts`

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Consolidar las mejoras de ambas implementaciones en una versión única en `shared`.
  - [ ] Actualizar las importaciones en los componentes de `clients` y `employees`.
  - [ ] Eliminar los archivos redundantes.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
