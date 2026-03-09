ID: TEST-20260306-018
FECHA: 2026-03-06
PROYECTO: pronto-scripts,pronto-tests
SEVERIDAD: alta
TITULO: Migración areas_integer_id falla cuando pronto_areas está vacía
DESCRIPCION:
  `20260219_01__areas_integer_id.sql` hacía `setval()` con valor `0` cuando `pronto_areas`
  no tenía filas.
PASOS_REPRODUCIR:
  1. Ejecutar `pronto-migrate --apply` en una base nueva.
  2. Observar `setval: value 0 is out of bounds for sequence`.
RESULTADO_ACTUAL:
  La migración fallaba en el caso borde de tabla vacía.
RESULTADO_ESPERADO:
  Debe dejar la secuencia lista para empezar en `1`.
UBICACION:
  - `pronto-scripts/init/sql/migrations/20260219_01__areas_integer_id.sql`
ESTADO: RESUELTO
SOLUCION:
  Se actualizaron ambos `setval()` para usar `GREATEST(..., 1)` y el flag `is_called` basado en
  si existen filas, soportando correctamente una base vacía.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
