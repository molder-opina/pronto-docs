ID: CLIENT-20260307-002
FECHA: 2026-03-07
PROYECTO: pronto-client
SEVERIDAD: bloqueante
TITULO: SyntaxError en business_info.py por parentesis extra
DESCRIPCION:
  El expediente reportaba un `SyntaxError: unmatched ')'` en `business_info.py` por un paréntesis extra en `tz_name`.
PASOS_REPRODUCIR:
  1. Compilar `pronto-client/src/pronto_clients/routes/api/business_info.py`.
  2. Revisar la asignación de `tz_name`.
RESULTADO_ACTUAL:
  En el árbol actual el módulo compila correctamente y no contiene el paréntesis extra reportado.
RESULTADO_ESPERADO:
  El módulo debe compilar sin errores de sintaxis.
UBICACION:
  - `pronto-client/src/pronto_clients/routes/api/business_info.py`
ESTADO: RESUELTO
SOLUCION:
  Se verificó que el bug ya estaba corregido en el árbol actual. Validación: lectura del archivo y
  `python3 -m py_compile pronto-client/src/pronto_clients/routes/api/business_info.py` => OK.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
