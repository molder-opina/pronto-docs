ID: TEST-005
FECHA: 2026-03-05
PROYECTO: pronto-tests
SEVERIDAD: alta
TITULO: get_session en servicios no funciona sin app context
DESCRIPCION: Los servicios como menu_service.py, order_service.py usan get_session() que requiere que el engine de BD esté inicializado con init_engine(). Los tests que llaman directamente a estos servicios fallan con "Session factory unavailable. Call init_engine first."
PASOS_REPRODUCIR:
1. Ejecutar test que llame a create_menu_item sin flask_app
2. Observar RuntimeError: "Session factory unavailable"
RESULTADO_ACTUAL: get_session() lanza RuntimeError
RESULTADO_ESPERADO: Los servicios deberían funcionar en contexto de tests
UBICACION: pronto-libs/src/pronto_shared/db.py, servicios en pronto-libs
EVIDENCIA: 17 tests de menu_validation.py fallan
HIPOTESIS_CAUSA: Los servicios dependen del engine inicializado globalmente pero los tests no lo inicializan
ESTADO: ABIERTO
