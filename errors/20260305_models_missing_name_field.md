ID: TEST-003
FECHA: 2026-03-05
PROYECTO: pronto-tests
SEVERIDAD: alta
TITULO: Modelos Employee y Customer no tienen campo 'name'
DESCRIPCION: Los modelos Employee y Customer en user_models.py usan campos separados first_name y last_name, no un campo 'name' único como esperan los tests legacy y fixtures old.
PASOS_REPRODUCIR:
1. Intentar crear Employee con employee.name = "John Doe"
2. Observar AttributeError o error de campo inexistente
RESULTADO_ACTUAL: El campo 'name' no existe en los modelos
RESULTADO_ESPERADO: Los modelos deberían tener el campo 'name' o los tests deberían usar first_name/last_name
UBICACION: pronto-libs/src/pronto_shared/models/user_models.py
EVIDENCIA: Tests test_create_employee, test_create_customer fallan porque usan .name
HIPOTESIS_CAUSA: Los modelos fueron refactorizados para usar first_name/last_name pero el código legacy usa 'name'
ESTADO: ABIERTO
