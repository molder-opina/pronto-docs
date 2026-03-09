ID: TEST-20260306-049
FECHA: 2026-03-06
PROYECTO: pronto-tests
SEVERIDAD: baja
TITULO: test de cancel_order wrapper sigue skippeado por harness stale de sesión
DESCRIPCION:
  El test del wrapper `cancel_order` seguía skippeado por una razón histórica de sesiones distintas y
  lazy loading.
ESTADO: RESUELTO
SOLUCION:
  Se activó el test reutilizando `db_session` mediante patch de `order_service_impl.get_session` y
  `business_config_service.get_config_value`, cubriendo la política real de cliente: `NEW` y `QUEUED`
  cancelables, `PREPARING` prohibido. Validación focal: `test_order_state_machine_v2.py` => `8 passed`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
