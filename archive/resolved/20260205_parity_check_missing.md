---
ID: ERR-20260205-PARITY-CHECK-MISSING
FECHA: 2026-02-05
PROYECTO: pronto-scripts
SEVERIDAD: alta
TITULO: Falta script canonico pronto-api-parity-check y routes-only-check
DESCRIPCION: AGENTS.md requiere un parity-check que compare frontend vs backend real por target (employees/clients) usando introspeccion de rutas (app.url_map). Actualmente no existen los scripts canonicos en pronto-scripts/bin.
PASOS_REPRODUCIR: 1) Buscar pronto-scripts/bin/pronto-api-parity-check y pronto-scripts/bin/pronto-routes-only-check. 2) Ver que no existen.
RESULTADO_ACTUAL: No hay gate determinista; comparaciones se hacen manualmente con rg y pueden producir falsos negativos/positivos.
RESULTADO_ESPERADO: Existen scripts canonicos en pronto-scripts/bin que generan salida JSON estable y exit codes para CI.
UBICACION: pronto-scripts/bin/
EVIDENCIA: No existe pronto-scripts/bin/pronto-api-parity-check ni pronto-scripts/bin/pronto-routes-only-check.
HIPOTESIS_CAUSA: El gate fue definido en guardrails pero no se implemento aun.
ESTADO: RESUELTO
---

SOLUCION:
Se implementaron los scripts canonicos `pronto-routes-only-check` y `pronto-api-parity-check` y la libreria `api_parity_check.py` con salida JSON determinista.

COMMIT:
f03ce0b

FECHA_RESOLUCION:
2026-02-05
