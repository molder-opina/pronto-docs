---
ID: PARITY_CHECK_WRAPPER_NOT_FOUND
FECHA: 20260228
PROYECTO: pronto-scripts / pronto-ai
SEVERIDAD: media
TITULO: Fallo en auditoría de paridad de API (Employees) por ruta de wrapper HTTP incorrecta
DESCRIPCION: El script `pronto-api-parity-check employees` falla inmediatamente con el error `WRAPPER_NOT_FOUND`. El script busca el wrapper en `/Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/core/http.ts`, pero el archivo fue movido durante una refactorización reciente (posiblemente a `pronto-static/src/vue/employees/shared/core/http.ts` o `pronto_shared/static/js/src/core/http.ts`).
PASOS_REPRODUCIR:
1. Ejecutar `./pronto-scripts/bin/pronto-api-parity-check employees`.
RESULTADO_ACTUAL: El script falla y aborta la validación de paridad.
RESULTADO_ESPERADO: El script debe poder localizar el wrapper HTTP correcto y analizar todas las llamadas API del frontend de empleados.
UBICACION:
- pronto-scripts/bin/pronto-api-parity-check (configuración interna o allowlist).
HIPOTESIS_CAUSA: La lista "hardcodeada" de rutas de wrappers en la herramienta de validación de paridad quedó desactualizada tras la refactorización de `pronto-static` y la modularización de `pronto_shared`.
ESTADO: RESUELTO
SOLUCION: Se validó y dejó activo el soporte multi-ruta del wrapper en `pronto-scripts/lib/api_parity_check.py` (incluye `pronto-static/src/vue/employees/shared/core/http.ts`). El comando `./pronto-scripts/bin/pronto-api-parity-check employees` ejecuta correctamente y reporta `ok: true`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-04
---
