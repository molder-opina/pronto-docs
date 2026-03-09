ID: TEST-20260306-011
FECHA: 2026-03-06
PROYECTO: pronto-libs,pronto-scripts,pronto-tests
SEVERIDAD: alta
TITULO: Modelo Order referencia served_at pero la BD de pruebas no expone esa columna
DESCRIPCION:
  El modelo `Order` incluía `served_at`, pero pytest estaba apuntando a la base local `pronto`
  en vez de a una `pronto_test` aislada y alineada con el schema canónico.
PASOS_REPRODUCIR:
  1. Crear un `Order(...)` en pytest usando el harness previo.
  2. Observar `UndefinedColumn` sobre `pronto_orders.served_at`.
RESULTADO_ACTUAL:
  Las suites con órdenes reales fallaban durante setup o flush.
RESULTADO_ESPERADO:
  El harness debe ejecutar contra una base `pronto_test` provisionada con init/migrations canónicos.
UBICACION:
  - `pronto-tests/conftest.py`
  - `pronto-scripts/init/sql/**`
EVIDENCIA:
  - La base `pronto` no tenía `served_at`
  - `pronto_test` quedó provisionada con `pending=0 drift=0`
ESTADO: RESUELTO
SOLUCION:
  Se endureció `conftest.py` para rechazar la BD `pronto`, apuntar por default a `pronto_test`
  y validar columnas mínimas del schema. Luego se creó/provisionó `pronto_test` con `pronto-init`
  y `pronto-migrate`, corrigiendo además varios drifts en seeds/migraciones que impedían el alta limpia.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
