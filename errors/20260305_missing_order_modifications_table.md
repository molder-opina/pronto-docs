ID: TEST-004
FECHA: 2026-03-05
PROYECTO: pronto-tests
SEVERIDAD: alta
TITULO: Tabla pronto_order_modifications no existe en la base de datos
DESCRIPCION: Los tests de order_modification_service fallan porque la tabla pronto_order_modifications no existe en la base de datos de producción.
PASOS_REPRODUCIR:
1. Ejecutar tests de test_order_modification_service.py
2. Observar ProgrammingError: "relation pronto_order_modifications does not exist"
RESULTADO_ACTUAL: La tabla no existe
RESULTADO_ESPERADO: La tabla debería existir o los tests deberían ser skipados
UBICACION: Base de datos PostgreSQL, pronto-libs/src/pronto_shared/models
EVIDENCIA: 4 tests fallan con UndefinedTable error
HIPOTESIS_CAUSA: La tabla nunca fue creada o la migración no se aplicó
ESTADO: ABIERTO
