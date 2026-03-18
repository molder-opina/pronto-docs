ID: PRONTO-PAY-011
FECHA: 2026-03-15
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: Validación de estado legacy "ATRASADO" indica migración incompleta
DESCRIPCION: La validación explícita en order_models.py líneas 468-469 rechaza el estado "ATRASADO", lo que indica que previamente existía este estado en el sistema pero fue eliminado durante una migración. Esta validación sugiere que la migración de estados no se completó limpiamente y podría haber inconsistencias residuales.
PASOS_REPRODUCIR:
1. Analizar la validación en order_models.py líneas 468-469
2. Observar que se rechaza explícitamente el estado "ATRASADO"
3. Buscar referencias históricas a este estado en el código base
4. Verificar si existen datos en producción con este estado
RESULTADO_ACTUAL: Validación de estado legacy que indica migración incompleta y posibles inconsistencias residuales.
RESULTADO_ESPERADO: Validaciones deben ser limpias y no referenciar estados que ya no existen en el sistema.
UBICACION:
- pronto-libs/src/pronto_shared/models/order_models.py:468-469
EVIDENCIA: La línea 468 contiene: if status == "ATRASADO": raise ValueError("Estado 'ATRASADO' no es válido")
HIPOTESIS_CAUSA: Durante la migración de estados legacy a la máquina de estados canónica, se eliminó el estado "ATRASADO" pero se mantuvo la validación para evitar regresiones, sin limpiar completamente el código.
ESTADO: ABIERTO