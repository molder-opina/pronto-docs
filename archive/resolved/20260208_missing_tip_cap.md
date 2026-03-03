---
ID: ERR-20260208-018
FECHA: 2026-02-08
PROYECTO: pronto-shared / pronto-client
SEVERIDAD: baja
TITULO: Ausencia de límite máximo (Cap) en validación de propinas
DESCRIPCION: Los endpoints de confirmación de propina (/confirm-tip y /tip) validan que el monto sea no-negativo, pero no imponen un límite máximo razonable (ej. 100% del subtotal). Esto permite errores humanos de captura (fat-finger) donde se ingresan montos astronómicos que rompen el balance de la sesión y generan cargos incorrectos.
PASOS_REPRODUCIR:
1) Tener una cuenta de $100.
2) Enviar un monto de propina de $999,999.
RESULTADO_ACTUAL: El sistema acepta el monto y recalcula el total de la sesión sin rechistar.
RESULTADO_ESPERADO: El sistema debe advertir o rechazar propinas que excedan un porcentaje configurable (ej. 30% requiere confirmación extra, 100% es el límite duro).
UBICACION: pronto-libs/src/pronto_shared/services/order_service.py y pronto-client/src/pronto_clients/routes/api/payments.py
EVIDENCIA: Función calculate_tip_amount solo hace validación de signo.
HIPOTESIS_CAUSA: Validación básica implementada sin considerar reglas de negocio de prevención de errores.
ESTADO: PENDIENTE
---
PLAN DE SOLUCION:
1. Definir una constante TIP_MAX_PERCENTAGE = 100 en pronto_shared.constants.
2. Implementar validación en calculate_tip_amount que lance OrderValidationError si se excede el límite.
3. Actualizar el frontend para mostrar una alerta si el monto parece inusualmente alto.
