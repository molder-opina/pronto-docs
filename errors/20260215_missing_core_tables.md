---
ID: 20260215_missing_core_tables
DATE: 2026-02-15
PROJECT: pronto-libs / pronto-api
SEVERIDAD: alta
TITULO: Tablas requeridas por el código inexistentes en la base de datos
DESCRIPCION: |
  El código de los servicios en `pronto_shared` intenta interactuar con tablas que no existen en el esquema actual de la base de datos.
  
  Tablas identificadas como faltantes:
  - `pronto_notifications`: Requerida para el sistema de alertas.
  - `pronto_waiter_calls`: Requerida para la función de solicitar cuenta/mesero.
  - `pronto_realtime_events`: Requerida por `supabase/realtime.py`.
  - `pronto_waiter_table_assignments`: Requerida para asignar meseros a mesas.
  
  Esto provoca errores `UndefinedTable` (500 Internal Server Error) en flujos críticos como Checkout.
UBICACION: Base de datos física / `pronto-scripts/init/sql/`
REPRODUCCION:
  1. Intentar solicitar la cuenta desde la app del cliente.
  2. Verificar logs de `pronto-api` por errores `psycopg2.errors.UndefinedTable`.
RESULTADO_ACTUAL: Error de base de datos.
RESULTADO_ESPERADO: El esquema de la base de datos debe contener todas las tablas referenciadas por los modelos y servicios.
---
