---
ID: ERR-20260203-NOTIF-CLEAR
FECHA: 2026-02-03
PROYECTO: pronto-employees/pronto-static
SEVERIDAD: baja
TITULO: Accion de limpiar notificaciones sin soporte
DESCRIPCION: El panel de notificaciones incluia un boton de limpiar sin endpoint dedicado. Se elimino la accion legacy y el panel se mantiene solo con lectura de pendientes.
PASOS_REPRODUCIR: 1) Abrir dashboard de empleados. 2) Ver panel de notificaciones sin boton de limpiar.
RESULTADO_ACTUAL: No existe accion legacy de limpiar; panel se actualiza por polling.
RESULTADO_ESPERADO: UI sin dependencias de rutas legacy.
UBICACION: pronto-employees/src/pronto_employees/templates/includes/_notifications_panel.html; pronto-employees/src/pronto_employees/templates/dashboard.html
EVIDENCIA: Panel sin accion de limpiar; no hay llamadas legacy en templates.
HIPOTESIS_CAUSA: Endpoint no implementado en BFF de empleados.
ESTADO: RESUELTO
SOLUCION: Se removio el boton de limpiar y el script legacy; se mantiene el panel con pendientes via /api/notifications/waiter/pending.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-04
---
