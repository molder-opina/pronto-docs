ID: BUG-20260310-PRONTO-STATIC-SYSTEM-SCOPE-OPS-UI-DRIFT
FECHA: 2026-03-10
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: El frontend employees exponía módulos `system-ops` y `observability` sin backend conservado en esta ronda
DESCRIPCION: Durante la curación de `pronto-static`, el shell de empleados aún exponía módulos de sistema (`system-ops`, `observability`) y componentes bajo `src/vue/employees/system/**`. En paralelo, la curación conservadora previa de `pronto-api` retiró `webhooks` y `employees/system_ops` por ser superficie sensible/no validada. Eso dejó un drift frontend→backend: rutas visibles desde Vue sin respaldo backend en este corte.
PASOS_REPRODUCIR:
1. Revisar `App.vue`, `shared/router/index.ts`, `Sidebar.vue` y `DashboardView.vue`.
2. Observar tabs/rutas `system-ops` y `observability`.
3. Verificar que `pronto-api` ya no registra `employees/system_ops` en esta ronda.
RESULTADO_ACTUAL: Resuelto.
RESULTADO_ESPERADO: El frontend no debe exponer módulos system-only sin backend vigente/validado en el mismo corte.
UBICACION:
- pronto-static/src/vue/employees/App.vue
- pronto-static/src/vue/employees/shared/router/index.ts
- pronto-static/src/vue/employees/shared/components/Sidebar.vue
- pronto-static/src/vue/employees/shared/components/DashboardView.vue
- pronto-static/src/vue/employees/system/components/*
EVIDENCIA:
- Búsqueda transversal mostró referencias vivas a `system-ops`/`observability` en Vue employees.
- Tras el recorte ya no quedaron referencias (`rg` sin resultados).
- `build:employees`, `build:clients`, Vitest y Playwright cercanos quedaron verdes.
HIPOTESIS_CAUSA: WIP frontend de consola system quedó mezclado después de retirar el backend sensible correspondiente.
ESTADO: RESUELTO
SOLUCION:
- Se eliminaron las rutas/tabs/items `system-ops` y `observability` del shell employees.
- Se volvió a usar `EmployeesManager` para la ruta `employees` sin variante system específica.
- Se removieron los componentes no trackeados de `src/vue/employees/system/components/`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

