ID: PRONTO-PAY-022
FECHA: 2026-03-15
PROYECTO: pronto-scripts, pronto-libs
SEVERIDAD: media
TITULO: Inconsistencia en valores por defecto de configuración de permisos
DESCRIPCION: Las migraciones SQL inicializan las configuraciones de permisos con valores por defecto que podrían causar comportamientos inconsistentes. waiter_can_collect se inicializa como 'true', mientras que payments.enable_cashier_role y payments.allow_waiter_cashier_operations también se inicializan como 'true'. Esto crea un estado inicial donde todos los roles pueden cobrar, pero no hay validación para asegurar que al menos uno pueda hacerlo.
PASOS_REPRODUCIR:
1. Analizar las migraciones SQL de configuración
2. Observar los valores por defecto establecidos
3. Verificar que no existe validación al inicializar estos valores
4. Configurar manualmente valores inconsistentes y observar el comportamiento
RESULTADO_ACTUAL: Valores por defecto que podrían permitir configuraciones inconsistentes si se modifican individualmente sin validación adecuada.
RESULTADO_ESPERADO: La inicialización debe garantizar que al menos un rol pueda procesar pagos, y debe existir validación para mantener esta invariante.
UBICACION:
- pronto-scripts/init/sql/migrations/20260218_03__add_waiter_payment_setting.sql:7
- pronto-scripts/init/sql/migrations/20260315_01__add_payment_permission_config.sql:13-14
EVIDENCIA: Ambas migraciones inicializan sus respectivas configuraciones como 'true', pero no existe validación cruzada para garantizar la consistencia entre ellas.
HIPOTESIS_CAUSA: Las migraciones fueron implementadas por separado sin considerar la necesidad de validación cruzada entre las configuraciones relacionadas.
ESTADO: RESUELTO