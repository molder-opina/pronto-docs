# Bug Report: Datos de usuario almacenados en localStorage vulnerable a XSS

ID: BUG-20250215-003
FECHA: 2025-02-15
PROYECTO: pronto-static (cliente Vue)
SEVERIDAD: media
TITULO: Usuario almacenado en localStorage expone datos a ataques XSS

## DESCRIPCION

El archivo `client-profile.ts` guarda los datos del usuario en `localStorage` en lugar de usar la sesión del servidor. Esto expone los datos del usuario a vulnerabilidades XSS (Cross-Site Scripting).

## PASOS_REPRODUCIR

1. Un atacante inyecta script malicioso en la página
2. El script accede a `localStorage.getItem('pronto-user')`
3. Extrae datos del usuario (email, nombre)

## RESULTADO_ACTUAL

```typescript
// client-profile.ts
function saveCurrentUser(user: ProntoUser): void {
  localStorage.setItem('pronto-user', JSON.stringify(user));
}

function getCurrentUser(): ProntoUser | null {
  const item = localStorage.getItem('pronto-user');
  ...
}
```

## RESULTADO_ESPERADO

Usar `sessionStorage` en lugar de `localStorage`, o mejor aún, obtener los datos del usuario del endpoint `/api/me` en cada request que necesite verificar autenticación.

## UBICACION

`pronto-static/src/vue/clients/modules/client-profile.ts`

## EVIDENCIA

Líneas ~315-330:
```typescript
function saveCurrentUser(user: ProntoUser): void {
  localStorage.setItem('pronto-user', JSON.stringify(user));
}

function getCurrentUser(): ProntoUser | null {
  const item = localStorage.getItem('pronto-user');
  if (!item) return null;
  try {
    return JSON.parse(item) as ProntoUser;
  } catch {
    return null;
  }
}
```

## HIPOTESIS_CAUSA

El desarrollador eligió localStorage por conveniencia para persistencia entre refreshes, sin considerar el riesgo de seguridad.

## ESTADO: RESUELTO
