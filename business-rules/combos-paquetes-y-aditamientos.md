# Regla de Negocio: Combos/Paquetes y Aditamientos

## Estado
- Vigente (P0)
- Fecha: 2026-02-23

## Objetivo
Definir la regla canónica para combos/paquetes en PRONTO, asegurando que:
- los combos se construyan con productos reales del catálogo,
- los aditamientos del combo respeten la composición base,
- la experiencia de `pronto-client` y la data de backend sean consistentes.

## Regla Canónica

1. Combo/paquete no es un producto aislado.
- Un combo representa una composición de productos existentes en `pronto_menu_items`.
- La definición del combo debe poder trazarse a productos base concretos.

2. Herencia de aditamientos.
- El combo hereda `modifier_groups` de los productos base.
- Adicionalmente puede tener `modifier_groups` específicos del combo (por ejemplo: extras del combo).
- Los grupos específicos no sustituyen por defecto a los heredados.

3. Opciones incluidas del combo.
- Grupos como "bebida incluida" y "guarnición incluida" deben derivar de productos existentes.
- No usar listas hardcodeadas desconectadas del catálogo real cuando se normaliza seed/init.

4. Idempotencia y limpieza de legacy.
- La normalización de combos en seed/init debe ser idempotente.
- Si hay grupos legacy equivalentes, deben limpiarse para evitar duplicidad semántica en UI/API.

## Implementación Técnica Actual (Referencia)

- Fuente de normalización de combos:
  - `/Users/molder/projects/github-molder/pronto/pronto-libs/src/pronto_shared/services/seed.py`
  - función: `_ensure_menu_distribution_profile(...)`

- Exposición al cliente:
  - `GET /api/menu` con `modifier_groups` por item
  - consumo en `pronto-client` desde endpoint de menú.

## Criterios de Aceptación

1. Cada combo visible en menú incluye grupos heredados de sus productos base.
2. Cada combo puede incluir grupo(s) adicional(es) específico(s) del combo.
3. No hay coexistencia de grupos legacy duplicados para la misma intención funcional de combo.
4. El resultado es consistente entre DB y respuesta de `GET /api/menu`.

## Verificación Operativa (Checklist rápida)

1. DB:
- Validar que combos existan y estén en categoría `Combos`.
- Validar que combos tengan `modifier_groups` heredados + específicos.
- Validar ausencia de grupos legacy duplicados en combos.

2. API:
- Consultar `GET /api/menu`.
- Confirmar que items de categoría `Combos` incluyan sus `modifier_groups` esperados.

3. UI:
- En `pronto-client`, abrir un combo y confirmar que el modal muestre aditamientos heredados y extras de combo.
