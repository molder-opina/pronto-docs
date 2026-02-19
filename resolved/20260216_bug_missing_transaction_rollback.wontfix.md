ID: BUG-2026-0216-006
FECHA: 2026-02-16
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: Falta transaction rollback en merge_sessions
DESCRIPCION: |
  La función merge_sessions() no maneja rollback de transacciones de forma explícita.
  Si ocurre un error durante el proceso de fusión (por ejemplo, al mover órdenes),
  podría quedar la base de datos en estado inconsistente.
PASOS_REPRODUCIR: |
  1. Llamar al endpoint POST /api/sessions/merge
  2. Simular un error durante la operación (ej. conexión a BD se corta)
  3. Verificar el estado de las sesiones
  
RESULTADO_ACTUAL: No hay manejo de transacciones atómicas
RESULTADO_ESPERADO: Debe usar savepoint o transaction explícita para rollback automático en caso de error
UBICACION: pronto-libs/src/pronto_shared/services/dining_session_service.py:273-354
EVIDENCIA: |
  No se usa try/except con rollback, ni savepoint.
  Si falla en medio del loop, algunas sesiones pueden quedar en estado inconsistente.
HIPOTESIS_CAUSA: Código nuevo sin manejo robusto de transacciones
ESTADO: RESUELTO
