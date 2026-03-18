ID: BUG-20260309-WAITER-BOARD-SAFE-MODULARIZATION
FECHA: 2026-03-09
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: `WaiterBoard.vue` concentra helpers puros y lógica derivada de mesas en un archivo monolítico
DESCRIPCION: La auditoría abierta del monorepo identifica `WaiterBoard.vue` como uno de los archivos grandes principales del frontend. La revisión focalizada confirmó que el componente mezclaba UI y side-effects con un bloque amplio de helpers puros y derivación de mesas ocupadas, candidatos a extracción segura y testeable.
PASOS_REPRODUCIR:
1. Revisar la auditoría `20260309_monorepo_sync_and_technical_debt_audit.md`.
2. Abrir `pronto-static/src/vue/employees/waiter/components/WaiterBoard.vue`.
3. Ubicar el bloque de helpers de status, notas, totales, catálogo de mesas y derivación de mesas ocupadas.
RESULTADO_ACTUAL: El SFC superaba 2300 líneas y concentraba helpers puros mezclados con wiring reactivo del tablero.
RESULTADO_ESPERADO: Los helpers puros y la derivación de mesas ocupadas deben vivir en un módulo auxiliar con pruebas unitarias, dejando el SFC enfocado en UI y coordinación.
UBICACION:
- pronto-static/src/vue/employees/waiter/components/WaiterBoard.vue
- pronto-static/src/vue/employees/waiter/modules/waiter/board-helpers.ts
- pronto-static/src/vue/employees/waiter/modules/waiter/board-helpers.spec.ts
EVIDENCIA:
- `WaiterBoard.vue` bajó de 2304 a 2161 líneas.
- Se extrajeron helpers puros y la construcción de mesas ocupadas a `board-helpers.ts`.
- Validación: `PRONTO_TARGET=employees npm run test:run -- waiter/modules/waiter/board-helpers.spec.ts` OK; `npm run build` OK.
HIPOTESIS_CAUSA: El tablero creció por iteraciones funcionales sucesivas, y la presión operativa fue dejando utilidades estables dentro del mismo SFC en lugar de extraerlas a tiempo.
ESTADO: RESUELTO
SOLUCION: Se creó `board-helpers.ts` para centralizar traducción de estados, notas, totales, escape HTML, normalización de mesas y derivación de mesas ocupadas; `WaiterBoard.vue` quedó usando ese módulo auxiliar y se añadió `board-helpers.spec.ts` para cubrir casos base y agregación de mesas.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09

