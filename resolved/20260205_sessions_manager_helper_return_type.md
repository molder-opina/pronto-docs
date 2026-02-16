---
ID: ERR-20260205-SESSIONS-MANAGER-HELPER-RETURN-TYPE
FECHA: 2026-02-05
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: SessionsManager usa deriveSessionsFromOrders como Map pero retorna array
DESCRIPCION: El modulo sessions-manager.ts llama deriveSessionsFromOrders(orders) y luego usa derived.get(sessionId). La funcion deriveSessionsFromOrders retorna DerivedSession[] (array), por lo que derived.get no existe y el modulo falla en runtime al cargar sesiones pendientes.
PASOS_REPRODUCIR: 1) Abrir dashboard cashier con SessionsManager. 2) Disparar loadPendingSessions(). 3) Ver error TypeError: derived.get is not a function.
RESULTADO_ACTUAL: No carga la lista de sesiones pendientes.
RESULTADO_ESPERADO: Derivar sesiones correctamente sin error de runtime.
UBICACION: pronto-static/src/vue/employees/modules/sessions-manager.ts
EVIDENCIA: const derived = deriveSessionsFromOrders(orders); luego derived.get(sessionId)
HIPOTESIS_CAUSA: Asuncion incorrecta del tipo de retorno del helper.
ESTADO: RESUELTO
---

SOLUCION: Se ajusto sessions-manager.ts para convertir el resultado (array) de deriveSessionsFromOrders a un Map por session_id antes de acceder por id. Se removio el uso incorrecto derived.get(...).
COMMIT: b1b4855
FECHA_RESOLUCION: 2026-02-05
