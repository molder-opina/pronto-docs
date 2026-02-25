ID: ERR-20260223-CALL-WAITER-UNBOUND-SESSION
FECHA: 2026-02-23
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: Error al llamar al mesero por UnboundLocalError en endpoint /api/call-waiter
DESCRIPCION: Al pulsar la campana en cliente, el endpoint de llamada de mesero devolvía error por excepción interna.
PASOS_REPRODUCIR:
1) Abrir cliente autenticado con sesión de mesa activa.
2) Pulsar botón de campana "Llamar al mesero".
RESULTADO_ACTUAL: Toast de error "Error al llamar al mesero. Intenta de nuevo".
RESULTADO_ESPERADO: Registrar llamada y notificar mesero exitosamente.
UBICACION: pronto-client/src/pronto_clients/routes/api/waiter_calls.py
EVIDENCIA: Traceback en logs: `UnboundLocalError: cannot access local variable 'session'` en `call_waiter`.
HIPOTESIS_CAUSA: Sombreado del nombre `session` (Flask session vs SQLAlchemy session local) dentro de la misma función.
ESTADO: RESUELTO
SOLUCION: Se renombró la sesión de DB a `db_session` en `call_waiter`, y se corrigió endpoint alterno `/notifications/waiter/status/<int:call_id>` para usar parámetro consistente (`call_id`) en ruta y query.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
