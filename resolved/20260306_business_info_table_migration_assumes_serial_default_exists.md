ID: TEST-20260306-041
FECHA: 2026-03-06
PROYECTO: pronto-scripts,pronto-client
SEVERIDAD: alta
TITULO: 20260206_01__business_info_table.sql asume default serial en pronto_business_info.id
DESCRIPCION:
  En live, `pronto_business_info.id` existía como `integer not null` sin default/sequence y la
  migración fallaba al insertar la fila `default`.
ESTADO: RESUELTO
SOLUCION:
  La migración ahora repara secuencia/default de `pronto_business_info.id`, sincroniza `setval()` y
  tolera esquemas legacy que todavía requieren `business_name` durante el insert idempotente.
  Validación: `pronto-migrate --apply` y luego `pronto-migrate --check` => `pending=0 drift=0` en
  la DB live `pronto`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
