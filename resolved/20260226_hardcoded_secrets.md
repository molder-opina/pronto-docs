# Error: Secretos Hardcodeados en Scripts de Verificación

**ID**: BUG-20260226-SEC-01
**FECHA**: 2026-02-26
**PROYECTO**: pronto-scripts
**SEVERIDAD**: alta (P1)
**TITULO**: Secretos hardcodeados en scripts de verificación
**DESCRIPCION**: |
  Se encontraron secretos hardcodeados en scripts de verificación/prueba.
  Esto viola las políticas de seguridad de AGENTS.md.
**PASOS_REPRODUCIR**:
  1. rg "PRONTO_INTERNAL_SECRET.*=" pronto-scripts
**RESULTADO_ACTUAL**: 
  - verify_split_bill.py:línea 16 tiene valor por defecto hardcodeado
  - reproduce_csrf_bff.py:línea 33 tiene valor por defecto hardcodeado
**RESULTADO_ESPERADO**: Secretos solo en variables de entorno, no hardcodeados
**UBICACION**: 
  - pronto-scripts/bin/python/verify_split_bill.py:16
  - pronto-scripts/bin/tests/reproduce_csrf_bff.py:33
**HIPOTESIS_CAUSA**: Scripts de debug/test lasciados con valores por defecto
**ESTADO**: RESUELTO
**EVIDENCIA**:
```
pronto-scripts/bin/python/verify_split_bill.py:16:PRONTO_INTERNAL_SECRET = os.getenv("PRONTO_INTERNAL_SECRET", "120d88e0cea0c97975e99901650132968f1b554c76d16814eeef2c4ce905aa89")
pronto-scripts/bin/tests/reproduce_csrf_bff.py:33:    secret = os.getenv("PRONTO_INTERNAL_SECRET", "120d88e0cea0c97975e99901650132968f1b554c76d16814eeef2c4ce905aa89")
```

**SOLUCION**:
- Se eliminó el fallback hardcodeado de `PRONTO_INTERNAL_SECRET` en `pronto-scripts/bin/python/verify_split_bill.py`.
- Se eliminó el fallback hardcodeado de `PRONTO_INTERNAL_SECRET` en `pronto-scripts/bin/tests/reproduce_csrf_bff.py`.
- Ambos scripts ahora requieren la variable de entorno explícita y fallan de forma segura cuando no está definida.

**COMMIT**: NO_COMMIT_LOCAL
**FECHA_RESOLUCION**: 2026-03-04
