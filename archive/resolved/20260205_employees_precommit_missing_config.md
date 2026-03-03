---
ID: ERR-20260205-EMPLOYEES-PRECOMMIT-NO-CONFIG
FECHA: 2026-02-05
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: No se puede commitear en pronto-employees por falta de .pre-commit-config.yaml
DESCRIPCION: El repo pronto-employees tiene pre-commit instalado como hook de git, pero no existe archivo .pre-commit-config.yaml. Cualquier git commit falla con el error \"No .pre-commit-config.yaml file was found\".
PASOS_REPRODUCIR: 1) Entrar a pronto-employees. 2) Hacer git commit. 3) Ver que pre-commit aborta por falta de config.
RESULTADO_ACTUAL: Commit bloqueado.
RESULTADO_ESPERADO: Commit permitido; si no hay hooks locales, el config debe existir (repos: []) o debe haber una config real.
UBICACION: pronto-employees/.git/hooks/pre-commit (invoca pre-commit)
EVIDENCIA: Output: \"No .pre-commit-config.yaml file was found\".
HIPOTESIS_CAUSA: Hook instalado sin agregar config al repo.
ESTADO: RESUELTO
---

SOLUCION: Se agrego un archivo .pre-commit-config.yaml minimo (repos: []) para que el hook pre-commit no bloquee commits por falta de configuracion.
COMMIT: 93f5b7a
FECHA_RESOLUCION: 2026-02-05
