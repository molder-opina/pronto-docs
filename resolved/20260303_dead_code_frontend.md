ID: CODE-20260303-003
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: Código muerto detectado en utilidades compartidas del frontend

DESCRIPCION: |
  Durante la auditoría de `pronto-static`, se identificó que el archivo `src/vue/shared/utils/useFetch.ts` no tiene usos activos en el proyecto. Las funciones `fetchJSON` y `useApi` definidas en este archivo solo se referencian a sí mismas. El proyecto utiliza clientes HTTP más robustos ubicados en `src/vue/clients/core/http.ts` y `src/vue/employees/shared/core/http.ts`.

RESULTADO_ACTUAL: |
  El archivo `src/vue/shared/utils/useFetch.ts` existe pero no es utilizado por ningún componente o módulo.

RESULTADO_ESPERADO: |
  El codebase debe mantenerse limpio de código muerto para reducir la carga cognitiva y el tamaño de los paquetes.

UBICACION: |
  - `pronto-static/src/vue/shared/utils/useFetch.ts`

ESTADO: RESUELTO

SOLUCION:
- Se eliminó el archivo sin uso `pronto-static/src/vue/shared/utils/useFetch.ts`.
- Se verificó que no existen referencias activas a `useFetch`, `fetchJSON` o `useApi` en `pronto-static/src/vue`.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-04

ACCIONES_PENDIENTES:
  - [x] Verificar una última vez si hay usos dinámicos o indirectos.
  - [x] Eliminar el archivo `useFetch.ts`.
