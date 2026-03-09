ID: CLIENT-20260307-003
FECHA: 2026-03-07
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: support.py usa success_response sin importarlo
DESCRIPCION:
  `support.py` retornaba `success_response(...)` en `_forward_to_api`, pero el símbolo no estaba importado. La ruta
  `/api/support` podía fallar con `NameError` en ejecución.
PASOS_REPRODUCIR:
  1. Abrir `pronto-client/src/pronto_clients/routes/api/support.py`.
  2. Revisar el bloque de imports y el retorno de `_forward_to_api`.
RESULTADO_ACTUAL:
  El módulo ahora importa explícitamente `success_response`.
RESULTADO_ESPERADO:
  Debe existir import explícito de `success_response`.
UBICACION:
  - `pronto-client/src/pronto_clients/routes/api/support.py`
ESTADO: RESUELTO
SOLUCION:
  Se agregó `from pronto_shared.serializers import success_response`. Validación: lectura del archivo y
  `python3 -m py_compile pronto-client/src/pronto_clients/routes/api/support.py` => OK.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
