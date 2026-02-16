---
ID: DUPLICATE_MENU_SERVICE
FECHA: 20260206
PROYECTO: pronto-client, pronto-libs
SEVERIDAD: media
TITULO: Duplicación del módulo `menu_service.py`
DESCRIPCION: Se ha encontrado una duplicación del módulo `menu_service.py` en `pronto-client/src/pronto_clients/services/menu_service.py` y `pronto-libs/src/pronto_shared/services/menu_service.py`. Esto viola el principio "Reuse before Creation" y la directriz "Always check `pronto_shared` first. If a service, model, or utility exists in shared, import it from there. Do not duplicate logic in app-specific folders." establecido en `AGENTS.md`. La duplicación de lógica conduce a una mayor sobrecarga de mantenimiento y posibles inconsistencias entre las implementaciones.
PASOS_REPRODUCIR:
1.  Verificar la existencia de `pronto-libs/src/pronto_shared/services/menu_service.py`.
2.  Verificar la existencia de `pronto-client/src/pronto_clients/services/menu_service.py`.
RESULTADO_ACTUAL: Existe una implementación de `menu_service.py` en la librería compartida y otra en el módulo `pronto-client`.
RESULTADO_ESPERADO: La lógica del servicio de menú debería centralizarse en `pronto-libs/src/pronto_shared/services/menu_service.py` y ser importada y utilizada por `pronto-client` (y cualquier otro módulo) desde allí.
UBICACION:
- pronto-client/src/pronto_clients/services/menu_service.py
- pronto-libs/src/pronto_shared/services/menu_service.py
EVIDENCIA:
```bash
find pronto-api/src pronto-client/src pronto-employees/src pronto-libs/src/pronto_shared/services -name "menu_service.py"
# Output:
# pronto-client/src/pronto_clients/services/menu_service.py
# pronto-libs/src/pronto_shared/services/menu_service.py
```
HIPOTESIS_CAUSA: El servicio de menú fue implementado localmente en `pronto-client` sin verificar o reutilizar la implementación existente en la librería compartida, o la funcionalidad en `pronto-client` es ligeramente diferente pero no fue parametrizada en la versión compartida.
ESTADO: ABIERTO
---