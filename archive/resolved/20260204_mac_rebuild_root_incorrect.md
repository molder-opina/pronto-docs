---
ID: ERR-20260204-MAC-REBUILD-ROOT
FECHA: 2026-02-04
PROYECTO: pronto-scripts
SEVERIDAD: alta
TITULO: mac/rebuild.sh usa root incorrecto y rompe redeploy
DESCRIPCION: El script pronto-scripts/bin/mac/rebuild.sh calcula PROJECT_ROOT como pronto-scripts/, causando que busque .env y docker-compose.yml en rutas inexistentes. Esto detiene el redeploy y deja servicios abajo.
PASOS_REPRODUCIR: 1) Ejecutar pronto-scripts/bin/mac/rebuild.sh api. 2) Observar errores de env file y Dockerfile.
RESULTADO_ACTUAL: Falla con errores de env file o Dockerfile no encontrado.
RESULTADO_ESPERADO: Debe usar el root del monorepo y encontrar docker-compose.yml y .env.
UBICACION: pronto-scripts/bin/mac/rebuild.sh:7-14
EVIDENCIA: PROJECT_ROOT apunta a pronto-scripts; docker-compose.yml no existe en esa ruta.
HIPOTESIS_CAUSA: Calculo de rutas relativo no ajustado para carpeta bin/mac.
ESTADO: RESUELTO
SOLUCION: Se corrigio PROJECT_ROOT para apuntar al root del monorepo en mac/rebuild.sh.
COMMIT: uncommitted
FECHA_RESOLUCION: 2026-02-04
---
