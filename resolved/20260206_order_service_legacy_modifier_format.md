---
ID: ORDER_SERVICE_LEGACY_MODIFIER_FORMAT
FECHA: 20260206
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: Soporte para formato de modificadores legacy en `order_service.py`
DESCRIPCION: El servicio `pronto-client/src/pronto_clients/services/order_service.py` aún soporta un formato legacy para la selección de modificadores (`Legacy/TS format: [modifier_id, modifier_id, ...]`). Mantener la compatibilidad con formatos deprecated añade complejidad al código y puede dificultar futuras refactorizaciones y el mantenimiento.
PASOS_REPRODUCIR:
1. Inspeccionar `pronto-client/src/pronto_clients/services/order_service.py` en la función `validate_required_modifiers`.
2. Observar la línea donde se comenta el formato legacy para `selected_modifiers`.
RESULTADO_ACTUAL: El código debe manejar dos formatos distintos para los modificadores seleccionados.
RESULTADO_ESPERADO: El código debería ser refactorizado para soportar únicamente el formato más reciente (`{"modifier_id": int, "quantity": int}`), eliminando la lógica de compatibilidad con el formato legacy.
UBICACION:
- pronto-client/src/pronto_clients/services/order_service.py:L139
EVIDENCIA:
```python
# pronto-client/src/pronto_clients/services/order_service.py (extract)
    # Legacy/TS payload where "modifiers" is a list of IDs
    modifier_id = int(selected)
    quantity = 1
```
HIPOTESIS_CAUSA: No se ha realizado la migración completa del frontend o de los clientes que utilizan el formato legacy, o se ha pospuesto la refactorización para mantener la compatibilidad hacia atrás.
ESTADO: ABIERTO
---