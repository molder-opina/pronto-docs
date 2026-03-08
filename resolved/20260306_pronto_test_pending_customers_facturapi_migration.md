ID: TEST-20260306-038
FECHA: 2026-03-06
PROYECTO: pronto-scripts,pronto-libs,pronto-tests
SEVERIDAD: alta
TITULO: pronto_test quedó sin aplicar la migración de facturapi_customer_id en pronto_customers
DESCRIPCION:
  La base `pronto_test` había quedado detrás del modelo `Customer` y no tenía la columna
  `facturapi_customer_id`.
ESTADO: RESUELTO
SOLUCION:
  Se aplicó el pipeline canónico `pronto-migrate --apply` sobre `pronto_test` hasta dejar
  `pending=0 drift=0`, incluyendo `20260306_08__alter_customers_add_facturapi_id.sql`.
COMMIT: 4b22f32
FECHA_RESOLUCION: 2026-03-06
