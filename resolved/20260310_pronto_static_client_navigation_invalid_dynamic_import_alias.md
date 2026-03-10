ID: BUG-20260310-PRONTO-STATIC-CLIENT-NAVIGATION-INVALID-DYNAMIC-IMPORT-ALIAS
FECHA: 2026-03-10
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: `client-navigation.ts` usa alias inválido dentro del destructuring de `import().then(...)` y rompe `build:clients`
DESCRIPCION: Durante la validación del lote restante de `pronto-static`, `npm run build:clients` falló por un error sintáctico en `src/vue/clients/modules/client-navigation.ts`. El código usaba `({ bindViewTabs as bindViewTabsUi })` dentro del callback de `import().then(...)`, sintaxis no válida en JavaScript para destructuring.
PASOS_REPRODUCIR:
1. Ejecutar `cd pronto-static && npm run build:clients`.
2. Observar fallo de esbuild apuntando a `client-navigation.ts`.
RESULTADO_ACTUAL: Corregido.
RESULTADO_ESPERADO: `build:clients` compila sin errores sintácticos.
UBICACION:
- pronto-static/src/vue/clients/modules/client-navigation.ts
EVIDENCIA:
- `vite:esbuild` reportó `Expected "}" but found "as"` en `client-navigation.ts`.
- Búsqueda transversal del patrón mostró la ocurrencia en ese archivo.
HIPOTESIS_CAUSA: Refactor de wrappers de navegación con alias escrito usando sintaxis de import no válida en un callback JS.
ESTADO: RESUELTO
SOLUCION:
- Se eliminó el destructuring inválido y luego se reescribió el wrapper completo de navegación para usar callbacks y exports reales de `view-tabs-ui.ts` y `view-navigation-ui.ts`.
- Se verificó con `npm run build:clients`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

