# Configuración de Reverse Proxy

## Nginx

Si usas nginx delante de la app, configura correctamente los headers:

```nginx
server {
    listen 80;
    server_name app.example.com;

    location / {
        proxy_pass http://127.0.0.1:6081;

        # ✅ CRÍTICO: Sobrescribir (no pasar) headers X-Forwarded-*
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Real-IP $remote_addr;

        # Headers adicionales
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Port $server_port;

        # Evitar pasar headers maliciosos del cliente
        proxy_set_header X-Forwarded-User "";
    }
}
```

**Configuración en .env:**

```bash
NUM_PROXIES=1
ALLOWED_HOSTS=app.example.com
```

## Cloudflare + Nginx

Si usas Cloudflare delante de nginx:

```bash
NUM_PROXIES=2
ALLOWED_HOSTS=app.example.com
```

## Sin proxy (desarrollo local)

```bash
NUM_PROXIES=0
ALLOWED_HOSTS=localhost:6081,127.0.0.1:6081
```

## Verificación

Después de configurar, verifica que `request.host` es correcto:

```python
# En cualquier ruta, loggear:
current_app.logger.info(f"request.host={request.host}, remote_addr={request.remote_addr}")
```

Debe mostrar el host público correcto, no el interno (127.0.0.1).

## Troubleshooting

### Problema: Origin mismatch errors

**Síntoma**: Logs muestran "Origin mismatch" al usar reauth

**Solución**: Verifica que ALLOWED_HOSTS incluye el host correcto con puerto:
```bash
# Incorrecto (falta puerto)
ALLOWED_HOSTS=localhost

# Correcto
ALLOWED_HOSTS=localhost:6081,127.0.0.1:6081
```

### Problema: Token leakage warnings

**Síntoma**: DevTools muestra token en URL

**Solución**: Asegúrate que estás usando POST redirect, no GET. El template `system_reauth_redirect.html` debe usar auto-submit de form POST.

### Problema: CSRF errors en super_admin_login

**Síntoma**: Error 400 al consumir token

**Solución**: El endpoint debe tener `@csrf.exempt`. Verifica que `from build.employees_app.extensions import csrf` está presente.
