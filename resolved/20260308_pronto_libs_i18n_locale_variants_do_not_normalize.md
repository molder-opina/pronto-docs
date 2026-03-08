ID: LIBS-20260308-I18N-LOCALE-NORMALIZATION
FECHA: 2026-03-08
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: I18nService no normaliza variantes de locale como es-MX o en_US
DESCRIPCION: `pronto-libs/src/pronto_shared/i18n/service.py` solo aceptaba locales exactos presentes en `locales/*.json` (`es`, `en`). Variantes comunes como `es-MX`, `es_ES` o `en_US` caían en fallback y no cambiaban el locale efectivo aunque el idioma base sí existiera.
PASOS_REPRODUCIR:
1. Importar `I18nService` desde `pronto_shared.i18n.service`.
2. Ejecutar `service.set_locale("es-MX")`.
3. Revisar `service._current_locale`.
RESULTADO_ACTUAL: El servicio normaliza variantes regionales hacia el idioma base disponible y permite traducir con `es`/`en`.
RESULTADO_ESPERADO: El servicio debe normalizar variantes (`es-MX` -> `es`, `en_US` -> `en`) cuando exista el idioma base.
UBICACION: pronto-libs/src/pronto_shared/i18n/service.py
EVIDENCIA: Pruebas unitarias `tests/unit/test_i18n_service.py` cubren `es-MX` y `en_US`, y smoke local confirmó `LOCALE_AFTER_ES_MX es` y `LOCALE_AFTER_EN_US en`.
HIPOTESIS_CAUSA: `set_locale()` comparaba solo el string completo del locale y no derivaba una clave normalizada por idioma base.
ESTADO: RESUELTO
SOLUCION: `set_locale()` ahora deriva `normalized_locale` separando por `-` y `_`, reutiliza el idioma base si existe y quedó cubierto por `tests/unit/test_i18n_service.py`; el mismo batch modularizó `seed_impl.py` en `services/seeds/*` y añadió `tests/unit/test_seed_impl.py` para validar delegación/commit/rollback.
COMMIT: c4522c7
FECHA_RESOLUCION: 2026-03-08

