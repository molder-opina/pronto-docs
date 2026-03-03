# Error: Magic String en payments.py

**ID**: BUG-20260226-CODE-03
**FECHA**: 2026-02-26
**PROYECTO**: pronto-api
**SEVERIDAD**: baja (P2)
**TITULO**: Uso de magic string "paid" además de SessionStatus.PAID.value
**DESCRIPCION**: |
  Gate H de Order State Authority flagló uso de string "paid" en payments.py:77.
  Debe usarse exclusivamente constantes de constants.py para consistencia.
**PASOS_REPRODUCIR**:
  1. rg "['\"](new|queued|preparing|ready|delivered|paid|cancelled)['\"]" pronto-api/src
**RESULTADO_ACTUAL**: payments.py:77 usa "paid" además de SessionStatus.PAID.value
**RESULTADO_ESPERADO**: Solo constantes de constants.py
**UBICACION**: pronto-api/src/api_app/routes/payments.py:77
**HIPOTESIS_CAUSA**: Código copy-paste o refactor incompleto
**ESTADO**: RESUELTO
**SOLUCION**: Eliminado magic string "paid", ahora usa solo SessionStatus.PAID.value
**COMMIT**: N/A
**FECHA_RESOLUCION**: 2026-02-26
