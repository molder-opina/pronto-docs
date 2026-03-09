ID: TEST-20260306-022
FECHA: 2026-03-06
PROYECTO: pronto-libs,pronto-tests
SEVERIDAD: alta
TITULO: BusinessScheduleService consulta columna id inexistente
DESCRIPCION:
  El servicio de horarios consultaba `id` en `pronto_business_schedule`, columna inexistente.
ESTADO: RESUELTO
SOLUCION:
  Se actualizaron los SQL raw y serializadores para usar únicamente `day_of_week`, que es la PK
  canónica del schedule.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
