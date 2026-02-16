---
ID: ERR-20260203-002
FECHA: 2026-02-03
PROYECTO: pronto-employees
SEVERIDAD: media
TITULO: Decorator usa rol no canonico "system_admin"
DESCRIPCION: Existe un decorator system_admin_required que aplica role_required("system_admin"). Ese rol no es canonico segun las reglas del proyecto y puede generar autorizaciones inconsistentes.
PASOS_REPRODUCIR: Revisar pronto_employees/decorators.py.
RESULTADO_ACTUAL: role_required("system_admin") definido y exportado.
RESULTADO_ESPERADO: Solo roles canonicos (waiter, chef, cashier, admin, system).
UBICACION: pronto-employees/src/pronto_employees/decorators.py
EVIDENCIA: pronto-employees/src/pronto_employees/decorators.py:36-49
HIPOTESIS_CAUSA: Alias historico no eliminado tras estandarizar roles.
ESTADO: RESUELTO
SOLUCION: Se eliminaron roles no canónicos y se estandarizó el rol system en UI/tests/templates.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-03
---
