ID: TEST-001
FECHA: 2026-03-05
PROYECTO: pronto-tests
SEVERIDAD: alta
TITULO: MenuValidator acumula errores entre llamadas
DESCRIPCION: El MenuValidator en menu_validation.py acumula errores en la lista self.errors entre diferentes llamadas a validate_create(). Esto causa que tests que deberían pasar fallen porque errores de validaciones anteriores persisten.
PASOS_REPRODUCIR:
1. Crear una instancia de MenuValidator
2. Llamar validate_create con datos válidos
3. Observar que lanza MenuValidationError aunque los datos son válidos
RESULTADO_ACTUAL: Errores de validaciones anteriores persisten en self.errors
RESULTADO_ESPERADO: Cada llamada a validate_create debería empezar con una lista de errores limpia
UBICACION: pronto-libs/src/pronto_shared/services/menu_validation.py
EVIDENCIA: Tests test_validate_name, test_validate_price, etc. fallan porque la segunda llamada a validate_create() acumula errores
HIPOTESIS_CAUSA: El validador no limpia self.errors al inicio de cada validate_create()
ESTADO: RESUELTO
SOLUCION: Se reinicia `self.errors` al inicio de `validate_create`, `validate_update` y `validate_delete` para evitar acumulación de errores entre invocaciones.
COMMIT: fea629d
FECHA_RESOLUCION: 2026-03-05
