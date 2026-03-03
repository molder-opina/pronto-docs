---
ID: ERR-20260208-012
FECHA: 2026-02-08
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: Lógica de asignación de meseros redundante en WaiterCalls
DESCRIPCION: El endpoint de llamada a mesero intenta resolver el mesero asignado a una mesa o sesión duplicando la lógica de búsqueda en DB en lugar de utilizar el servicio centralizado waiter_table_assignment_service. Esto genera inconsistencias si las reglas de asignación (ej. prioridad por carga de trabajo) se actualizan en el núcleo pero no en el BFF del cliente.
PASOS_REPRODUCIR:
1) Revisar la función call_waiter() en waiter_calls.py.
2) Observar las consultas directas a WaiterTableAssignment y DiningSession para encontrar el waiter_id.
RESULTADO_ACTUAL: Lógica de resolución de personal dispersa y manual.
RESULTADO_ESPERADO: El BFF debe invocar una función centralizada (ej. resolve_table_waiter) que aplique las políticas vigentes del restaurante.
UBICACION: pronto-client/src/pronto_clients/routes/api/waiter_calls.py
EVIDENCIA: Bloque de resolución en líneas 100-130 de waiter_calls.py.
HIPOTESIS_CAUSA: Implementación reactiva de la funcionalidad antes de la madurez de los servicios compartidos.
ESTADO: PENDIENTE
---
PLAN DE SOLUCION:
1. Reemplazar bloques de consulta manual por llamadas a pronto_shared.services.waiter_table_assignment_service.
2. Eliminar imports redundantes de modelos en el controlador.
