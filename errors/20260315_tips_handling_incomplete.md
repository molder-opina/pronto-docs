ID: PRONTO-PAY-035
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: media
TITULO: Manejo incompleto de propinas sin validación adecuada
DESCRIPCION: El sistema permite agregar propinas pero no valida adecuadamente los montos o porcentajes, lo que puede permitir propinas negativas, cero, o excesivamente altas. Además, no está claro cómo se integran las propinas con los pagos parciales y la lógica de cierre de sesiones.
PASOS_REPRODUCIR:
1. Crear una sesión y procesar un pago parcial
2. Intentar agregar una propina negativa
3. Intentar agregar una propina cero
4. Intentar agregar una propina excesivamente alta (ej. 1000%)
5. Observar si se permiten estas operaciones inválidas
RESULTADO_ACTUAL: Propinas sin validación adecuada de montos o porcentajes, lo que puede permitir operaciones financieras inválidas y causar inconsistencias en los totales.
RESULTADO_ESPERADO: Todas las propinas deben validar que el monto o porcentaje sea positivo, razonable, y se integre adecuadamente con la lógica de pagos parciales y cierre de sesiones.
UBICACION:
- pronto-api/src/api_app/routes/employees/sessions.py:264-284 (agregar propina)
- pronto-libs/src/pronto_shared/models/order_models.py (cálculo de totales)
EVIDENCIA: El análisis del código muestra que la función para agregar propinas no valida adecuadamente los montos o porcentajes, lo que puede permitir operaciones financieras inválidas.
HIPOTESIS_CAUSA: La implementación inicial se enfocó en la funcionalidad básica sin considerar adecuadamente la necesidad de validación de propinas para garantizar la integridad financiera.
ACTUALIZACION_2026-03-18:
- Resuelto: Se refactorizó `calculate_tip_amount` para incluir validaciones estrictas:
    - No se permiten montos ni porcentajes negativos.
    - Se aplica el límite de `TIP_MAX_PERCENT` (50%) del subtotal.
    - Se aplica el límite de `TIP_MAX_FIXED_AMOUNT` ($5000) incluso para cálculos basados en porcentaje.
- Resuelto: Se añadió manejo de errores en `apply_tip` para capturar y retornar mensajes claros al frontend.
ESTADO: RESUELTO