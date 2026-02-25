ID: ERR-20260225-SESSION-STATUS-LABEL
FECHA: 2026-02-25
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Estado de sesión mostrado incorrectamente como "Consumo activo" en Caja y Cierres
DESCRIPCION: En /waiter/dashboard/sessions se visualiza el estado "Consumo activo" para sesiones cuyo estado canónico no corresponde a ese texto, generando confusión operativa.
PASOS_REPRODUCIR: 1) Ingresar a /waiter/dashboard/sessions. 2) Revisar tarjetas de cuenta en "Cuentas Pendientes". 3) Comparar etiqueta visual de estado con estado real de sesión.
RESULTADO_ACTUAL: Se renderiza "Consumo activo" para sesiones con estado "open", sin reflejar claramente el estado canónico del flujo.
RESULTADO_ESPERADO: Mostrar etiqueta alineada al estado real/canónico de sesión (ej. open=Cuenta abierta, awaiting_payment=Esperando pago, etc.).
UBICACION: pronto-static/src/vue/employees/components/sessions/SessionCard.vue; pronto-static/src/vue/employees/components/CashierBoard.vue
EVIDENCIA: Reporte de usuario con captura en /waiter/dashboard/sessions (tarjeta muestra "Estado: Consumo activo").
HIPOTESIS_CAUSA: Mapeo UI legacy de etiquetas en frontend que interpreta "open" como "Consumo activo" en lugar de texto canónico de estado.
ESTADO: RESUELTO
SOLUCION: Se reemplazó el mapeo de estado para sesiones en Vue employees. `open` ahora se muestra como `Cuenta abierta`, se agregó soporte explícito para `awaiting_payment_confirmation`, `active`, `closed` y se unificó el etiquetado en `SessionCard` y `CashierBoard`.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-25
