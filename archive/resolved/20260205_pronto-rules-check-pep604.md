---
ID: ERR-20260205-PRONTO-RULES-CHECK-PEP604
FECHA: 2026-02-05
PROYECTO: pronto-scripts
SEVERIDAD: alta
TITULO: pronto-rules-check falla por uso de type union (PEP604) en runtime
DESCRIPCION: El script pronto-scripts/bin/pronto-rules-check falla al ejecutarse porque usa anotaciones tipo list[str] | None, incompatibles con el interprete actual. Esto rompe el gate de reglas y bloquea validaciones.
PASOS_REPRODUCIR: 1) Ejecutar ./pronto-scripts/bin/pronto-rules-check en macOS. 2) Observar traceback.
RESULTADO_ACTUAL: Traceback TypeError: unsupported operand type(s) for |: 'types.GenericAlias' and 'NoneType'.
RESULTADO_ESPERADO: El gate pronto-rules-check debe ejecutarse correctamente (o forzar interpreter compatible) sin error de typing.
UBICACION: pronto-scripts/bin/pronto-rules-check:192
EVIDENCIA: TypeError al evaluar "args: list[str] | None" (PEP604) en la firma de _run_gate.
HIPOTESIS_CAUSA: El script se ejecuta con un Python < 3.10 (p.ej. /usr/bin/python3) y las anotaciones no son compatibles.
ESTADO: RESUELTO
---

SOLUCION: Se reemplazo el type union PEP604 en la firma de _run_gate por typing.Optional/typing.List para compatibilidad con Python < 3.10.
COMMIT: d6d62bf
FECHA_RESOLUCION: 2026-02-05
