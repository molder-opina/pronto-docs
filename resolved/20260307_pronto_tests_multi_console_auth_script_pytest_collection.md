ID: TEST-20260307-025
FECHA: 2026-03-07
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: script test_multi_console_auth.py es colectado por pytest como tests parametrizados inválidos
DESCRIPCION:
  `pytest pronto-tests -q` fallaba porque `pronto-tests/scripts/test_multi_console_auth.py`
  mezclaba helpers `test_*` y smoke checks live dentro de un script manual bajo `scripts/`.
PASOS_REPRODUCIR:
  1. Ejecutar `./pronto-libs/.venv/bin/python3 -m pytest pronto-tests -q`.
  2. Observar fallos por colección/ejecución del script manual.
RESULTADO_ACTUAL:
  La suite completa de `pronto-tests` fallaba por tratar un smoke script live como tests automatizados.
RESULTADO_ESPERADO:
  El script debe seguir siendo ejecutable manualmente, pero no romper la suite automatizada de pytest.
UBICACION:
  - `pronto-tests/scripts/test_multi_console_auth.py`
EVIDENCIA:
  - archivo bajo `scripts/`
  - dependencias en rate limiting/live auth
HIPOTESIS_CAUSA:
  Un script manual quedó expuesto a la colección automática de pytest.
ESTADO: RESUELTO
SOLUCION:
  Se evitó que el smoke script participe en la suite automatizada marcándolo como `skip` bajo pytest, preservando su uso manual y dejando `pytest pronto-tests -q` en verde.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07

