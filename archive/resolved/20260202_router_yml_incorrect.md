---
ID: DOCS-20260202-002
FECHA: 2026-02-02
PROYECTO: pronto-ai
SEVERIDAD: baja
TITULO: router.yml con nombres de archivos incorrectos
DESCRIPCION:
El archivo pronto-ai/router.yml referencia nombres de archivos de documentación incorrectos. En lugar de referenciar las carpetas con README.md, referencia archivos .md directos que no existen en la estructura actual.

PASOS_REPRODUCIR:
1. Abrir pronto-ai/router.yml
2. Verificar las referencias como "pronto-api.md", "pronto-client.md", etc.
3. Listar pronto-docs/pronto-*/ para ver la estructura real

RESULTADO_ACTUAL:
router.yml referencia:
- pronto-api.md (no existe, es pronto-api/README.md)
- pronto-client.md (no existe, es pronto-clients/README.md)
- pronto-employees.md (no existe, es pronto-employees/README.md)
- pronto-static.md (no existe, es pronto-static/README.md)
- pronto-libs.md (no existe, es pronto-libs/README.md)
- pronto-postgresql.md (no existe, es pronto-postgresql/README.md)
- pronto-redis.md (no existe, es pronto-redis/README.md)
- pronto-scripts.md (no existe, es pronto-scripts/README.md)
- pronto-tests.md (no existe, es pronto-tests/README.md)
- pronto-docs.md (no existe, es pronto-docs/README.md)
- pronto-ai.md (no existe, es pronto-ai/README.md)
- pronto-backups.md (no existe, es pronto-backups/README.md)

RESULTADO_ESPERADO:
router.yml debería referenciar las rutas correctas como pronto-api/README.md, pronto-clients/README.md, etc.

UBICACION:
- pronto-ai/router.yml:3-14

EVIDENCIA:
Estructura real: pronto-docs/pronto-*/README.md
Referencias en router.yml: pronto-*.md

HIPOTESIS_CAUSA:
El router.yml fue creado antes de la reorganización de la documentación en carpetas. Cuando se reorganizó la documentación, el archivo router.yml no se actualizó.

ESTADO: RESUELTO
---
