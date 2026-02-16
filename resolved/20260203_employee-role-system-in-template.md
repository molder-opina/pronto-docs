---
ID: ERR-20260203-002
FECHA: 2026-02-03
PROYECTO: pronto-employees
SEVERIDAD: media
TITULO: Template usa rol no canonico "system"
DESCRIPCION: En el template _menu_chef.html se valida employee_role contra "system", pero los roles canonicos son waiter, chef, cashier, admin, system. Esto puede ocultar acciones a system o exponer comportamiento incorrecto.
PASOS_REPRODUCIR:
1. Abrir src/pronto_employees/templates/includes/_menu_chef.html.
2. Buscar el bloque condicional con employee_role in ['system', 'admin'].
RESULTADO_ACTUAL: Se usa el rol "system" que no existe en el set canonico.
RESULTADO_ESPERADO: El control de acceso debe usar roles canonicos (por ejemplo, system, admin).
UBICACION: pronto-employees/src/pronto_employees/templates/includes/_menu_chef.html:753
EVIDENCIA: {% if employee_role in ['system', 'admin'] %}
HIPOTESIS_CAUSA: Remanente de nomenclatura previa del scope /system no alineada a roles canonicos.
ESTADO: RESUELTO
SOLUCION: Se eliminaron roles no canónicos y se estandarizó el rol system en UI/tests/templates.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-03
---
