---
ID: ERR-20260203-003
FECHA: 2026-02-03
PROYECTO: pronto-employees
SEVERIDAD: media
TITULO: Uso de rol "system" en empleados en lugar de system
DESCRIPCION: Se usa "system" como employee_role default y en checks de capacidades. El rol canónico para /system es system, por lo que estas validaciones quedan inconsistentes.
PASOS_REPRODUCIR: 1) Acceder a /system/dashboard sin employee_role. 2) Revisar capabilities en waiter dashboard.
RESULTADO_ACTUAL: employee_role default "system" y checks con "system".
RESULTADO_ESPERADO: Usar system como rol canónico.
UBICACION: pronto-employees/src/pronto_employees/routes/system/auth.py:130-136; pronto-employees/src/pronto_employees/routes/waiter/auth.py:183-191
EVIDENCIA: employee_role = ... "system" y employee_role in ["admin", "cashier", "system"].
HIPOTESIS_CAUSA: Confusión entre scope "system" y rol system.
ESTADO: RESUELTO
SOLUCION: Se eliminaron roles no canónicos y se estandarizó el rol system en UI/tests/templates.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-03
---
