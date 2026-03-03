ID: 20260213_client_menu_business_info_failures
FECHA: 2026-02-13
PROYECTO: pronto-client, pronto-libs
SEVERIDAD: bloqueante
TITULO: /api/menu devuelve 404 y /api/business-info devuelve 500 en cliente
DESCRIPCION: En el host de clientes (localhost:6080) la UI falla al cargar menú y horarios por dos causas: falta de endpoint /api/menu en pronto-client y desacople entre modelo BusinessInfo y esquema real de la tabla pronto_business_info.
PASOS_REPRODUCIR: 1) Abrir http://localhost:6080 2) Ver requests XHR a /api/menu y /api/business-info 3) Confirmar respuestas 404 y 500.
RESULTADO_ACTUAL: /api/menu -> 404 Recurso no encontrado; /api/business-info -> 500 Error de base de datos (UndefinedColumn: pronto_business_info.business_name).
RESULTADO_ESPERADO: /api/menu y /api/business-info deben responder 200 con estructura válida para frontend de clientes.
UBICACION: pronto-client/src/pronto_clients/routes/api/__init__.py, pronto-client/src/pronto_clients/routes/api/business_info.py, pronto-libs/src/pronto_shared/models.py, pronto-libs/src/pronto_shared/services/business_info_service.py
EVIDENCIA: curl http://localhost:6080/api/menu -> 404; curl http://localhost:6080/api/business-info -> 500; logs de pronto-client muestran sqlalchemy.exc.ProgrammingError por columna business_name inexistente.
HIPOTESIS_CAUSA: Refactor incompleto: se eliminó/no registró la ruta de menú en client y se migró el modelo BusinessInfo a nombres de columnas no presentes en la base actual.
ESTADO: RESUELTO
SOLUCION: Se implementó y registró la ruta faltante /api/menu en pronto-client, se corrigió el desempaquetado de respuestas en business_info, se alinearon modelos/servicios de pronto-libs con el esquema real de base de datos (BusinessInfo, MenuCategory, BusinessConfig, DayPeriod, MenuItemDayPeriod, BusinessSchedule) y se corrigió el consumo de DayPeriodService en menu_service.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-13
