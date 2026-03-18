ID: PRONTO-PAY-031
FECHA: 2026-03-15
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: Tests faltantes para validación de configuración inválida
DESCRIPCION: No existen tests que validen la configuración inválida de permisos de pago (enable_cashier_role=false y allow_waiter_cashier_operations=false). Aunque la función validate_payment_configuration() existe y tiene tests unitarios, no hay tests que verifiquen que esta validación se aplique en los endpoints de configuración o en la inicialización del sistema.
PASOS_REPRODUCIR:
1. Buscar tests que validen la configuración inválida en endpoints de configuración
2. Verificar que no existen tests que intenten guardar configuraciones inválidas
3. Observar que solo existen tests unitarios para la función de validación
4. Confirmar que no hay tests de integración que validen el comportamiento completo
RESULTADO_ACTUAL: Sin cobertura de tests para la validación de configuración inválida en el contexto real del sistema, lo que puede permitir configuraciones inconsistentes en producción.
RESULTADO_ESPERADO: Deben existir tests que validen que la configuración inválida sea rechazada en todos los puntos de entrada del sistema (endpoints de configuración, inicialización, etc.).
UBICACION:
- pronto-tests/tests/unit/test_payment_permission_service.py (solo tests unitarios)
- pronto-tests/tests/integration/ (falta cobertura)
- pronto-tests/tests/e2e/ (falta cobertura)
EVIDENCIA: El análisis de la suite de tests muestra que solo existen tests unitarios para la función de validación, pero no hay tests que verifiquen su aplicación en el contexto real del sistema.
HIPOTESIS_CAUSA: Los tests de integración y E2E fueron considerados de menor prioridad o se postergaron para una fase posterior que nunca se implementó.
ESTADO: ABIERTO