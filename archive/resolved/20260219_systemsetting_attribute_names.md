ID: ERR-20260219-SYSTEMSETTING-ATTRIBUTE-NAMES
FECHA: 2026-02-19
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: settings_service.py usa nombres de atributos incorrectos en SystemSetting
DESCRIPCION: El modelo SystemSetting tiene atributos config_key y config_value mapeados a columnas 'key' y 'value', pero settings_service.py usaba SystemSetting.key, setting.key, setting.value que no existen, causando AttributeError en runtime.
PASOS_REPRODUCIR:
1. Iniciar pronto-client
2. Cualquier acceso a settings causa error
3. Ver logs: "type object 'SystemSetting' has no attribute 'key'"
RESULTADO_ACTUAL: Error al obtener configuraciones del sistema
RESULTADO_ESPERADO: Settings se obtienen correctamente
UBICACION: pronto-libs/src/pronto_shared/services/settings_service.py
EVIDENCIA:
```
Error fetching setting show_estimated_time: type object 'SystemSetting' has no attribute 'key'
```
HIPOTESIS_CAUSA: Refactor del modelo cambio nombres de atributos pero servicio no se actualizo
ESTADO: RESUELTO
SOLUCION: 
1. Cambiado SystemSetting.key → SystemSetting.config_key en todas las queries
2. Cambiado setting.key → setting.config_key en acceso a instancias
3. Cambiado setting.value → setting.config_value en acceso a instancias
4. Agregado metodo get_typed_value() al modelo SystemSetting
COMMIT: pending
FECHA_RESOLUCION: 2026-02-19
