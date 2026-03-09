ID: TEST-20260306-027
FECHA: 2026-03-06
PROYECTO: pronto-libs,pronto-tests
SEVERIDAD: alta
TITULO: create_menu_item llama a API removida de DayPeriodService
DESCRIPCION:
  `menu_service_impl.py` llamaba `DayPeriodService.update_item_periods(...)`, API ausente.
ESTADO: RESUELTO
SOLUCION:
  Se restauró una implementación compatible en `DayPeriodService` para reemplazar asignaciones de
  recommendation periods usando `MenuItemDayPeriod` y defaults canónicos.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
