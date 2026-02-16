---
ID: ERR-20260205-PRECOMMIT-ADD-INCONSISTENCIA-MISSING
FECHA: 2026-02-05
PROYECTO: pronto-scripts
SEVERIDAD: bloqueante
TITULO: pre-commit hook falla por funcion add_inconsistencia inexistente
DESCRIPCION: El hook .git/hooks/pre-commit define la funcion add_inconsistency pero invoca add_inconsistencia en multiples reglas. Esto rompe el pre-commit y bloquea cualquier commit.
PASOS_REPRODUCIR: 1) Hacer git commit con archivos staged. 2) Ver error \".git/hooks/pre-commit: line ...: add_inconsistencia: command not found\".
RESULTADO_ACTUAL: No se puede commitear por fallo del hook.
RESULTADO_ESPERADO: El hook debe ejecutar y reportar inconsistencias correctamente (exit 0 si OK, exit 1 si inconsistencia).
UBICACION: .git/hooks/pre-commit
EVIDENCIA: define add_inconsistency() pero usa add_inconsistencia en el resto del script.
HIPOTESIS_CAUSA: Cambio parcial de nombre de funcion (ingles/espanol) sin refactor completo.
ESTADO: RESUELTO
---

SOLUCION: Se normalizo el nombre de la funcion a add_inconsistencia() para que coincida con todas las invocaciones existentes.
COMMIT: b1b4855
FECHA_RESOLUCION: 2026-02-05

