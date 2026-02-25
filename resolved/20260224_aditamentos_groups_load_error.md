ID: ERR-20260224-ADITAMENTOS-GROUPS-LOAD-500
FECHA: 2026-02-24
PROYECTO: pronto-libs / pronto-employees / pronto-api / pronto-static
SEVERIDAD: alta
TITULO: Aditamentos y Modificadores falla al cargar grupos en dashboard empleados
DESCRIPCION: En la vista de Aditamentos y Modificadores se mostraba el error de carga de grupos por fallas 500 en los endpoints de modifiers.
PASOS_REPRODUCIR:
1. Entrar a `http://localhost:6081/waiter/dashboard` con sesión activa.
2. Abrir módulo `Aditamientos`.
3. Observar mensaje `Error al cargar los grupos de aditamentos.`
RESULTADO_ACTUAL: La UI no carga grupos y el backend responde 500 en `/api/modifiers` y `/api/modifiers/groups`.
RESULTADO_ESPERADO: Debe cargar la lista de grupos y opciones de aditamentos sin error.
UBICACION: pronto-libs/src/pronto_shared/services/modifiers_service.py; pronto-static/src/vue/employees/views/menu/ModifiersEditor.vue; pronto-api/src/api_app/routes/employees/modifiers.py
EVIDENCIA: Reproducción local con curl autenticado devolviendo 500 por atributos inexistentes (`menu_item_id`, `is_default`) en el servicio de modifiers.
HIPOTESIS_CAUSA: Servicio de modifiers desfasado respecto al modelo actual (UUID + `min_selection`/`max_selection` + `display_order`) y fetch del frontend apuntando a endpoint equivocado para grupos.
ESTADO: RESUELTO
SOLUCION: Se reescribió `modifiers_service` para usar campos canónicos del modelo actual, serialización consistente de grupos/modifiers, validación robusta de UUID/campos, y se corrigió frontend para consumir `/api/modifiers/groups` con mapeo seguro.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-24
