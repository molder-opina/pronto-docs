ID: 20260304-waiter-legacy-realtime-poller-and-request-payment-reopen
FECHA: 2026-03-04
PROYECTO: pronto-static, pronto-employees
SEVERIDAD: alta
TITULO: Waiter sigue disparando poller legacy realtime y request-payment vuelve a fallar en runtime
DESCRIPCION: Despues del fix previo, la consola /waiter sigue mostrando 504 en realtime y 500 al solicitar pago desde la UI. Se sospecha un camino legacy adicional de realtime y/o runtime duplicado que no esta pasando por el cliente corregido.
PASOS_REPRODUCIR: 1. Iniciar sesion en /waiter. 2. Abrir dashboard waiter. 3. Intentar una accion de solicitud de pago. 4. Observar consola/red.
RESULTADO_ACTUAL: Se observan GET /waiter/api/realtime/* con 504 y POST /waiter/api/orders/:id/request-payment con 500 desde la UI.
RESULTADO_ESPERADO: El realtime debe responder 200 sin timeout y la accion request-payment debe responder 200 desde la UI.
UBICACION: /waiter/dashboard/waiter
EVIDENCIA: Logs del navegador del usuario y trazas de red compartidas en la conversacion.
HIPOTESIS_CAUSA: Existe un poller legacy activo en employee-events.ts con timeout_ms=5000 y/o un flujo de UI que aun usa codigo legacy no cubierto por el fix anterior.
ESTADO: RESUELTO
SOLUCION: El cliente realtime de employees deja de pasar por el proxy scopeado para long-poll y consume `/api/realtime/*` directo contra el mismo origen con `X-App-Context`, evitando el deadlock del proxy que se reenviaba al mismo servicio. Adicionalmente, el timeout del poller se bajó a 3500ms y el módulo legacy `employee-events.ts` ahora no inicia si no existe el root requerido, además de usar el mismo timeout seguro y ruta directa. Se revalidó el flujo de `request-payment` desde la UI y quedó respondiendo correctamente.
COMMIT: 393e82d,a2d3451,026ae28
FECHA_RESOLUCION: 2026-03-04
