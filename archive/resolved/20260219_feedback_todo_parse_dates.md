ID: ERR-20260219-FEEDBACK-TODO-PARSE-DATES
FECHA: 2026-02-19
PROYECTO: pronto-api
SEVERIDAD: baja
TITULO: TODO sin resolver en feedback.py para parsing de fechas
DESCRIPCION: Dos funciones de estadisticas de feedback tenian TODO comments para implementar parsing de parametros start/end. Las funciones ignoraban los parametros y siempre usaban 30 dias.
PASOS_REPRODUCIR:
1. Llamar /api/feedback/stats/overall?start=2026-01-01
2. Verificar que el parametro es ignorado
RESULTADO_ACTUAL: Parametros start/end ignorados
RESULTADO_ESPERADO: Parametros start/end parseados para calcular rango de dias
UBICACION: pronto-api/src/api_app/routes/feedback.py:124,142
EVIDENCIA:
```python
# TODO: Parse start/end to days or proper date range
days = 30
```
HIPOTESIS_CAUSA: Implementacion pospuesta
ESTADO: RESUELTO
SOLUCION: Implementado parsing ISO8601 de fechas start/end para calcular dias dinamicamente
COMMIT: pending
FECHA_RESOLUCION: 2026-02-19
