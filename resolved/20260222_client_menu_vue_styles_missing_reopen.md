ID: ERR-20260222-CLIENT-MENU-VUE-STYLES-MISSING-REOPEN-01
FECHA: 2026-02-22
PROYECTO: pronto-client, pronto-static
SEVERIDAD: alta
TITULO: Reapertura - menú clientes mantiene CSS viejo por cache immutable
DESCRIPCION:
Reapertura del incidente `ERR-20260222-CLIENT-MENU-VUE-STYLES-MISSING`. Aun con cambios en `menu-updates.css`, la UI seguía mostrando el layout roto porque el HTML referenciaba `menu-updates.css?v=2` y el asset se sirve con `Cache-Control: immutable`, reutilizando la versión cacheada.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6080/` tras aplicar cambios CSS.
2. Confirmar que sigue el layout previo en navegador del usuario.
3. Verificar `link` con `menu-updates.css?v=2` y headers `immutable`.
RESULTADO_ACTUAL:
El navegador mantenía CSS desactualizado; `.product-card__image-container` quedaba en `height: 0`.
RESULTADO_ESPERADO:
El cliente debe descargar la versión nueva de CSS para aplicar el fix de layout.
UBICACION:
- pronto-client/src/pronto_clients/templates/index.html
- pronto-static/src/static_content/assets/css/clients/menu-updates.css
EVIDENCIA:
- Header: `Cache-Control: public, max-age=604800, immutable`
- Link en HTML: `menu-updates.css?v=2`
- Reproducción visual reportada por usuario
HIPOTESIS_CAUSA:
Cache busting fijo (`v=2`) incompatible con strategy immutable.
ESTADO: RESUELTO
SOLUCION:
Se actualizó `index.html` para versionar `menu.css` y `menu-updates.css` con `{{ system_version }}`, forzando invalidación de caché en cada incremento de versión.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-22
