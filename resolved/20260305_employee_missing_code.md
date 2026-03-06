ID: TEST-008
FECHA: 2026-03-05
PROYECTO: pronto-tests
SEVERIDAD: alta
TITULO: Employee requiere employee_code pero tests no lo proporcionan
DESCRIPCION: El modelo Employee tiene employee_code como campo único no nulable, pero los tests legacy intentaban crear empleados sin especificar este campo, causando errores de integridad.
PASOS_REPRODUCIR:
1. Crear Employee sin employee_code
2. Observar IntegrityError
RESULTADO_ACTUAL: IntegrityError por violar restricción unique
RESULTADO_ESPERADO: El campo debería tener default o los tests deberían proporcionarlo
UBICACION: pronto-libs/src/pronto_shared/models/user_models.py
EVIDENCIA: test_create_employee fallaba
HIPOTESIS_CAUSA: El modelo fue actualizado para requerir employee_code pero tests no se actualizaron
ESTADO: RESUELTO
SOLUCION: Tests actualizados para proporcionar employee_code explícito
COMMIT: N/A
FECHA_RESOLUCION: 2026-03-05
