ID: LIBS-20260308-INVOICE-MODEL-SCHEMA-LAG
FECHA: 2026-03-08
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: Invoice canónico arrastra drift de schema y duplica tax fields en order_models.py
DESCRIPCION: `pronto-libs/src/pronto_shared/models/order_models.py` incorporó columnas nuevas de invoices (`discount`, `facturapi_customer_id`, `cancelled_by`, `notes`, `raw_response`, `customer_id` nullable), pero dejó duplicadas las definiciones de `tax_id`, `tax_name` y `tax_system` dentro de la misma clase `Invoice`. El modelo efectivo importaba, pero la autoridad Python quedaba confusa y propensa a regresiones.
PASOS_REPRODUCIR:
1. Abrir `pronto-libs/src/pronto_shared/models/order_models.py` en la clase `Invoice`.
2. Buscar `tax_id`, `tax_name` y `tax_system`.
3. Verificar que aparecían dos veces en la misma clase.
RESULTADO_ACTUAL: `Invoice` expone una sola vez los campos fiscales y conserva la superficie alineada al schema vigente.
RESULTADO_ESPERADO: `Invoice` debe exponer una sola vez los campos fiscales y mantener paridad limpia con las migraciones de invoices.
UBICACION: pronto-libs/src/pronto_shared/models/order_models.py
EVIDENCIA: `tests/unit/test_order_models_invoice.py` confirma unicidad de `tax_id`/`tax_name`/`tax_system` y presencia de `discount`, `facturapi_customer_id`, `cancelled_by`, `notes` y `raw_response`; además `pronto-api/tests/test_security_regressions.py -k 'invoice or facturapi'` siguió en verde.
HIPOTESIS_CAUSA: Se mezcló la alineación de schema de invoices con un copy/paste del bloque fiscal al final de la clase.
ESTADO: RESUELTO
SOLUCION: Se dejó una sola definición de `tax_id`, `tax_name` y `tax_system` en `Invoice`, manteniendo el resto de campos ya respaldados por `20260306_06__create_invoices_table.sql` y `20260306_07__alter_invoices_table_add_tax_fields.sql`; se añadió `tests/unit/test_order_models_invoice.py` para asegurar unicidad y paridad básica del modelo.
COMMIT: 934265d
FECHA_RESOLUCION: 2026-03-08

