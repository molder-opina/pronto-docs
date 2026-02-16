# Documentación de Exenciones CSRF

## Introducción

Este documento explica las exenciones CSRF implementadas en el sistema PRONTO y su justificación técnica.

---

## CSRF (Cross-Site Request Forgery)

CSRF es un ataque que obliga a un usuario autenticado a ejecutar acciones no deseadas en una aplicación web. Flask-WTF proporciona protección CSRF mediante tokens que se validan en cada solicitud POST.

## Exenciones en PRONTO

### 1. Endpoint de System Login

**Ruta:** `POST /system/login`  
**Archivo:** `pronto-employees/src/pronto_employees/routes/system/auth.py`  
**Decorador:** `@csrf.exempt`

**Justificación:**

| Razón | Explicación |
|--------|-------------|
| **Dominios múltiples** | El sistema atiende múltiples restaurantes a través de subdominios (restaurant-a.pronto.sh, restaurant-b.pronto.sh). Los tokens CSRF de Flask están vinculados a un dominio específico, lo que causaría fallos de CSRF cuando el formulario de login se sirve desde un subdominio diferente al del token. |
| **Autenticación JWT** | Este endpoint no utiliza cookies de sesión Flask para mantener estado. En su lugar, utiliza el flujo de autenticación JWT (JSON Web Tokens) que genera tokens de acceso y refresh. |
| **Protecciones alternativas** | El flujo JWT incluye sus propias protecciones de seguridad: <br> • **Firma criptográfica** - Los tokens están firmados con una clave secreta y se valida su integridad <br> • **Expiración** - Los tokens tienen un tiempo de vida limitado (24h para access, 7d para refresh) <br> • **Validación de claims** - Se validan los claims (empleado, rol, scope) del token <br> • **Revocación** - Los tokens pueden ser revocados en caso de compromiso |
| **Sin cookies** | Como el endpoint no utiliza cookies para mantener estado de sesión, el vector de ataque CSRF (inyectar cookie en el navegador del usuario) no aplica. |

**Conclusión de seguridad:** La exención CSRF es APROPIADA y SEGURA dada la arquitectura JWT que reemplaza el uso de cookies de sesión para autenticación.

---

## Criterios para Exención CSRF

### Cuándo eximir CSRF

Un endpoint puede eximirse de CSRF SI cumple con ALGUNO de estos criterios:

1. **JWT sin cookies:** El endpoint utiliza autenticación JWT sin cookies de sesión Flask
2. **Dominios múltiples:** El formulario es accesible desde múltiples subdominios configurados
3. **API pública:** Es un endpoint de API autenticado pero no requiere estado de sesión en cookies
4. **Validación de tokens:** Implementa su propia validación de tokens (como JWT)

### Cuándo NO eximir CSRF

Un endpoint NO debe eximirse de CSRF si cumple con ALGUNO de estos criterios:

1. **Formularios web con cookies:** El endpoint usa cookies de sesión Flask (`flask.session`)
2. **Modificación de estado:** El endpoint modifica estado en el servidor que requiere protección CSRF
3. **Sin validación propia:** No implementa validación de tokens propia

---

## Auditoría de Exenciones Actuales

| Endpoint | Ruta | Archivo | Estado |
|----------|------|----------|--------|
| System Login | `POST /system/login` | `pronto-employees/routes/system/auth.py` | ✅ Justificado en este documento |

---

## Referencias

- [Flask-WTF CSRF Documentation](https://flask-wtf.readthedocs.io/en/stable/csrf/)
- [OWASP CSRF Prevention Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site_Request_Forgery_Prevention_Cheat_Sheet.html)
- [JWT vs Session-based Auth](https://auth0.com/blog/jwt-vs-session-cookies)

---

**Mantenido por:** Equipo de Seguridad PRONTO  
**Última actualización:** 2026-02-09  
**Versión:** 1.0
