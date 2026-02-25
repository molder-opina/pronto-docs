ID: ERR-20260223-REFRESH-LOOP-NO-ACTIVE-ORDERS
FECHA: 2026-02-23
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: Loop de recarga tras hard refresh cuando no hay órdenes activas
DESCRIPCION: El cliente entraba en recarga continua por redirección forzada al evaluar órdenes activas durante la inicialización.
PASOS_REPRODUCIR:
1) Hard refresh en cliente con sesión válida pero sin órdenes activas mostrables.
2) Observar redirección/reload repetitivo.
RESULTADO_ACTUAL: Página se recarga continuamente.
RESULTADO_ESPERADO: Mantener página estable y solo ocultar tracker/tab de órdenes cuando no aplica.
UBICACION: pronto-static/src/vue/clients/modules/client-base.ts
EVIDENCIA: `checkActiveOrdersGlobal` llamaba `resetClientSession(...)->window.location.href='/'` en rama else, incluyendo escenarios sin órdenes.
HIPOTESIS_CAUSA: Condición else demasiado agresiva para reset/redirección en flujos sin órdenes activas.
ESTADO: RESUELTO
SOLUCION: En `checkActiveOrdersGlobal` se eliminó redirección automática para rama sin órdenes; ahora solo limpia UI de tracker y detiene polling. Solo limpia `session_id` local cuando sesión terminó o todas las órdenes quedaron pagadas.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
