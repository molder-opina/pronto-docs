---
ID: ERR-20260204-MAC-REBUILD-BUILD
FECHA: 2026-02-04
PROYECTO: pronto-scripts
SEVERIDAD: media
TITULO: mac/rebuild.sh busca scripts npm en root incorrecto
DESCRIPCION: El script intenta ejecutar build:clients/build:employees en el root del monorepo, pero esos scripts viven en pronto-static/package.json. Esto bloquea el redeploy.
PASOS_REPRODUCIR: 1) Ejecutar pronto-scripts/bin/mac/rebuild.sh client. 2) Ver error Missing script: build:clients.
RESULTADO_ACTUAL: npm falla al no encontrar scripts en root.
RESULTADO_ESPERADO: Debe ejecutar npm build dentro de pronto-static.
UBICACION: pronto-scripts/bin/mac/rebuild.sh:67-75
EVIDENCIA: npm error Missing script: build:clients.
HIPOTESIS_CAUSA: Directorio de trabajo incorrecto para builds Vue.
ESTADO: RESUELTO
SOLUCION: Se ajusto mac/rebuild.sh para ejecutar builds de Vue en pronto-static.
COMMIT: uncommitted
FECHA_RESOLUCION: 2026-02-04
---
