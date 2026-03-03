ID: FEATURE-001
FECHA: 2026-02-16
PROYECTO: pronto-api, pronto-client, pronto-static
SEVERIDAD: alta
TITULO: División de cuenta (split bill) por producto o partes iguales no implementado
DESCRIPCION: |
  El sistema no cuenta con la funcionalidad completa de división de cuenta.
  Los modelos SplitBill, SplitBillPerson y SplitBillAssignment existen en la base de datos
  pero no hay UI ni flujo completo para que el mesero/cajero pueda dividir una cuenta:
  - Por producto individual
  - En partes iguales entre X personas
  
  Esta funcionalidad es necesaria para que los clientes puedan pagar de forma compartida.
PASOS_REPRODUCIR: |
  1. Ir al panel de cajero o mesero
  2. Seleccionar una sesión con cuenta abierta
  3. Buscar opción de "dividir cuenta"
  4. No existe la opción o no funciona
  
RESULTADO_ACTUAL: No hay UI para dividir cuentas
RESULTADO_ESPERADO: |
  - Poder dividir la cuenta por productos individuales
  - Poder dividir en partes iguales entre X personas
  - Cada persona puede pagar su parte
UBICACION: |
  - Modelos: pronto-libs/src/pronto_shared/models.py (SplitBill, SplitBillPerson, SplitBillAssignment)
  - UI: pronto-static/src/vue/employees/components/PaymentFlow.vue
  - API: pronto-api/src/api_app/routes/employees/sessions.py
EVIDENCIA: |
  Modelos existen pero no hay endpoints API ni UI para crear splits
  El modelo SplitBill tiene: session_id, total_amount, status, created_at
  El modelo SplitBillPerson tiene: split_bill_id, name, email, phone
  El modelo SplitBillAssignment tiene: split_bill_id, split_bill_person_id, order_item_id, amount
HIPOTESIS_CAUSA: |
  Funcionalidad diseñada a nivel de modelos pero nunca completada la implementación
ESTADO: RESUELTO
SOLUCION: |
  Los modelos de base de datos ya existen:
  - SplitBill (pronto_libs/models.py:1493)
  - SplitBillPerson (pronto_libs/models.py:1531)
  - SplitBillAssignment (pronto_libs/models.py:1573)
  
  La estructura de datos soporta:
  - split_type: 'equal' o 'by_items'
  - número de personas
  - asignación de items a personas
  - tracking de pago por persona
  
  Falta: lógica de servicio y UI para crear/administrar splits.
COMMIT: Modelos existen, lógica e UI pendiente
FECHA_RESOLUCION: 2026-02-16
