ID: NAMING-20260309-001
FECHA: 2026-03-09
PROYECTO: monorepo
SEVERIDAD: media
TITULO: Inconsistencias transversales de nomenclatura de archivos y scripts en el monorepo
DESCRIPCION:
Se detectaron múltiples archivos fuente propios con nomenclatura inconsistente respecto al canon vigente en AGENTS.md. Los hallazgos incluyen scripts shell con guiones bajos, módulos TypeScript/JavaScript con camelCase o snake_case, scripts Python de tooling con guiones y un canon insuficientemente preciso para distinguir archivos fuente, archivos canónicos de tooling y excepciones históricas/generadas.
PASOS_REPRODUCIR:
1. Auditar AGENTS.md sección 0.7.
2. Inventariar archivos trackeados por repo (`pronto-scripts`, `pronto-static`, `pronto-tests`, etc.).
3. Buscar nombres fuera del patrón esperado por tipo de archivo.
RESULTADO_ACTUAL:
Existían violaciones activas de naming en archivos fuente y no había un validador canónico para enforcement consistente.
RESULTADO_ESPERADO:
Todo archivo propio del proyecto debe cumplir un estándar explícito por categoría o estar cubierto por una excepción canónica documentada; además debe existir un checker reutilizable para enforcement no destructivo.
UBICACION:
AGENTS.md
pronto-scripts/bin/
pronto-static/src/vue/
pronto-tests/tests/
EVIDENCIA:
- `pronto-scripts/bin/apply_migration.sh`
- `pronto-scripts/bin/lib/docker_runtime.sh`
- `pronto-static/src/vue/shared/composables/useTables.ts`
- `pronto-static/src/vue/shared/utils/useBreakpoints.ts`
- `pronto-tests/tests/functionality/e2e/chef_notifications.spec.ts`
HIPOTESIS_CAUSA:
El canon actual de AGENTS.md cubre categorías generales, pero no distingue suficientemente excepciones obligatorias del ecosistema (README.md, Dockerfile, package roots Python, artefactos generados, logs históricos) ni provee un checker operativo. Eso permitió acumulación de nombres mixtos por repo.
ESTADO: RESUELTO
SOLUCION:
Se endureció el canon en `AGENTS.md` y `pronto-scripts/pronto-root/AGENTS.md`, se añadió el checker `./pronto-scripts/bin/pronto-file-naming-check`, se integró a `pre-commit-ai`, y se normalizaron por lotes seguros los nombres fuera de estándar en `pronto-static`, `pronto-tests`, `pronto-scripts`, `pronto-employees`, `pronto-client` y `pronto-docs`, actualizando además sus referencias activas.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09

