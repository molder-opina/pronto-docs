# AUTH Bugs - Orden de Ejecución

## Resumen

| ID | Título | Severidad | Dependencias | Ejecución |
|----|--------|-----------|--------------|-----------|
| AUTH-001 | Migration kind | bloqueante | - | INDEPENDIENTE |
| AUTH-002 | Modelo Customer | bloqueante | AUTH-001 | SECUENCIAL |
| AUTH-003 | CustomerSessionStore | bloqueante | AUTH-002 | SECUENCIAL |
| AUTH-004 | Decorator require_customer_session | bloqueante | AUTH-003 | SECUENCIAL |
| AUTH-005 | customer_service kind | alta | AUTH-002 | SECUENCIAL |
| AUTH-006 | Quitar JWT client | bloqueante | AUTH-003, AUTH-004 | SECUENCIAL |
| AUTH-007 | Web auth endpoints | bloqueante | AUTH-003, AUTH-005, AUTH-006 | SECUENCIAL |
| AUTH-008 | Proxy API header | alta | AUTH-003, AUTH-006 | SECUENCIAL |
| AUTH-009 | API decorator | alta | AUTH-004 | SECUENCIAL |
| AUTH-010 | Eliminar client_auth | media | AUTH-007, AUTH-009 | SECUENCIAL |
| AUTH-011 | Eliminar create_client_token | media | AUTH-007 | SECUENCIAL |
| AUTH-012 | Kiosko endpoints | media | AUTH-003, AUTH-005 | SECUENCIAL |
| AUTH-013 | Admin kioskos API | media | AUTH-005 | SECUENCIAL |
| AUTH-014 | Vue admin panel | baja | AUTH-013 | SECUENCIAL |
| AUTH-015 | Seeds dev | alta | AUTH-001, AUTH-002 | SECUENCIAL |
| AUTH-016 | Unit tests | alta | AUTH-003, AUTH-004 | SECUENCIAL |
| AUTH-017 | E2E tests | alta | AUTH-007, AUTH-015 | SECUENCIAL |
| AUTH-018 | Validation scripts | media | AUTH-007, AUTH-015 | SECUENCIAL |
| AUTH-019 | Documentation | baja | AUTH-001 | SECUENCIAL |
| AUTH-020 | Versioning | baja | - | INDEPENDIENTE (al final) |

---

## Fases de Ejecución

### FASE 1: Infraestructura Base (Independientes/Secuenciales)

**Pueden ejecutarse en paralelo:**
- AUTH-001 (migration) 
- AUTH-020 (versioning) ← ejecutar al final

**Secuencia obligatoria:**
```
AUTH-001 → AUTH-002 → AUTH-003 → AUTH-004
```

### FASE 2: Servicios y Refactor

**Secuencia:**
```
AUTH-002 → AUTH-005 (customer_service)
AUTH-003 + AUTH-004 + AUTH-005 → AUTH-006 (quitar JWT)
AUTH-003 + AUTH-005 + AUTH-006 → AUTH-007 (web endpoints)
AUTH-003 + AUTH-006 → AUTH-008 (proxy API)
AUTH-004 → AUTH-009 (API decorator)
```

### FASE 3: Limpieza

**Depende de FASE 2 completa:**
```
AUTH-007 + AUTH-009 → AUTH-010 (eliminar client_auth)
AUTH-007 → AUTH-011 (eliminar create_client_token)
```

### FASE 4: Features Adicionales

**Depende de FASE 2:**
```
AUTH-003 + AUTH-005 → AUTH-012 (kiosko endpoints)
AUTH-005 → AUTH-013 (admin kioskos API)
AUTH-013 → AUTH-014 (Vue admin panel)
```

### FASE 5: Seeds y Tests

**Depende de FASE 1:**
```
AUTH-001 + AUTH-002 → AUTH-015 (seeds)
AUTH-003 + AUTH-004 → AUTH-016 (unit tests)
AUTH-007 + AUTH-015 → AUTH-017 (E2E tests)
AUTH-007 + AUTH-015 → AUTH-018 (validation scripts)
```

### FASE 6: Documentación Final

```
AUTH-001 → AUTH-019 (documentation)
```

---

## Ejecución Óptima (Minimizar Bloqueos)

### Sprint 1: Base de datos y modelos
```
AUTH-001 (migration)
AUTH-002 (modelo)
AUTH-015 (seeds) - después de AUTH-001 y AUTH-002
```

### Sprint 2: Core de autenticación
```
AUTH-003 (session store)
AUTH-004 (decorator)
AUTH-005 (customer_service)
```

### Sprint 3: Refactor pronto-client
```
AUTH-006 (quitar JWT)
AUTH-007 (web endpoints)
AUTH-008 (proxy API)
```

### Sprint 4: Refactor pronto-api
```
AUTH-009 (API decorator)
AUTH-010 (eliminar client_auth)
AUTH-011 (eliminar create_client_token)
```

### Sprint 5: Features kiosko
```
AUTH-012 (kiosko endpoints)
AUTH-013 (admin kioskos API)
AUTH-014 (Vue admin panel)
```

### Sprint 6: Tests y validación
```
AUTH-016 (unit tests)
AUTH-017 (E2E tests)
AUTH-018 (validation scripts)
```

### Sprint 7: Finalización
```
AUTH-019 (documentation)
AUTH-020 (versioning)
```

---

## Bugs Independientes (Pueden ejecutarse sin afectar otros)

| ID | Descripción | Cuándo ejecutar |
|----|-------------|-----------------|
| AUTH-001 | Migration kind | Primero |
| AUTH-020 | Versioning | Último (después de todo) |

## Bugs Críticos (Bloquean a otros)

| ID | Bloquea a | Debe completarse antes de |
|----|-----------|---------------------------|
| AUTH-001 | AUTH-002, AUTH-015, AUTH-019 | Sprint 2 |
| AUTH-002 | AUTH-003, AUTH-005 | Sprint 2 |
| AUTH-003 | AUTH-004, AUTH-006, AUTH-007, AUTH-008, AUTH-012, AUTH-016 | Sprint 3 |
| AUTH-004 | AUTH-006, AUTH-009, AUTH-016 | Sprint 3 |
| AUTH-005 | AUTH-007, AUTH-012, AUTH-013 | Sprint 3 |

---

## Comando para ver estado de bugs

```bash
# Ver todos los bugs
ls -la pronto-docs/errors/AUTH-*.md

# Ver bugs abiertos
grep -l "ESTADO: ABIERTO" pronto-docs/errors/AUTH-*.md

# Ver bugs resueltos
ls -la pronto-docs/resolved/AUTH-*.md 2>/dev/null || echo "Ninguno resuelto aún"
```

---

## Cómo resolver un bug

1. Abrir archivo en `pronto-docs/errors/AUTH-XXX_*.md`
2. Implementar solución
3. Actualizar archivo con:
   - ESTADO: RESUELTO
   - SOLUCION: (descripción)
   - COMMIT: (hash)
   - FECHA_RESOLUCION: YYYY-MM-DD
4. Mover a `pronto-docs/resolved/`
5. Agregar entrada a `pronto-docs/resueltos.txt`