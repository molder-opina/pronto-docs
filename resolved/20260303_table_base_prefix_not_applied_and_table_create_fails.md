ID: ERR-20260303-TABLE-BASE-PREFIX-NOT-APPLIED-AND-TABLE-CREATE-FAILS
FECHA: 2026-03-03
PROYECTO: pronto-libs, pronto-employees
SEVERIDAD: alta
TITULO: El prefijo base de mesa no se aplica al crear mesas y la creación puede fallar con UUID nulo
DESCRIPCION: En `/admin/dashboard/config` existe el parámetro `table_base_prefix`, pero al crear mesas desde administración el backend persistía `table_number` en crudo y no aplicaba ese prefijo configurable. Además, la creación de mesas podía fallar con `500` porque el modelo ORM de `pronto_tables` no declaraba el `server_default` del UUID aunque la base sí lo tenía.
PASOS_REPRODUCIR:
1. Verificar que `table_base_prefix` tenga un valor como `M` en configuración del sistema.
2. Intentar crear una mesa desde `/admin` o mediante `POST /admin/api/tables` con `table_number` numérico y `area_id` válido.
3. Observar la respuesta del API y el valor persistido en `pronto_tables.table_number`.
RESULTADO_ACTUAL: La creación podía responder `500` con error de identidad nula en SQLAlchemy y, cuando persistía, `table_base_prefix` no se usaba para construir el código de mesa.
RESULTADO_ESPERADO: La mesa debe crearse correctamente y el código persistido debe reflejar el prefijo base configurado al momento de crearla.
UBICACION: pronto-libs/src/pronto_shared/models.py; pronto-libs/src/pronto_shared/services/table_service.py
EVIDENCIA: Validación manual en `POST /admin/api/tables`, logs de `pronto-employees-1` con `FlushError: NULL identity key`, y revisión del servicio que usaba `table_number` sin aplicar `table_base_prefix`.
HIPOTESIS_CAUSA: El modelo `Table` no exponía `server_default=text("gen_random_uuid()")` y `TableService.create_table()` no transformaba números de mesa en el formato canónico usando el prefijo configurable.
ESTADO: RESUELTO
SOLUCION: Se corrigió `Table.id` para declarar `server_default=text("gen_random_uuid()")` en el ORM y `TableService` ahora transforma valores numéricos simples en códigos de mesa usando el área derivada y el valor actual de `table_base_prefix`. La validación real cambió temporalmente `table_base_prefix` a `Z`, creó una mesa por `/admin/api/tables` y confirmó en PostgreSQL que se persistió como `A-Z98`; luego el prefijo se restauró a `M`.
COMMIT:
FECHA_RESOLUCION: 2026-03-03
