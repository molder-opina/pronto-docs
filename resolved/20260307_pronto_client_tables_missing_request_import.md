ID: CLIENT-20260307-004
FECHA: 2026-03-07
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: tables.py referencia request sin import
DESCRIPCION:
  `tables.py` usaba `request.view_args['table_id']` en `get_table()`, pero `request` no estaba importado en el módulo.
PASOS_REPRODUCIR:
  1. Abrir `pronto-client/src/pronto_clients/routes/api/tables.py`.
  2. Revisar imports y uso de `request`.
RESULTADO_ACTUAL:
  El módulo ahora importa `request` desde Flask.
RESULTADO_ESPERADO:
  El módulo debe importar `request` o evitar su uso.
UBICACION:
  - `pronto-client/src/pronto_clients/routes/api/tables.py`
ESTADO: RESUELTO
SOLUCION:
  Se cambió el import a `from flask import Blueprint, request`. Validación: lectura del archivo y
  `python3 -m py_compile pronto-client/src/pronto_clients/routes/api/tables.py` => OK.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
