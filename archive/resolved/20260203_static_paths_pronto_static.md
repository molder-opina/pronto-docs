---
ID: ERR-20260203-STATIC-PATHS
FECHA: 2026-02-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Vue usa rutas /static/* pero static container sirve /assets
DESCRIPCION: Módulos Vue en pronto-static referencian assets con /static/* (audio, favicon, placeholder), pero el contenedor de estáticos expone /assets y no existe favicon/placeholder en /static_content. Esto rompe carga de recursos fuera del proxy de Vite.
PASOS_REPRODUCIR: 1) Abrir flujo que reproduce sonidos o notificaciones. 2) Verificar requests a /static/audio/* o /static/favicon.ico. 3) Revisar respuesta 404.
RESULTADO_ACTUAL: Requests a /static/* fallan o dependen del proxy local.
RESULTADO_ESPERADO: Assets referenciados vía static_host_url/paths de /assets.
UBICACION: pronto-static/src/vue/clients/modules/client-base.ts:198; pronto-static/src/vue/employees/modules/employee-events.ts:577-578; pronto-static/src/vue/employees/modules/menu-manager.ts:85
EVIDENCIA: new Audio(`/static/audio/${soundFile}`), icon: '/static/favicon.ico', placeholder: '/static/img/placeholder.png'.
HIPOTESIS_CAUSA: Migración a static container sin actualizar rutas absolutas.
ESTADO: RESUELTO
---
