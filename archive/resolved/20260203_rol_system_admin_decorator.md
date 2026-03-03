---
ID: ERR-20260203-002
FECHA: 2026-02-03
PROYECTO: pronto-employees
SEVERIDAD: media
TITULO: Decorator expone rol inexistente "system_admin"
DESCRIPCION: Existe un decorator para role_required("system_admin"), rol no canónico. Esto permite uso accidental de un rol inválido.
PASOS_REPRODUCIR: 1) Importar system_admin_required. 2) Proteger una ruta con ese decorator.
RESULTADO_ACTUAL: Se acepta un rol inexistente.
RESULTADO_ESPERADO: Solo roles canónicos; system para /system.
UBICACION: pronto-employees/src/pronto_employees/decorators.py:36-38
EVIDENCIA: system_admin_required usa role_required("system_admin").
HIPOTESIS_CAUSA: Renombre inconcluso de rol system.
ESTADO: RESUELTO
SOLUCION: Se eliminaron roles no canónicos y se estandarizó el rol system en UI/tests/templates.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-03
---
