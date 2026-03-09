#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OPENAI_API_KEY="${OPENAI_API_KEY:-}"

PROJECTS=(
    "pronto-client"
    "pronto-tests"
    "pronto-api"
    "pronto-static"
    "pronto-redis"
    "pronto-postgresql"
    "pronto-scripts"
)

usage() {
    echo "Usage: $0 [project_name|all]"
    echo "Projects: ${PROJECTS[*]}"
    exit 1
}

check_git_repo() {
    local project="$1"
    if [ ! -d "../$project/.git" ]; then
        echo "⚠️  $project no es un repositorio git, inicializando..."
        cd "../$project"
        git init
        cd "$SCRIPT_DIR"
    fi
}

get_project_info() {
    local project="$1"
    local base_path="../$project"

    local name="$project"
    local description=""
    local tech_stack=""
    local main_files=""

    case "$project" in
        "pronto-client")
            description="Frontend client para Pronto Cafetería - Interfaz de usuario para clientes"
            tech_stack="TypeScript, Vue.js, Vite, Docker"
            main_files=$(find "$base_path/src" -type f \( -name "*.vue" -o -name "*.ts" \) 2>/dev/null | head -20)
            ;;
        "pronto-tests")
            description="Suite de tests E2E y unitarios para Pronto Cafetería"
            tech_stack="TypeScript, Playwright, Pytest, Docker"
            main_files=$(find "$base_path/tests" -type f -name "*.ts" 2>/dev/null | head -20)
            ;;
        "pronto-api")
            description="API backend principal para Pronto Cafetería"
            tech_stack="Python, FastAPI/Flask, PostgreSQL, Redis, Docker"
            main_files=$(find "$base_path/src" -type f \( -name "*.py" -o -name "*.ts" \) 2>/dev/null | head -20)
            ;;
        "pronto-static")
            description="Contenido estático y assets para Pronto Cafetería"
            tech_stack="Node.js, Vite, Static Files"
            main_files=$(find "$base_path/src" -type f 2>/dev/null | head -20)
            ;;
        "pronto-redis")
            description="Configuración y scripts de Redis para sesiones y caching"
            tech_stack="Redis, Docker, Makefile"
            main_files=$(ls -la "$base_path"/*.yml "$base_path"/Makefile 2>/dev/null)
            ;;
        "pronto-postgresql")
            description="Configuración y migraciones de PostgreSQL para Pronto"
            tech_stack="PostgreSQL, Docker, SQL, Python"
            main_files=$(find "$base_path" -name "*.sql" -o -name "*.py" 2>/dev/null | head -20)
            ;;
        "pronto-scripts")
            description="Scripts de automatización y mantenimiento para el ecosistema Pronto"
            tech_stack="Bash, Python, Docker, SQL"
            main_files=$(find "$base_path/scripts" -maxdepth 1 -type f 2>/dev/null | head -30)
            ;;
    esac

    echo "$name|$description|$tech_stack|$main_files"
}

generate_docs_with_ai() {
    local project="$1"
    local info="$2"

    if [ -z "$OPENAI_API_KEY" ]; then
        echo "⚠️  OPENAI_API_KEY no está configurada, generando documentación básica..."
        generate_basic_docs "$project" "$info"
        return
    fi

    local name=$(echo "$info" | cut -d'|' -f1)
    local description=$(echo "$info" | cut -d'|' -f2)
    local tech_stack=$(echo "$info" | cut -d'|' -f3)

    local prompt="Genera documentación completa en español para el proyecto '$name'.
Descripción: $description
Stack tecnológico: $tech_stack

Estructura del proyecto:
$(ls -la "../$project" 2>/dev/null)

Archivos principales:
$(find "../$project/src" -type f -name "*.py" -o -name "*.ts" -o -name "*.vue" -o -name "*.js" 2>/dev/null | head -30)

Genera un README.md con:
1. Descripción del proyecto
2. Requisitos
3. Instalación
4. Uso
5. Estructura de directorios
6. Scripts disponibles
7. Variables de entorno

Responde SOLO con el contenido del README.md, sin explicaciones."

    local response=$(curl -s "https://api.openai.com/v1/chat/completions" \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $OPENAI_API_KEY" \
        -d "{
            \"model\": \"gpt-4o\",
            \"messages\": [{\"role\": \"user\", \"content\": \"$prompt\"}],
            \"max_tokens\": 4000
        }" 2>/dev/null)

    local content=$(echo "$response" | grep -o '"content":"[^"]*"' | sed 's/"content":"//;s/"$//' | sed 's/\\n/\n/g' | sed 's/\\"/"/g')

    if [ -n "$content" ]; then
        echo "$content" > "../$project/README.md"
        echo "✅ Documentación generada para $project"
    else
        echo "⚠️  Error generando documentación con IA, usando plantilla básica..."
        generate_basic_docs "$project" "$info"
    fi
}

generate_basic_docs() {
    local project="$1"
    local info="$2"

    local name=$(echo "$info" | cut -d'|' -f1)
    local description=$(echo "$info" | cut -d'|' -f2)
    local tech_stack=$(echo "$info" | cut -d'|' -f3)

    cat > "../$project/README.md" << EOF
# $name

$description

## Stack Tecnológico

$tech_stack

## Estructura

\`\`\`
$(ls -la "../$project" | tail -n +2)
\`\`\`

## Uso

Verificar documentación específica en scripts y archivos de configuración.

## Contribución

1. Fork del repositorio
2. Crear rama de feature
3. Commit de cambios
4. Push a la rama
5. Crear Pull Request

## Licencia

MIT
EOF

    echo "✅ Documentación básica generada para $project"
}

update_docs() {
    local project="$1"

    echo "📄 Procesando: $project"

    check_git_repo "$project"

    local info=$(get_project_info "$project")
    generate_docs_with_ai "$project" "$info"

    cd "../$project"
    if [ -n "$(git status --porcelain)" ]; then
        git add README.md 2>/dev/null || true
        git commit -m "docs: actualización de documentación" 2>/dev/null || true
        echo "✅ Cambios guardados en $project"
    else
        echo "ℹ️  Sin cambios en $project"
    fi
    cd "$SCRIPT_DIR"
}

create_remote_repo() {
    local project="$1"
    local info="$2"
    local description=$(echo "$info" | cut -d'|' -f2)

    cd "../$project"

    if ! git remote get-url origin &>/dev/null; then
        echo "🔗 Creando repositorio remoto para $project..."
        gh repo create "$project" --public --description "$description" 2>/dev/null || echo "⚠️  Repo ya existe o error creando"

        if [ -n "$(git rev-parse HEAD 2>/dev/null)" ]; then
            git remote add origin "https://github.com/molder-opina/$project.git" 2>/dev/null || true
            git branch -M main 2>/dev/null || true

            if git ls-remote --heads origin &>/dev/null; then
                git push -u origin main 2>/dev/null || echo "⚠️  Error haciendo push"
            else
                git push -u origin main 2>/dev/null || echo "⚠️  Error haciendo push inicial"
            fi
        fi
    else
        echo "ℹ️  Repo remoto ya configurado para $project"
    fi

    cd "$SCRIPT_DIR"
}

main() {
    local target="${1:-all}"

    if [ "$target" != "all" ]; then
        if [[ ! " ${PROJECTS[*]} " =~ " $target " ]]; then
            echo "❌ Proyecto no reconocido: $target"
            usage
        fi
        PROJECTS=("$target")
    fi

    echo "🚀 Iniciando actualización de documentación..."
    echo "Projects: ${PROJECTS[*]}"
    echo ""

    for project in "${PROJECTS[@]}"; do
        if [ -d "../$project" ]; then
            update_docs "$project"
            create_remote_repo "$project" "$(get_project_info "$project")"
        else
            echo "⚠️  Proyecto no encontrado: $project"
        fi
    done

    echo ""
    echo "✅ Completado!"
}

main "$@"
