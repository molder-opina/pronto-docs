---
ID: ERR-20260205-ROUTER-HASH-MISMATCH
FECHA: 2026-02-05
PROYECTO: pronto-ai
SEVERIDAD: alta
TITULO: Router-Hash en AGENTS.md no coincide con pronto-ai/router.yml
DESCRIPCION: El gate pronto-rules-check falla porque el Router-Hash documentado no coincide con el hash SHA256 real de pronto-ai/router.yml. Esto bloquea validaciones precommit.
PASOS_REPRODUCIR: 1) Ejecutar ./pronto-scripts/bin/pronto-rules-check. 2) Observar error Router-Hash mismatch.
RESULTADO_ACTUAL: ERROR: Router-Hash does not match router.yml.
RESULTADO_ESPERADO: Router-Hash en AGENTS.md debe reflejar el SHA256 actual de pronto-ai/router.yml.
UBICACION: AGENTS.md; agents.md; pronto-ai/router.yml; pronto-scripts/bin/pronto-rules-check
EVIDENCIA: AGENTS.md contiene Router-Hash 6b192a... pero sha256(pronto-ai/router.yml)=662348eb...
HIPOTESIS_CAUSA: Se modifico pronto-ai/router.yml sin actualizar Router-Hash en AGENTS.md.
ESTADO: RESUELTO
---

SOLUCION: Se recalculo y actualizo Router-Hash en AGENTS.md/agents.md para que coincida con sha256(pronto-ai/router.yml).
COMMIT: bbda2ea
FECHA_RESOLUCION: 2026-02-05
