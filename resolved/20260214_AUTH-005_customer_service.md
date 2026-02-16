ID: AUTH-005
FECHA: 2026-02-14
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: customer_service - Agregar soporte para kind y filtros
DESCRIPCION: 
customer_service.py no soporta parámetro kind en create_customer ni filtros en search.
PASOS_REPRODUCIR:
1. create_customer(..., kind="kiosk") -> TypeError: unexpected keyword argument
2. search_customers(db, query, kind="kiosk") -> TypeError
RESULTADO_ACTUAL:
Funciones sin soporte para kind
RESULTADO_ESPERADO:
- create_customer acepta kind y kiosk_location
- search_customers acepta filtro por kind
- Nueva función get_kiosks()
UBICACION:
- pronto-libs/src/pronto_shared/services/customer_service.py
EVIDENCIA:
TypeError al llamar con kind
HIPOTESIS_CAUSA:
Funciones creadas antes de requerimiento de tipos
ESTADO: RESUELTO
DEPENDENCIAS: AUTH-002 (requiere modelo actualizado)
BLOQUEA: AUTH-008, AUTH-009
SOLUCION: Funciones ya implementadas en customer_service.py:
- create_customer() acepta kind y kiosk_location params
- search_customers() acepta filtro kind
- get_kiosks() retorna todas las cuentas kiosk
- delete_customer() hard delete para kiosks
COMMIT: N/A (ya estaba implementado)
FECHA_RESOLUCION: 2026-02-14