# Agente de Auditoría Multi-Modelo

## Descripción

El **Audit Agent** es un agente especializado que realiza revisiones de código usando 3 modelos de IA independientes:
- 🤖 **Claude** (Anthropic) - Enfoque en seguridad y mejores prácticas
- 🧠 **Minimax** - Enfoque en performance y optimización
- 🔬 **GLM4** - Enfoque en arquitectura y mantenibilidad

## Características

- ✅ **Revisión multi-modelo:** 3 perspectivas independientes
- ✅ **Consenso automático:** Agrega resultados de los 3 modelos
- ✅ **Reportes detallados:** Guardados en `.audit_reports/`
- ✅ **Criterios específicos:** Adaptados al proyecto Pronto
- ✅ **Fácil integración:** Compatible con pre-commit hooks

## Uso

### Auditar archivos staged

```bash
# Audita archivos en staging area
./bin/agents/audit-agent.sh
```

### Auditar archivos específicos

```bash
# Audita archivos específicos
./bin/agents/audit-agent.sh build/shared/jwt_middleware.py build/shared/security.py
```

### Auditar todos los archivos

```bash
# Audita todos los archivos Python en build/
./bin/agents/audit-agent.sh --all-files
```

## Criterios de Revisión

El agente evalúa cada archivo en 6 dimensiones:

1. **Seguridad (Security)**
   - Vulnerabilidades
   - Riesgos de inyección
   - Problemas de autenticación
   - Credenciales hardcodeadas

2. **Performance**
   - Ineficiencias
   - Consultas N+1
   - Memory leaks
   - Optimizaciones posibles

3. **Mantenibilidad (Maintainability)**
   - Claridad del código
   - Documentación
   - Convenciones de nombres
   - Complejidad ciclomática

4. **Mejores Prácticas (Best Practices)**
   - Adherencia a estándares Python/JavaScript/TypeScript
   - Patrones de diseño
   - Principios SOLID

5. **Arquitectura**
   - Uso correcto de shared services
   - Implementación JWT
   - Manejo de database sessions
   - Separación de concerns

6. **Manejo de Errores (Error Handling)**
   - Exception handling apropiado
   - Logging adecuado
   - Mensajes de error informativos

## Formato del Reporte

Cada reporte incluye:

```markdown
# Multi-Model Code Audit Report

## Executive Summary
- Fecha y hora
- Modelos utilizados
- Resumen general

## Audit Report: [archivo]

### 🤖 Claude Review
- Overall Score: X/10
- Critical Issues
- Warnings
- Suggestions
- Positive Aspects

### 🧠 Minimax Review
- Overall Score: X/10
- Critical Issues
- Warnings
- Suggestions
- Positive Aspects

### 🔬 GLM4 Review
- Overall Score: X/10
- Critical Issues
- Warnings
- Suggestions
- Positive Aspects

### Consensus Summary
- Average Score
- Common Concerns
- Common Praise
- Recommendation

## Final Summary
- Total Files Audited
- Files Approved
- Files Rejected
- Overall Assessment
```

## Integración con Pre-commit

Para ejecutar automáticamente antes de cada commit:

```yaml
# .pre-commit-config.yaml
repos:
  - repo: local
    hooks:
      - id: audit-agent
        name: Multi-Model Code Audit
        entry: ./bin/agents/audit-agent.sh
        language: script
        pass_filenames: true
        types: [python, javascript, typescript]
```

## Configuración de APIs

Para usar los modelos reales (no placeholders), configura las API keys:

```bash
# config/secrets.env
ANTHROPIC_API_KEY=sk-ant-...
MINIMAX_API_KEY=...
GLM4_API_KEY=...
```

Luego actualiza las funciones en `audit-agent.sh`:

```bash
call_claude() {
    local prompt=$1
    curl -X POST https://api.anthropic.com/v1/messages \
      -H "x-api-key: ${ANTHROPIC_API_KEY}" \
      -H "content-type: application/json" \
      -d "{
        \"model\": \"claude-3-opus-20240229\",
        \"max_tokens\": 1024,
        \"messages\": [{\"role\": \"user\", \"content\": \"${prompt}\"}]
      }"
}
```

## Ejemplos de Uso

### Ejemplo 1: Auditar cambios antes de commit

```bash
# Hacer cambios
vim build/shared/jwt_middleware.py

# Agregar a staging
git add build/shared/jwt_middleware.py

# Auditar
./bin/agents/audit-agent.sh

# Revisar reporte
cat .audit_reports/audit_20260130_225000.md

# Si todo está bien, commit
git commit -m "Refactor JWT middleware"
```

### Ejemplo 2: Auditar módulo completo

```bash
# Auditar todos los archivos de shared services
./bin/agents/audit-agent.sh build/shared/services/*.py

# Revisar reporte
cat .audit_reports/audit_20260130_225100.md
```

### Ejemplo 3: Auditoría completa del proyecto

```bash
# Auditar todo el código Python
./bin/agents/audit-agent.sh --all-files

# Revisar reporte
cat .audit_reports/audit_20260130_225200.md
```

## Interpretación de Resultados

### Scores

- **9-10:** Excelente - Código de producción listo
- **7-8:** Bueno - Mejoras menores sugeridas
- **5-6:** Aceptable - Mejoras importantes recomendadas
- **3-4:** Necesita trabajo - Refactorización requerida
- **1-2:** Crítico - No aprobar sin cambios mayores

### Recomendaciones

- **✅ APPROVED:** Código listo para merge
- **⚠️ APPROVED WITH WARNINGS:** Merge con precaución, mejoras sugeridas
- **❌ REJECTED:** No aprobar, cambios críticos requeridos

## Ventajas del Enfoque Multi-Modelo

1. **Diversidad de Perspectivas:** Cada modelo tiene fortalezas diferentes
2. **Reducción de Sesgos:** El consenso mitiga sesgos individuales
3. **Mayor Cobertura:** Más probabilidad de detectar todos los issues
4. **Confianza:** 3 modelos de acuerdo = alta confianza
5. **Aprendizaje:** Ver diferentes enfoques mejora el código

## Limitaciones

- **Costo:** Usar 3 APIs puede ser costoso
- **Tiempo:** Toma más tiempo que una sola revisión
- **Placeholders:** Versión actual usa placeholders (requiere configuración de APIs)

## Roadmap

- [ ] Integrar APIs reales de Claude, Minimax, GLM4
- [ ] Agregar caché para evitar re-auditar archivos sin cambios
- [ ] Implementar scoring ponderado por tipo de issue
- [ ] Agregar soporte para más lenguajes (Go, Rust, etc.)
- [ ] Dashboard web para visualizar reportes
- [ ] Integración con GitHub Actions

## Contribuir

Para mejorar el agente:

1. Actualizar criterios de revisión en `create_audit_prompt()`
2. Agregar nuevos modelos en funciones `call_*`
3. Mejorar agregación en `aggregate_reviews()`
4. Extender formato de reporte

---

**Creado:** 2026-01-30  
**Autor:** Sistema de Auditoría Pronto  
**Versión:** 1.0.0
