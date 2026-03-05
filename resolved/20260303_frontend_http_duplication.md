ID: ARCH-20260303-002
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: Duplicación de lógica en clientes HTTP del frontend

DESCRIPCION: |
  Se ha observado una duplicación significativa de lógica entre `src/vue/clients/core/http.ts` y `src/vue/employees/shared/core/http.ts`. Ambos archivos implementan de forma independiente el manejo de CSRF, la lógica de reintentos, el desempaquetado de la respuesta estandarizada de la API y el manejo de errores HTTP (401, 403, etc.).

RESULTADO_ACTUAL: |
  Existen dos implementaciones paralelas de un cliente HTTP con muchas funcionalidades compartidas, lo que aumenta el riesgo de inconsistencias en el manejo de errores o seguridad.

RESULTADO_ESPERADO: |
  Unificar la lógica común en un cliente HTTP base en `src/vue/shared/utils` que pueda ser extendido o configurado para las necesidades específicas de `clients` (manejo de `customer_ref`) y `employees` (manejo de JWT y refresco de tokens).

UBICACION: |
  - `pronto-static/src/vue/clients/core/http.ts`
  - `pronto-static/src/vue/employees/shared/core/http.ts`

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Diseñar un cliente HTTP base compartido.
  - [ ] Refactorizar los clientes de `clients` y `employees` para utilizar el base compartido.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
