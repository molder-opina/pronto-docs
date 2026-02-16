ID: BUG-20260214-006
FECHA: 2026-02-14
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: split_bills.py sin protección de autenticación
DESCRIPCION: |
  Todos los endpoints de split_bills (crear, consultar, asignar items, calcular,
  pagar) no verifican customer_ref ni dining_session_id. Cualquier persona puede:
  - Crear splits para cualquier session_id.
  - Asignar items a personas en cualquier split.
  - Procesar pagos en cualquier split.
  Esto es especialmente grave en el endpoint de pago (POST /split-bills/<id>/people/<id>/pay)
  que puede finalizar pagos sin autenticación.
PASOS_REPRODUCIR: |
  1. Enviar POST /api/sessions/1/split-bill con body `{"number_of_people": 2}` sin auth.
  2. Observar que se crea el split exitosamente.
  3. Enviar POST /api/split-bills/1/people/1/pay con body `{"payment_method": "cash"}`.
  4. Observar que se procesa el pago sin autenticación.
RESULTADO_ACTUAL: |
  Ningún endpoint de split_bills verifica autenticación ni ownership de la sesión.
RESULTADO_ESPERADO: |
  Todos los endpoints deben verificar customer_ref de flask.session y validar
  que el dining_session_id del cliente corresponde al session_id del split.
UBICACION: pronto-client/src/pronto_clients/routes/api/split_bills.py
EVIDENCIA: Ninguna función en el archivo importa ni consulta flask.session["customer_ref"]. El endpoint de pago (línea 465) modifica estado financiero sin auth.
HIPOTESIS_CAUSA: Se implementó la funcionalidad sin integrar el modelo de autenticación de clientes.
ESTADO: RESUELTO
SOLUCION: Corregido en versión 1.0038
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-14
