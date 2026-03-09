ID: API-20260307-007
FECHA: 2026-03-07
PROYECTO: pronto-api
SEVERIDAD: critica
TITULO: endpoints admin de invoices no exigen JWT/scope de forma efectiva
DESCRIPCION:
  Las rutas de `admin_invoice_bp` no tenían enforcement real de JWT/scope en tiempo de definición, dejando superficie administrativa expuesta.
PASOS_REPRODUCIR:
  1. Abrir `pronto-api/src/api_app/routes/invoices.py`.
  2. Revisar `/admin/invoices`, `/admin/invoices/<invoice_id>` y `/admin/invoices/stats`.
  3. Confirmar ausencia de decoradores efectivos sobre las funciones de ruta.
RESULTADO_ACTUAL:
  Las rutas administrativas exigen `@jwt_required` + `@scope_required(["admin", "system"])`.
RESULTADO_ESPERADO:
  Toda superficie admin debe requerir JWT válido con scope admin/system.
UBICACION:
  - `pronto-api/src/api_app/routes/invoices.py`
  - `pronto-api/tests/test_security_regressions.py`
ESTADO: RESUELTO
SOLUCION:
  Se añadieron decoradores `@jwt_required` y `@scope_required(["admin", "system"])` a las tres rutas de `admin_invoice_bp`, y se limpió el acceso a query params usando `request.args` directamente.
  Validación: `python3 -m py_compile pronto-api/src/api_app/routes/invoices.py pronto-api/tests/test_security_regressions.py` => OK;
  `pronto-api/.venv/bin/python -m pytest pronto-api/tests/test_security_regressions.py -q` => pasa, incluyendo tests de 401 anónimo y acceso admin autenticado.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
