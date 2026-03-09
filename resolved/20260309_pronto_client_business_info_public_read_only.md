ID: CLIENT-20260309-001
FECHA: 2026-03-09
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: /api/business-info en pronto-client exige autenticación aunque la navegación informativa del cliente es pública
DESCRIPCION:
  `pronto-client/src/pronto_clients/routes/api/business_info.py` exigía sesión autenticada
  para exponer información de negocio y horarios, aunque el proyecto permite navegación pública
  del cliente para vistas informativas sin mutación.
PASOS_REPRODUCIR:
  1. Abrir `GET /api/business-info` sin sesión autenticada.
  2. Observar que el endpoint devolvía 401 en vez de responder datos informativos públicos.
RESULTADO_ACTUAL:
  El endpoint quedó público y de solo lectura; ya no depende de una sesión autenticada para exponer nombre/horarios.
RESULTADO_ESPERADO:
  La navegación informativa del cliente debe poder consultar información de negocio sin autenticación, manteniendo auth obligatoria solo al crear/confirmar orden o iniciar checkout/pago.
UBICACION:
  - pronto-client/src/pronto_clients/routes/api/business_info.py
  - pronto-client/tests/test_business_info_api.py
  - pronto-client/src/pronto_clients/utils/customer_session.py
EVIDENCIA:
  - `PYTHONPATH=src:../pronto-libs/src ../pronto-api/.venv/bin/python -m pytest tests/test_business_info_api.py -q` => `3 passed`
  - `PYTHONPATH=src:../pronto-libs/src ../pronto-api/.venv/bin/python -m py_compile src/pronto_clients/routes/api/business_info.py tests/test_business_info_api.py` => OK
HIPOTESIS_CAUSA:
  El endurecimiento previo del flujo cliente terminó cerrando también una superficie informativa read-only que debía permanecer pública según el canon actual del proyecto.
ESTADO: RESUELTO
SOLUCION:
  Se mantuvo `business_info.py` como endpoint público read-only, se actualizaron sus pruebas para reflejar el comportamiento canónico sin sesión autenticada y se añadió un caso de resiliencia ante fallo de servicios. También se confirmó que `customer_session.py` quedó huérfano y puede eliminarse sin referencias activas.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09