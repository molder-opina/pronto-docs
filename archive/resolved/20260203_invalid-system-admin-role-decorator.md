---
ID: ERR-20260203-001
FECHA: 2026-02-03
PROYECTO: pronto-employees
SEVERIDAD: media
TITULO: Decorator usa rol no canonico system_admin
DESCRIPCION: Se define un decorator system_admin_required que fuerza el rol "system_admin", pero los roles canonicos son waiter, chef, cashier, admin, system. Esto viola reglas de roles y puede bloquear acceso o generar confusiones.
PASOS_REPRODUCIR:
1. Revisar el archivo src/pronto_employees/decorators.py.
2. Identificar la funcion system_admin_required y su role_required("system_admin").
RESULTADO_ACTUAL: Existe decorator que referencia el rol no canonico "system_admin".
RESULTADO_ESPERADO: No debe existir referencia a roles fuera del set canonico; usar "system" o eliminar el decorator si no aplica.
UBICACION: pronto-employees/src/pronto_employees/decorators.py:36-38
EVIDENCIA: role_required("system_admin") definido en system_admin_required.
HIPOTESIS_CAUSA: Se agrego por compatibilidad/legacy sin validar el set de roles canonicos.
ESTADO: RESUELTO
SOLUCION: Se eliminaron roles no canónicos y se estandarizó el rol system en UI/tests/templates.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-03
---
