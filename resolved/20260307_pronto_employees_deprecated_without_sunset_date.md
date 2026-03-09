ID: EMP-20260307-006
FECHA: 2026-03-07
PROYECTO: pronto-employees
SEVERIDAD: media
TITULO: modulos deprecated mantienen sunset TBD sin fecha de retiro explicita
DESCRIPCION:
  Varios modulos marcados como `DEPRECATED` incluían `Fecha de sunset: TBD`.
  AGENTS exige compatibilidad temporal declarada como deprecated con plan de retiro explícito.
PASOS_REPRODUCIR:
  1. Revisar cabeceras de modulos proxy de sessions/promotions/auth por scope.
  2. Verificar literal `Fecha de sunset: TBD`.
RESULTADO_ACTUAL:
  Las cabeceras deprecated ahora exponen una fecha concreta de retiro (`2026-06-30`).
RESULTADO_ESPERADO:
  Deprecaciones deben incluir fecha y plan de eliminacion verificable.
UBICACION:
  - pronto-employees/src/pronto_employees/routes/api/sessions.py
  - pronto-employees/src/pronto_employees/routes/api/promotions.py
  - pronto-employees/src/pronto_employees/routes/waiter/auth.py
  - pronto-employees/src/pronto_employees/routes/chef/auth.py
  - pronto-employees/src/pronto_employees/routes/cashier/auth.py
  - pronto-employees/src/pronto_employees/routes/admin/auth.py
  - pronto-employees/src/pronto_employees/routes/system/auth.py
EVIDENCIA:
  - `rg -n "Fecha de sunset: TBD" pronto-employees/src/pronto_employees/routes` => sin matches
HIPOTESIS_CAUSA:
  Migracion en curso sin governance de fechas de retiro.
ESTADO: RESUELTO
SOLUCION:
  Se sustituyó el literal `TBD` por la fecha explícita `2026-06-30` en los siete módulos deprecated afectados.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07