ID: DELIVERY-CANCELLATION-INTEGRATION-001
FECHA: 2026-03-12
PROYECTO: PRONTO
SEVERIDAD: alta
TITULO: Sistema de entrega parcial y cancelación por item no integrado correctamente
DESCRIPCION: 
El sistema de cancelación inteligente implementado no está completamente integrado con el sistema de entrega parcial. 
Faltan componentes críticos para restaurantes medianos/chicos que necesitan operación rápida, modelo mantenible, y pocos bugs contables.

**REGLA FUNDAMENTAL**: Todo desarrollo en PRONTO debe optimizarse para restaurantes pequeños/medianos, priorizando:
- Operación rápida (mesero cansado, cocina rápida)
- Modelo fácil de mantener (sin sobreingeniería)
- Pocos bugs contables (consistencia financiera)
- Funcionalidad esencial (no complejidad innecesaria)

UBICACION: pronto-libs, pronto-api, pronto-static, pronto-employees
EVIDENCIA: 
- OrderItem model necesita campos prepared_at y created_at
- Estado de orden no se calcula correctamente desde items activos
- Frontend de empleados no muestra estados por item (queued, preparing, ready, delivered, cancelled)
- No existe funcionalidad de entrega parcial en interfaces de mesero
- Concurrencia no protegida en operaciones de entrega/cancelación
HIPOTESIS_CAUSA: Implementación inicial enfocada solo en cancelación, sin considerar integración completa con entrega parcial y sin aplicar regla fundamental de optimización para restaurantes pequeños/medianos
ESTADO: ABIERTO