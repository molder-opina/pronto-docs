ID: BUG-2026-0216-005
FECHA: 2026-02-16
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: Falta verificación de ocupación de mesa en move_session_to_table
DESCRIPCION: |
  La función move_session_to_table() no verifica si la mesa destino ya está ocupada por
  otra sesión activa. Esto podría causar que dos sesiones compartan la misma mesa.
PASOS_REPRODUCIR: |
  1. Tener dos sesiones activas en mesas diferentes
  2. Llamar al endpoint POST /api/sessions/<session_id>/move-to-table con el table_number de la otra sesión
  3. La operación succeederá incluso si la mesa destino está ocupada
  
RESULTADO_ACTUAL: La mesa se mueve sin verificar ocupación
RESULTADO_ESPERADO: Debe verificarse que la mesa destino no esté ocupada por otra sesión activa
UBICACION: pronto-libs/src/pronto_shared/services/dining_session_service.py:193-271
EVIDENCIA: |
  Solo se verifica que la mesa exista y esté activa, pero no se verifica si tiene una sesión activa.
HIPOTESIS_CAUSA: Código nuevo sin validación completa de negocio
ESTADO: RESUELTO
