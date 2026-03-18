ID: BUG-20260310-SCOPED-AUTHORIZATION-ERROR-ALIAS-MISSING
FECHA: 2026-03-10
PROYECTO: pronto-employees
SEVERIDAD: media
TITULO: SSR employees no expone `/{scope}/authorization-error` y rompe deep links scoped de error
DESCRIPCION: El shell SSR employees exponía solo `/authorization-error`, mientras frontend/tests ya usan deep links scope-aware como `/chef/authorization-error` y `/cashier/authorization-error`. Además, un redirect SSR seguía apuntando al path sin scope.
PASOS_REPRODUCIR:
1. Abrir `/chef/authorization-error?...` o `/cashier/authorization-error?...`.
2. Observar que no se renderiza correctamente `Acceso Denegado` o se desvía al dashboard raíz.
RESULTADO_ACTUAL: Resuelto.
RESULTADO_ESPERADO: `/{scope}/authorization-error` debe renderizar la página de error y conservar el scope.
UBICACION:
- pronto-employees/src/pronto_employees/app.py
EVIDENCIA:
- `scoped-authorization-error.spec.ts` pasó 2/2 tras el fix.
- `authorization-error-scope.spec.ts` pasó 2/2 tras el fix.
HIPOTESIS_CAUSA: Faltaba alias SSR scope-aware y un redirect SSR seguía usando `/authorization-error` sin scope.
ESTADO: RESUELTO
SOLUCION:
- Se añadió la ruta SSR `/<scope>/authorization-error`.
- El redirect SSR de acceso denegado ahora apunta a `/{scope}/authorization-error?...`.
- Se reinició `pronto-app-employees-1` y se validaron ambos specs Playwright de rutas scoped de error.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

