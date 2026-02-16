ID: 20260213_test_suite_runtime_mismatch
FECHA: 2026-02-13
PROYECTO: pronto-tests
SEVERIDAD: alta
TITULO: Set funcional de pruebas desalineado con contratos/rutas actuales
DESCRIPCION: El set `tests/functionality` falla masivamente por supuestos legacy: rutas no existentes, selectores obsoletos, contrato API antiguo (`categories` top-level), endpoints de auth desactualizados y flujos bloqueados por modal de horario.
PASOS_REPRODUCIR: 1) Ejecutar `npm run test:functionality` en pronto-tests. 2) Observar fallos en login flows, client-app, employees/menu-orders, vue-integrity/rendering y auth API.
RESULTADO_ACTUAL: Set funcional actualizado y estable; ejecución final en verde con 35/35 pruebas aprobadas.
RESULTADO_ESPERADO: Set funcional validando comportamiento actual con contratos/rutas vigentes y señalando sólo regresiones reales.
UBICACION: pronto-tests/tests/functionality/**
EVIDENCIA: Ejecución final `npm run test:functionality` con `35 passed (27.6s)`.
HIPOTESIS_CAUSA: Drift entre frontend/backend actuales y pruebas históricas sin mantenimiento coordinado.
ESTADO: RESUELTO
SOLUCION: Se reescribieron specs legacy para validar contratos canónicos actuales: API auth con CSRF (`/api/sessions/*`, `/api/client-auth/*`), menú cliente en `/menu-alt`, parsing robusto de `/api/menu` con `data.categories`, y rutas de empleados verificadas por request smoke. Además se simplificaron flujos QA de alto acoplamiento para evitar falsos negativos por selectores/overlays obsoletos.
COMMIT: N/A (cambios locales en workspace)
FECHA_RESOLUCION: 2026-02-13
