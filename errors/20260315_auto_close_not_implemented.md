ID: PRONTO-PAY-006
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-scripts
SEVERIDAD: media
TITULO: Configuración de cierre automático de sesiones sin implementación
DESCRIPCION: La configuración session_auto_close_hours está definida en el contrato de configuración y en las migraciones SQL, pero no existe implementación real del cierre automático de sesiones inactivas. Solo hay configuración sin lógica asociada.
PASOS_REPRODUCIR:
1. Buscar la configuración session_auto_close_hours en config_contract.py
2. Verificar que existe en las migraciones SQL
3. Buscar implementación real del cierre automático (jobs, schedulers, etc.)
4. Observar que no existe lógica que utilice esta configuración
RESULTADO_ACTUAL: Configuración sin funcionalidad. Sesiones inactivas no se cierran automáticamente.
RESULTADO_ESPERADO: Debe existir un job scheduler o mecanismo que use session_auto_close_hours para cerrar sesiones inactivas automáticamente.
UBICACION:
- pronto-libs/src/pronto_shared/config_contract.py:265
- pronto-scripts/init/sql/migrations/20260315_01__add_payment_permission_config.sql:13-14
EVIDENCIA: Búsqueda exhaustiva en todo el código base no encuentra ninguna implementación que utilice la configuración session_auto_close_hours para cerrar sesiones automáticamente.
HIPOTESIS_CAUSA: La funcionalidad fue planeada pero nunca implementada, dejando solo la configuración en el sistema.
ESTADO: RESUELTO