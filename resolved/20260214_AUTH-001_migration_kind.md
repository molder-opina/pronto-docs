ID: AUTH-001
FECHA: 2026-02-14
PROYECTO: pronto-scripts, pronto-libs
SEVERIDAD: bloqueante
TITULO: Migration - Agregar campo kind a Customer
DESCRIPCION: 
La tabla pronto_customers no tiene campo para distinguir entre clientes normales y kioskos.
Se requiere agregar campo kind con valores 'customer' y 'kiosk'.
PASOS_REPRODUCIR:
1. SELECT * FROM pronto_customers LIMIT 1;
2. No existe columna kind
RESULTADO_ACTUAL:
Tabla customers sin distinción de tipo
RESULTADO_ESPERADO:
Tabla con columna kind NOT NULL DEFAULT 'customer' con CHECK constraint
UBICACION:
- pronto-scripts/init/sql/migrations/ (nuevo archivo)
- pronto-libs/src/pronto_shared/models.py
EVIDENCIA:
\d pronto_customers no muestra kind
HIPOTESIS_CAUSA:
Diseño original no contempló tipos de cliente
ESTADO: RESUELTO
SOLUCION:
- Creado migration 20260214_01__customer_kind.sql con ALTER TABLE para agregar kind y kiosk_location
- Agregado CHECK constraint para valores válidos ('customer', 'kiosk')
- Creado índice ix_customer_kind para filtros
- Actualizado modelo Customer en models.py con campos kind y kiosk_location
- Agregada propiedad is_kiosk hybrid property
COMMIT: manual-applied
FECHA_RESOLUCION: 2026-02-14
DEPENDENCIAS: Ninguna (puede ejecutarse independientemente)
BLOQUEA: AUTH-002, AUTH-003, AUTH-004