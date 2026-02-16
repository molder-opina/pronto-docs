---
ID: ERR-20260203-SUPERVISOR-CALL-NAMING
FECHA: 2026-02-03
PROYECTO: pronto-static/pronto-employees/pronto-libs
SEVERIDAD: media
TITULO: Referencias a "supervisor" en llamada de ayuda de meseros
DESCRIPCION: La UI y eventos usan "supervisor" en IDs, textos y eventos para la llamada de ayuda, pero el rol canónico es system. Esto introduce nomenclatura no válida y confusión de permisos.
PASOS_REPRODUCIR: 1) Revisar waiter-board y templates de empleados. 2) Ver textos y IDs con "supervisor". 3) Revisar eventos realtime con "supervisor_call".
RESULTADO_ACTUAL: Se usan IDs y eventos con "supervisor".
RESULTADO_ESPERADO: Nomenclatura alineada a system/admin sin referencias a "supervisor".
UBICACION: pronto-static/src/vue/employees/modules/waiter-board.ts; pronto-employees/src/pronto_employees/templates/*; pronto-libs/src/pronto_shared/socketio_manager.py; pronto-libs/src/pronto_shared/supabase/realtime.py
EVIDENCIA: call-supervisor-btn, supervisor-call-status, staff.supervisor_call, supervisor.call.
HIPOTESIS_CAUSA: Nomenclatura heredada no actualizada al catálogo de roles.
ESTADO: RESUELTO
SOLUCION: Se renombraron IDs, textos, endpoints y eventos para eliminar referencias a supervisor.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-03
---
