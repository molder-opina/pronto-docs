# TICKET-B6: Refactor menu_service_impl.py

**Prioridad**: BAJA
**Fase**: FASE 2
**Tiempo estimado**: 1.5 días
**Estado**: ⏸️ SERVICIOS CREADOS, INTEGRACIÓN PENDIENTE
**Fecha inicio**: 2026-03-09
**Fecha actualización**: 2026-03-10

## Descripción

Refactorizar `menu_service_impl.py` extrayendo servicios separados para reducir complejidad.

## Servicios Creados ✅

### 1. MenuQueryService
**Archivo**: `menu_query_service.py` (425 líneas)

**Funciones**:
- `invalidate_menu_cache()` - Invalidar caché de menú
- `get_full_menu()` - Obtener menú completo con caché
- `list_menu()` - Listar todos los items
- `get_menu_item_detail()` - Obtener detalle de item específico
- `get_popular_items()` - Obtener items más populares
- `list_menu_categories()` - Listar categorías y subcategorías
- `_serialize_menu_item()` - Serializar item a dict
- `_is_item_available_now()` - Verificar disponibilidad por horario

**Estado**: ✅ Compila e importa correctamente

---

### 2. MenuMutationService
**Archivo**: `menu_mutation_service.py` (520 líneas)

**Funciones**:
- `create_menu_item()` - Crear item de menú
- `update_menu_item()` - Actualizar item de menú
- `delete_menu_item()` - Eliminar item de menú
- `_normalize_item_name()` - Normalizar nombres para duplicados
- `_find_duplicate_item()` - Buscar items duplicados
- `_parse_uuid()` - Parsear UUID seguro
- `_parse_price()` - Parsear precio seguro
- `_to_bool()` - Convertir a booleano
- `_resolve_category_and_subcategory()` - Resolver categoría y subcategoría
- `_replace_item_labels()` - Reemplazar etiquetas de item
- `_sync_menu_item_modifier_groups()` - Sincronizar grupos de modificadores
- `_sync_menu_package_components()` - Sincronizar componentes de paquete
- `_sync_item_day_periods()` - Sincronizar períodos de día

**Estado**: ✅ Compila e importa correctamente (bug de logger corregido)

---

### 3. MenuCategoryService
**Archivo**: `menu_category_service.py` (355 líneas)

**Funciones**:
- `list_menu_categories()` - Listar categorías
- `create_menu_category()` - Crear categoría
- `update_menu_category()` - Actualizar categoría
- `delete_menu_category()` - Eliminar categoría
- `list_menu_subcategories()` - Listar subcategorías
- `create_menu_subcategory()` - Crear subcategoría
- `update_menu_subcategory()` - Actualizar subcategoría
- `delete_menu_subcategory()` - Eliminar subcategoría
- `_get_or_create_category()` - Obtener o crear categoría

**Estado**: ✅ Compila e importa correctamente

---

### 4. MenuLabelService
**Archivo**: `menu_label_service.py` (285 líneas)

**Funciones**:
- `list_product_labels()` - Listar etiquetas de producto
- `create_product_label()` - Crear etiqueta
- `update_product_label()` - Actualizar etiqueta
- `delete_product_label()` - Eliminar etiqueta
- `update_menu_item_prep_time()` - Actualizar tiempo de preparación
- `get_item_schedules()` - Obtener horarios de item

**Estado**: ✅ Compila e importa correctamente

---

## Estado de Integración

### ❌ NO INTEGRADO

**Razón**: Diferencias significativas en implementación

| Función | Servicio Nuevo | Diferencia |
|---------|---------------|------------|
| `get_full_menu()` | menu_query_service | Original tiene lógica de periods, recommendations, `_get_products_local_now()` |
| `list_menu()` | menu_query_service | Original depende de `get_runtime_menu_payload()` |
| `list_menu_categories()` | menu_category_service | Estructura de respuesta diferente |
| `create_menu_item()` | menu_mutation_service | Original tiene integración con `mark_menu_home_draft_updated()` |
| `update_menu_item()` | menu_mutation_service | Original maneja más campos y validaciones |

### Funciones que FALTAN en servicios nuevos

| Función | Ubicación | Descripción |
|---------|-----------|-------------|
| `_get_products_local_now()` | impl | Timezone para schedules |
| `_is_item_available_by_schedule()` | impl | Disponibilidad por horario |
| `_get_current_period_key()` | impl | Período actual del día |
| `_extract_recommendation_periods()` | impl | Extraer períodos de recomendación |
| `_parse_group_selection_type()` | impl | Tipo de selección de grupo |
| `_serialize_item_modifier_groups()` | impl | Serializar grupos de modificadores |
| `_serialize_package_components()` | impl | Serializar componentes de paquete |
| `get_runtime_menu_payload()` | impl | Payload de runtime para clientes |
| `list_menu_taxonomy()` | impl | Taxonomía del menú |

---

## Validación Realizada

- ✅ Todos los servicios compilan sin errores
- ✅ Todos los servicios importan correctamente
- ✅ Bug de logger en menu_mutation_service corregido
- ❌ Tests de integración no ejecutados
- ❌ Comparación de respuestas API no realizada

---

## Próximos Pasos para Integración Completa

### Opción A: Migración Gradual (Recomendada)

1. **Fase 1**: Usar servicios nuevos para código NUEVO
   - Los servicios están disponibles y funcionales
   - No tocar código existente

2. **Fase 2**: Crear tests de comparación
   - Test que compare respuestas de impl vs nuevos servicios
   - Identificar diferencias específicas

3. **Fase 3**: Sincronizar implementaciones
   - Mover lógica faltante a servicios nuevos
   - O ajustar servicios para que sean idénticos

4. **Fase 4**: Cambiar imports
   - Actualizar imports en pronto-api
   - Eliminar funciones duplicadas de impl

**Tiempo estimado**: 2-3 días

### Opción B: Mantener Estado Actual

- Servicios nuevos disponibles para código nuevo
- menu_service_impl.py se mantiene como fuente principal
- Reducir prioridad de este ticket

---

## Métricas

| Archivo | Líneas | Estado |
|---------|--------|--------|
| menu_service_impl.py | 1373 | Sin cambios |
| menu_query_service.py | 425 | ✅ Nuevo |
| menu_mutation_service.py | 520 | ✅ Nuevo |
| menu_category_service.py | 355 | ✅ Nuevo |
| menu_label_service.py | 285 | ✅ Nuevo |
| **Total nuevos** | **1585** | ✅ Creados |

---

## Criterios de Aceptación

- [x] 4 servicios nuevos creados
- [x] Funciones extraídas con responsabilidades claras
- [x] Sintaxis Python validada en todos los servicios
- [x] Servicios compilan e importan correctamente
- [ ] Tests de comparación implementados
- [ ] Integración completada (imports actualizados)
- [ ] menu_service_impl.py reducido a ≤600 líneas

---

## Referencias

- pronto-docs/migration-plans/pronto-client-to-pronto-api-migration.md
- AGENTS.md sección 0.9 (Calidad de código)
- pronto-libs/src/pronto_shared/services/menu_service_impl.py (archivo original)

---

## Notas

**2026-03-10**: Intento de integración directa cancelado por diferencias en implementación. Los servicios nuevos tienen versiones simplificadas que no cubren toda la lógica del original. Se recomienda migración gradual con tests de comparación.
