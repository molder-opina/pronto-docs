---
ID: CSRF_EXEMPTIONS_CLIENT_API
FECHA: 20260206
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: Exenciones masivas de CSRF en la API del cliente
DESCRIPCION: El archivo `pronto-client/src/pronto_clients/app.py` tiene `WTF_CSRF_ENABLED = True` configurado globalmente, pero exime explícitamente a numerosos blueprints de la API (`api_bp`, `auth_bp`, `orders_bp`, `stripe_payments_bp`, `sessions_bp`, `feedback_bp`, `payments_bp`) de la protección CSRF. Esto es inconsistente con las estrictas reglas de CSRF para el frontend de `pronto-employees` detalladas en `AGENTS.md` (sección 15.3), y podría representar una vulnerabilidad de seguridad para endpoints mutantes (POST, PUT, DELETE, PATCH) si no hay un mecanismo de protección alternativo robusto.
PASOS_REPRODUCIR:
1. Revisar `pronto-client/src/pronto_clients/app.py`.
2. Observar las líneas 59-67 donde se utiliza `csrf_protection.exempt()` para múltiples blueprints.
RESULTADO_ACTUAL: La mayoría de los endpoints de la API orientados al cliente están exentos de la validación CSRF. El wrapper de `http.ts` del cliente (`pronto-static/src/vue/clients/core/http.ts`) no envía el token CSRF, lo cual, si la exención no fuera aplicada, resultaría en fallos de autenticación.
RESULTADO_ESPERADO: Se debe justificar explícitamente la exención de CSRF para cada blueprint o implementar una estrategia de protección alternativa. Si la protección CSRF es deseable para el cliente, el frontend de Vue (`pronto-static/src/vue/clients`) debería enviar el token CSRF en las solicitudes mutantes, y el backend (`pronto-client`) no debería eximir los endpoints.
UBICACION:
- pronto-client/src/pronto_clients/app.py:L59-L67
- pronto-static/src/vue/clients/core/http.ts (ausencia de manejo de CSRF)
EVIDENCIA:
```python
# pronto-client/src/pronto_clients/app.py (extract)
    csrf_protection.exempt(api_bp)
    csrf_protection.exempt(auth_bp)
    csrf_protection.exempt(orders_bp)
    csrf_protection.exempt(stripe_payments_bp)
    csrf_protection.exempt(sessions_bp)
    csrf_protection.exempt(feedback_bp)
    csrf_protection.exempt(payments_bp)
```
HIPOTESIS_CAUSA: La arquitectura del cliente puede depender de una estrategia de autenticación diferente que hace que la protección CSRF tradicional sea redundante, o se optó por la exención por simplicidad sin una evaluación completa de seguridad.
ESTADO: RESUELTO
---