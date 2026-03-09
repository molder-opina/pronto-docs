ID: TEST-20260306-045
FECHA: 2026-03-06
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: test_tax_validation usa XAXX010101000 con expectativas contradictorias
DESCRIPCION:
  `test_tax_validation.py` clasificaba `XAXX010101000` como RFC `moral` y también como RFC
  `fisica`, aunque `validate_rfc()` clasifica por longitud (13 => `fisica`).
ESTADO: RESUELTO
SOLUCION:
  Se corrigió la expectativa contradictoria removiendo `XAXX010101000` del bloque de persona moral,
  manteniendo su validación como RFC genérico de 13 caracteres en el bloque correspondiente.
  Validación: `test_tax_validation.py` => `30 passed`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
