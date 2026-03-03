---
ID: 20260215_maintenance_socketio_legacy
DATE: 2026-02-15
PROJECT: pronto-libs
SEVERITY: Medium
TITLE: Ambiguous usage of legacy SocketIO manager vs Supabase Realtime
DESCRIPTION: |
  The codebase contains `socketio_manager.py` which appears to be a legacy artifact or is being reused as a Redis wrapper.
  
  `pronto_shared/supabase/realtime.py` claims to "replace socketio_manager.py", yet `models.py` and other services still import from `socketio_manager` or use a mix of both.
  
  This creates confusion about the source of truth for realtime events and potential dead code. `socketio_manager.py` imports `redis`, which is a hard dependency, whereas `realtime.py` seems designed to be more abstract.
LOCATION: `pronto-libs/src/pronto_shared/socketio_manager.py`
REPRODUCTION:
  1. Grep for `socketio_manager`.
  2. Grep for `supabase.realtime`.
  3. Observe mixed usage.
EXPECTED: A single, clear abstraction for realtime events. Legacy code should be removed or explicitly marked/refactored.
ACTUAL: Mixed usage and potential code duplication.
---
