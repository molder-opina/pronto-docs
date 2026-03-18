ID: PRONTO-PAY-039
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: alta
TITULO: Conciliación financiera incompleta sin mecanismos de verificación
DESCRIPCION: El sistema no implementa mecanismos adecuados de conciliación financiera para verificar la consistencia entre los totales calculados y los pagos procesados. No existen funciones o endpoints para verificar que remaining_balance = total_amount - total_paid en todos los momentos, lo que puede permitir inconsistencias financieras no detectadas.
PASOS_REPRODUCIR:
1. Crear una sesión con múltiples órdenes
2. Procesar pagos parciales
3. Modificar manualmente algún campo financiero (simulando corrupción de datos)
4. Observar si el sistema detecta la inconsistencia
5. Verificar si existen mecanismos de conciliación financiera
RESULTADO_ACTUAL: Sin mecanismos adecuados de conciliación financiera para detectar y corregir inconsistencias entre totales calculados y pagos procesados.
RESULTADO_ESPERADO: Deben existir mecanismos de conciliación financiera que verifiquen periódicamente la consistencia entre totales calculados y pagos procesados, y alerten o corrijan automáticamente las inconsistencias detectadas.
UBICACION:
- pronto-libs/src/pronto_shared/models/order_models.py (cálculo de totales)
- pronto-libs/src/pronto_shared/services/payment_service.py (procesamiento de pagos)
- pronto-api/src/api_app/routes/ (falta endpoints de conciliación)
EVIDENCIA: El análisis del código muestra que no existen funciones o endpoints dedicados a la conciliación financiera, lo que puede permitir inconsistencias financieras no detectadas.
HIPOTESIS_CAUSA: La implementación inicial se enfocó en la funcionalidad básica sin considerar la necesidad de mecanismos de conciliación financiera para garantizar la integridad de los datos.
ESTADO: ABIERTO