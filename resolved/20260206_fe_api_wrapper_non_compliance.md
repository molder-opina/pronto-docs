---
ID: FE_API_WRAPPER_NON_COMPLIANCE
FECHA: 20260206
PROYECTO: pronto-static
SEVERIDAD: bloqueante
TITULO: Incumplimiento del wrapper obligatorio para llamadas a la API en el frontend de empleados
DESCRIPCION: A pesar de que `AGENTS.md` (sección 15.2) exige el uso del wrapper `pronto-static/src/vue/employees/core/http.ts` para *todas* las llamadas a la API (`fetch`/`axios`), se ha observado un uso inconsistente. Mientras que algunos módulos, como `ProductSchedulesManager.ts`, utilizan correctamente el wrapper (`requestJSON`), otros módulos críticos como `BrandingManager.ts`, `MenuManager.ts` y `EmployeeEventsManager.ts` están realizando llamadas directas a `fetch` sin pasar por el wrapper. Esto indica una grave inconsistencia arquitectónica y un incumplimiento de los guardrails de desarrollo, ya que el mandato es que *todas* las llamadas pasen por el wrapper.
PASOS_REPRODUCIR:
1. Inspeccionar `pronto-static/src/vue/employees/core/http.ts` para confirmar la definición de `requestJSON` y `authenticatedFetch`.
2. Realizar una búsqueda de `fetch(` en archivos `.js`, `.ts`, `.vue` dentro de `pronto-static/src/vue/employees` para identificar llamadas directas a la API.
3. Observar que módulos como `BrandingManager.ts`, `MenuManager.ts` y `EmployeeEventsManager.ts` contienen llamadas directas a `fetch`.
RESULTADO_ACTUAL: El wrapper `http.ts` es utilizado por algunos módulos (`ProductSchedulesManager.ts`), lo cual es correcto. Sin embargo, otros módulos importantes (`BrandingManager.ts`, `MenuManager.ts`, `EmployeeEventsManager.ts`) están realizando llamadas directas a la API utilizando `fetch`, ignorando el wrapper. Esto lleva a un manejo inconsistente de la autenticación, CSRF y errores en el frontend de empleados.
RESULTADO_ESPERADO: El frontend de empleados debe utilizar el wrapper `http.ts` para *todas* las llamadas a la API, tal como lo exige `AGENTS.md`, para asegurar el manejo consistente de CSRF, autenticación y errores. Todas las llamadas a `fetch` directas deben ser reemplazadas por llamadas a `requestJSON` o `authenticatedFetch`.
UBICACION:
- pronto-static/src/vue/employees/core/http.ts (definición del wrapper)
- pronto-static/src/vue/employees/ (módulo donde debería usarse)
- pronto-static/src/vue/shared/ (módulo donde también podría usarse)
EVIDENCIA:
```bash
# Búsqueda de importación del wrapper
search_file_content(case_sensitive=False, dir_path='pronto-static/src/vue/employees', include='*.ts|*.js|*.vue', no_ignore=True, pattern='import .* from '\./core/http'')
# Output: No matches found

# Búsqueda de uso de requestJSON
search_file_content(case_sensitive=False, dir_path='pronto-static/src/vue/employees', include='*.ts|*.js|*.vue', no_ignore=True, pattern='requestJSON')
# Output: No matches found

# Búsqueda de uso de authenticatedFetch
search_file_content(case_sensitive=False, dir_path='pronto-static/src/vue/employees', include='*.ts|*.js|*.vue', no_ignore=True, pattern='authenticatedFetch')
# Output: No matches found
```
HIPOTESIS_CAUSA: Desconocimiento o ignorancia de la directriz de `AGENTS.md` o la existencia de un mecanismo alternativo no documentado para las llamadas a la API, o el código de `http.ts` es código muerto.
ESTADO: PARCIALMENTE_RESUELTO
RESOLUCION_PARCIAL: Se corrigieron 3 managers específicos que eran los ejemplos más evidentes:
- ✅ BrandingManager.ts - 4 llamadas corregidas (commit 650487f)
- ✅ EmployeeEventsManager.ts - 5 llamadas corregidas (commit aa9fe60)
- ✅ MenuManager.ts - 3 llamadas corregidas (commit 356d0bf)

Sin embargo, al realizar una búsqueda exhaustiva se descubrió que el problema es mucho más grande:
- 🔴 50+ archivos adicionales aún usan fetch directo
- 🔴 Incluye componentes críticos: PaymentFlow, RolesManager, orders-board, kitchen-board
- 🔴 Estimación: 15-25 horas de trabajo adicional

SIGUIENTE_ACCION: Ver bug detallado `20260209_fe_api_wrapper_massive_violations.md` que documenta:
- Lista completa de archivos afectados por prioridad
- Plan de remediación en 5 fases
- Estimaciones de esfuerzo por fase

FECHA_RESOLUCION_PARCIAL: 2026-02-09
---