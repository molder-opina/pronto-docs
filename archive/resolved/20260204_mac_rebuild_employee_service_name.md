---
ID: ERR-20260204-MAC-REBUILD-EMPLOYEE
FECHA: 2026-02-04
PROYECTO: pronto-scripts
SEVERIDAD: media
TITULO: mac/rebuild.sh usa nombre de servicio incorrecto para empleados
DESCRIPCION: El script intenta reconstruir el servicio "employee", pero en docker-compose.yml el nombre es "employees". El redeploy falla con "no such service: employee".
PASOS_REPRODUCIR: 1) Ejecutar pronto-scripts/bin/mac/rebuild.sh employee. 2) Ver error no such service.
RESULTADO_ACTUAL: No se reconstruye el servicio de empleados.
RESULTADO_ESPERADO: Debe apuntar al servicio "employees" del compose.
UBICACION: pronto-scripts/bin/mac/rebuild.sh:38-50 y loop de build.
EVIDENCIA: docker-compose.yml define "employees".
HIPOTESIS_CAUSA: Inconsistencia entre alias interno y nombre real del servicio.
ESTADO: RESUELTO
SOLUCION: Se agrego mapeo de compose_service para usar "employees" en docker compose.
COMMIT: uncommitted
FECHA_RESOLUCION: 2026-02-04
---
