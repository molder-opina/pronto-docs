---
ID: CLIENT_API_DEAD_ENDPOINTS_FOR_LEGACY_FRONTEND
FECHA: 20260206
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: Endpoints API no implementados (`PUT/DELETE /tables`) para compatibilidad con frontend legacy
DESCRIPCION: El módulo `pronto-client/src/pronto_clients/routes/api/config.py` define endpoints para `PUT /tables/<int:table_id>` y `DELETE /tables/<int:table_id>` que explícitamente devuelven `HTTPStatus.NOT_IMPLEMENTED` y en sus comentarios indican que existen "only to avoid 404s from legacy frontend modules". Esto sugiere que aún existen módulos de frontend legacy (o referencias a ellos) que intentan utilizar estos endpoints, los cuales ya no son funcionales ni están destinados a serlo. Mantener endpoints "muertos" por compatibilidad con código obsoleto es una señal de una limpieza incompleta o una migración no finalizada.
PASOS_REPRODUCIR:
1. Inspeccionar `pronto-client/src/pronto_clients/routes/api/config.py`.
2. Observar las definiciones de las funciones `update_table` y `delete_table`.
RESULTADO_ACTUAL: Se exponen endpoints API que no realizan ninguna operación y solo sirven para evitar errores 404 de clientes potencialmente legacy.
RESULTADO_ESPERADO: Se debería identificar y refactorizar el código de frontend que todavía hace estas llamadas o, si los endpoints no son necesarios en absoluto, eliminarlos por completo junto con cualquier referencia a ellos, para evitar mantener código obsoleto y engañoso.
UBICACION:
- pronto-client/src/pronto_clients/routes/api/config.py:L192-L201
EVIDENCIA:
```python
# Extract from pronto-client/src/pronto_clients/routes/api/config.py
@config_bp.put("/tables/<int:table_id>")
def update_table(table_id: int):
    # Client app must not mutate tables; endpoint exists only to avoid 404s from legacy frontend modules.
    return jsonify({"error": "Not implemented"}), HTTPStatus.NOT_IMPLEMENTED


@config_bp.delete("/tables/<int:table_id>")
def delete_table(table_id: int):
    # Client app must not mutate tables; endpoint exists only to avoid 404s from legacy frontend modules.
    return jsonify({"error": "Not implemented"}), HTTPStatus.NOT_IMPLEMENTED
```
HIPOTESIS_CAUSA: La refactorización o migración de componentes de frontend legacy no se ha completado, dejando "cabos sueltos" que el backend debe manejar pasivamente.
ESTADO: ABIERTO
---