---
ID: ERR-20260204-EMPLOYEES-DOCKERFILE
FECHA: 2026-02-04
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: Dockerfile de employees ausente en ruta declarada
DESCRIPCION: docker-compose.yml referencia pronto-employees/src/pronto_employees/Dockerfile, pero el archivo no existe. El redeploy de employees falla.
PASOS_REPRODUCIR: 1) Ejecutar docker compose build employees. 2) Ver error de Dockerfile no encontrado.
RESULTADO_ACTUAL: Build de employees falla con no
