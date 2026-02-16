---
ID: STATIC_ASSETS_EXTERNAL_FONTS
FECHA: 20260206
PROYECTO: pronto-employees
SEVERIDAD: media
TITULO: Referencia a Google Fonts externa en templates de empleados
DESCRIPCION: Los templates de `pronto-employees` hacen referencia directa a fuentes externas de Google Fonts, lo cual contradice el principio "Todo CSS/JS/Images/Audio vive aquí." establecido en `AGENTS.md`, implicando que todos los assets deben ser servidos por `pronto-static`.
PASOS_REPRODUCIR:
1. Abrir cualquier template de login (ej. `pronto-employees/src/pronto_employees/templates/login_admin.html`).
2. Observar las etiquetas `<link>` que cargan recursos de `fonts.googleapis.com` y `fonts.gstatic.com`.
RESULTADO_ACTUAL: Las fuentes CSS y otros recursos se cargan desde CDNs externos, desviándose del uso de `pronto-static` como fuente única para assets.
RESULTADO_ESPERADO: Todas las fuentes y assets deberían ser gestionados y servidos a través de `pronto-static` para asegurar un control total y consistencia, o establecer una política clara sobre la excepción de CDNs externos.
UBICACION:
- pronto-employees/src/pronto_employees/templates/login_cashier.html:L8-L10
- pronto-employees/src/pronto_employees/templates/login_system.html:L8-L10
- pronto-employees/src/pronto_employees/templates/login.html:L8-L10
- pronto-employees/src/pronto_employees/templates/login_waiter.html:L8-L10
- pronto-employees/src/pronto_employees/templates/admin/dashboard.html:L8-L10
- pronto-employees/src/pronto_employees/templates/console_selector.html:L8-L10
- pronto-employees/src/pronto_employees/templates/login_chef.html:L8-L10
- pronto-employees/src/pronto_employees/templates/base.html:L14-L16
EVIDENCIA:
```html
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700&display=swap" rel="stylesheet" />
```
HIPOTESIS_CAUSA: Se priorizó la facilidad de uso de Google Fonts sin considerar la directriz de centralizar todos los assets en `pronto-static`.
ESTADO: ABIERTO
---