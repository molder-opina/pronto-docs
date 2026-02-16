---
ID: ERR-20260208-010
FECHA: 2026-02-08
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: Divergencia en lógica de pago de Split Bill
DESCRIPCION: El módulo de Split Bill realiza el cierre de la sesión (status='closed') y la marcación de órdenes pagadas de forma manual en lugar de invocar el servicio unificado finalize_payment. Esto omite efectos secundarios importantes como notificaciones de ticket por email y re-calculo de totales canónico.
PASOS_REPRODUCIR:
1) Realizar un pago total de un Split Bill.
2) Verificar que la sesión se cierra.
3) Observar que no se disparó el evento de notificación de pago o el email de ticket.
RESULTADO_ACTUAL: Lógica de fin de vida de sesión duplicada e incompleta.
RESULTADO_ESPERADO: Split Bill debe delegar el cierre final al servicio central de pagos.
UBICACION: pronto-client/src/pronto_clients/routes/api/split_bills.py
EVIDENCIA: Línea 320 en adelante implementa lógica manual de actualización de estado.
HIPOTESIS_CAUSA: Desarrollo del módulo de Split Bill de forma aislada a la unificación de pagos.
ESTADO: PENDIENTE
---
PLAN DE SOLUCION:
1. Refactorizar pay_split_person para que, cuando se detecte el último pago, invoque a pronto_shared.services.order_service.finalize_payment.
2. Eliminar la lógica manual de actualización de pronto_dining_sessions en este archivo.
