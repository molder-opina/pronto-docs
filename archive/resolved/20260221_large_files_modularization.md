ID: IMP-20260221-001
FECHA: 2026-02-21
PROYECTO: pronto-static, pronto-api
SEVERIDAD: baja
TITULO: Archivos grandes candidatos a modularización
DESCRIPCION: |
  Varios archivos en el proyecto exceden las 500 líneas y podrían beneficiarse
  de modularización para mejorar mantenibilidad, testabilidad y legibilidad.

PASOS_REPRODUCIR:
  1. Analizar tamaño de archivos con wc -l
  2. Revisar estructura de clases/funciones
  3. Identificar responsabilidades separables

RESULTADO_ACTUAL: |
  Archivos grandes identificados:
  
  **pronto-static (>500 líneas):**
  - cashier-board.ts (1096 líneas) - Panel de cajero
  - tables-manager.ts (1036 líneas) - Gestión de mesas cliente
  - client-base.ts (1024 líneas) - Base de cliente
  - recommendations-manager.ts (717 líneas) - Recomendaciones
  - promotions-manager.ts (702 líneas) - Promociones
  - employee-events.ts (578 líneas) - Eventos empleado
  - client-profile.ts (520 líneas) - Perfil cliente
  - thank-you.ts (506 líneas) - Página de gracias
  
  **pronto-api (>400 líneas):**
  - customers/orders.py (467 líneas)
  - employees/orders.py (438 líneas)
  - employees/sessions.py (436 líneas)

RESULTADO_ESPERADO: |
  Archivos modularizados con responsabilidades únicas (SRP).

UBICACION: |
  pronto-static/src/vue/employees/modules/
  pronto-static/src/vue/clients/modules/
  pronto-api/src/api_app/routes/

ANALISIS_MODULARIZACION: |

  ## 1. cashier-board.ts (1096 líneas)
  
  **Responsabilidades actuales:**
  - Gestión de tabs (active/tracking/paid/cancelled)
  - Filtros de estado y fecha
  - Búsqueda de órdenes
  - Renderizado de tablas
  - Acciones de pago
  - Gestión de órdenes destacadas (starred)
  - Polling de sesiones pagadas
  
  **Módulos propuestos:**
  ```
  cashier-board/
  ├── index.ts              # Export principal
  ├── CashierBoard.ts       # Clase principal (coordinador)
  ├── types.ts              # Interfaces OrderInfo, ClosedSession, etc.
  ├── filters.ts            # Lógica de filtros
  ├── search.ts             # Lógica de búsqueda
  ├── renderer.ts           # Renderizado de tablas
  ├── actions.ts            # Acciones de pago
  └── starred.ts            # Gestión de órdenes destacadas
  ```
  
  ## 2. tables-manager.ts (1036 líneas)
  
  **Responsabilidades actuales:**
  - Renderizado de mapa de mesas
  - Selección de mesa
  - Sincronización con órdenes
  - Animaciones
  - Gestión de estados visuales
  
  **Módulos propuestos:**
  ```
  tables-manager/
  ├── index.ts
  ├── TablesManager.ts      # Clase principal
  ├── types.ts              # Interfaces
  ├── renderer.ts           # Renderizado SVG/Canvas
  ├── interactions.ts       # Click, drag, zoom
  └── animations.ts         # Animaciones de estado
  ```
  
  ## 3. client-base.ts (1024 líneas)
  
  **Responsabilidades actuales:**
  - Inicialización de app cliente
  - Gestión de sesión
  - Navegación
  - Notificaciones
  - Carrito
  
  **Módulos propuestos:**
  ```
  client-base/
  ├── index.ts
  ├── ClientBase.ts
  ├── session.ts            # Gestión de sesión
  ├── navigation.ts         # Navegación y routing
  └── notifications.ts      # Toasts y alerts
  ```
  
  ## 4. recommendations-manager.ts (717 líneas)
  
  **Responsabilidades actuales:**
  - CRUD de recomendaciones
  - Filtros por categoría
  - Ordenamiento drag & drop
  - Paginación
  - Búsqueda
  
  **Módulos propuestos:**
  ```
  recommendations-manager/
  ├── index.ts
  ├── RecommendationsManager.ts
  ├── types.ts
  ├── crud.ts               # Operaciones CRUD
  ├── filters.ts            # Filtros y búsqueda
  └── drag-drop.ts          # Ordenamiento visual
  ```
  
  ## 5. promotions-manager.ts (702 líneas)
  
  **Estructura similar a recommendations-manager**

HIPOTESIS_CAUSA: |
  Los archivos crecieron orgánicamente sin refactoring periódico.
  Falta de límites de líneas en linting.

ESTADO: ABIERTO

ACCIONES_PENDIENTES:
  - [ ] Agregar regla max-lines en ESLint/Ruff
  - [ ] Modularizar cashier-board.ts (mayor impacto)
  - [ ] Modularizar tables-manager.ts
  - [ ] Modularizar client-base.ts
  - [ ] Modularizar recommendations-manager.ts
  - [ ] Modularizar promotions-manager.ts
  - [ ] Revisar archivos Python en pronto-api

PRIORIDAD_SUGERIDA: |
  1. cashier-board.ts - Mayor archivo, mayor complejidad
  2. tables-manager.ts - Segundo mayor
  3. client-base.ts - Core del cliente

BENEFICIOS_ESPERADOS: |
  - Mejor testabilidad (tests unitarios por módulo)
  - Mejor mantenibilidad (responsabilidad única)
  - Mejor legibilidad (archivos más pequeños)
  - Mejor reutilización (módulos independientes)
  - Mejor colaboración (menos conflictos de merge)
