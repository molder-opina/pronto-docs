---
ID: ERR-20260205-PRECOMMIT-CONTRACT-BLOCK
FECHA: 2026-02-05
PROYECTO: pronto-scripts
SEVERIDAD: media
TITULO: pre-commit-ai bloquea cambios en contratos aun con aprobacion explicita
DESCRIPCION: El hook pronto-scripts/bin/pre-commit-ai marca cualquier cambio bajo pronto-ai/ o pronto-docs/contracts como inconsistencia y falla el commit, incluso cuando el cambio es requerido (ej. migracion de roles super_admin -> system).
PASOS_REPRODUCIR: 1) Staging de un archivo en pronto-ai/ (ej. git add pronto-ai/AGENTS.md). 2) Ejecutar ./pronto-scripts/bin/pre-commit-ai. 3) Observar exit 1 por "contrato modificado".
RESULTADO_ACTUAL: No es posible commitear cambios en contratos; el hook falla siempre.
RESULTADO_ESPERADO: Bloquear por default, pero permitir con aprobacion explicita (ej. PRONTO_ALLOW_CONTRACT_CHANGES=1) dejando evidencia en el reporte.
UBICACION: pronto-scripts/bin/pre-commit-ai
EVIDENCIA: Regla "Contratos modificados" agrega inconsistencia a todos los archivos pronto-ai/ y pronto-docs/contracts.
HIPOTESIS_CAUSA: La regla de contratos se implemento como error duro sin bypass.
ESTADO: RESUELTO
---

SOLUCION: Se agrego bypass explicito via PRONTO_ALLOW_CONTRACT_CHANGES=1 para que los cambios en pronto-ai/ y pronto-docs/contracts no bloqueen el commit, manteniendo bloqueo por default.
COMMIT: multi:4e58d9f,3b7c910
FECHA_RESOLUCION: 2026-02-05
