---
ID: 20260215_serialization_circular_reference
DATE: 2026-02-15
PROJECT: pronto-libs
SEVERITY: High
TITLE: Circular reference detected in Realtime Event serialization
DESCRIPTION: |
  Runtime errors are occurring during the persistence of realtime events (e.g., `orders.status_changed`).
  Logs show: `Error persisting realtime event 'orders.status_changed': Circular reference detected`.
  
  Investigation reveals that the serialization utility `serialize_value` in `pronto_shared/utils.py` and `_serialize_value` in `realtime.py` do not handle `uuid.UUID` objects. When `json.dumps` encounters a UUID, it fails. The "Circular reference" message is likely a misleading error message from the JSON encoder or a side effect of how the payload is constructed involving UUIDs.
  
  This prevents realtime updates from working correctly.
LOCATION: 
  - `pronto-libs/src/pronto_shared/utils.py`
  - `pronto-libs/src/pronto_shared/supabase/realtime.py`
REPRODUCTION:
  1. Trigger an event that includes a UUID in the payload (e.g., `emit_order_status_change` with `session_id`).
  2. Observe logs in `pronto-api` or `pronto-client`.
EXPECTED: UUIDs should be serialized to strings automatically.
ACTUAL: Serialization fails, event is dropped or logged as error.
STATE: RESUELTO
SOLUCION: |
  Added UUID handling to `_serialize_value` in `realtime.py` and `serialize_value` in `utils.py`:
  - Added `from uuid import UUID` import
  - Added check: `if isinstance(value, UUID): return str(value)`
  
  Also cleared Python bytecode cache (.pyc files) and restarted containers to ensure new code is loaded.
COMMIT: Fix UUID serialization in realtime.py and utils.py
FECHA_RESOLUCION: 2026-02-16
---
