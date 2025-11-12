#!/bin/bash

# Script helper untuk manage Docker Compose project
# Usage: ./manage.sh [command]

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}================================${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# Commands
start() {
    print_header "Starting all services..."
    docker-compose up -d
    print_success "All services started!"
    echo ""
    status
}

stop() {
    print_header "Stopping all services..."
    docker-compose stop
    print_success "All services stopped!"
}

restart() {
    print_header "Restarting all services..."
    docker-compose restart
    print_success "All services restarted!"
}

status() {
    print_header "Services Status"
    docker-compose ps
    echo ""
    
    # Check health
    echo -e "${BLUE}Health Checks:${NC}"
    
    # Prometheus
    if curl -s http://localhost:9090/-/healthy > /dev/null 2>&1; then
        print_success "Prometheus: http://localhost:9090"
    else
        print_error "Prometheus: Not responding"
    fi
    
    # Grafana
    if curl -s http://localhost:3001/api/health > /dev/null 2>&1; then
        print_success "Grafana: http://localhost:3001 (admin/admin)"
    else
        print_error "Grafana: Not responding"
    fi
    
    # Ollama
    if curl -s http://localhost:11434/api/tags > /dev/null 2>&1; then
        print_success "Ollama: http://localhost:11434"
    else
        print_error "Ollama: Not responding"
    fi
    
    # Open WebUI
    if curl -s http://localhost:3000 > /dev/null 2>&1; then
        print_success "Open WebUI: http://localhost:3000"
    else
        print_error "Open WebUI: Not responding"
    fi
    
    # cAdvisor
    if curl -s http://localhost:8081 > /dev/null 2>&1; then
        print_success "cAdvisor: http://localhost:8081"
    else
        print_error "cAdvisor: Not responding"
    fi
    
    # Node Exporter
    if curl -s http://localhost:9100/metrics > /dev/null 2>&1; then
        print_success "Node Exporter: http://localhost:9100/metrics"
    else
        print_error "Node Exporter: Not responding"
    fi
}

logs() {
    if [ -z "$2" ]; then
        print_header "Showing logs for all services..."
        docker-compose logs -f
    else
        print_header "Showing logs for $2..."
        docker-compose logs -f "$2"
    fi
}

pull() {
    print_header "Pulling latest images..."
    docker-compose pull
    print_success "All images updated!"
}

update() {
    print_header "Updating all services..."
    docker-compose pull
    docker-compose up -d
    print_success "All services updated and restarted!"
}

clean() {
    print_warning "This will remove all containers and networks (but keep volumes)"
    read -p "Are you sure? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_header "Cleaning up..."
        docker-compose down
        print_success "Cleanup complete!"
    else
        print_warning "Cancelled"
    fi
}

clean_all() {
    print_error "WARNING: This will remove EVERYTHING including volumes (all data will be lost)!"
    read -p "Are you sure? Type 'yes' to confirm: " -r
    echo
    if [[ $REPLY == "yes" ]]; then
        print_header "Removing everything..."
        docker-compose down -v
        print_success "Everything removed!"
    else
        print_warning "Cancelled"
    fi
}

download_model() {
    if [ -z "$2" ]; then
        print_header "Available models:"
        echo "  - llama2 (7B)"
        echo "  - llama3.2 (3B)"
        echo "  - mistral (7B)"
        echo "  - codellama (7B)"
        echo ""
        echo "Usage: ./manage.sh download-model <model-name>"
    else
        print_header "Downloading model: $2"
        docker exec -it ollama ollama pull "$2"
        print_success "Model $2 downloaded!"
    fi
}

list_models() {
    print_header "Installed models:"
    docker exec -it ollama ollama list
}

stats() {
    print_header "Resource usage:"
    docker stats --no-stream
}

backup() {
    print_header "Creating backups..."
    BACKUP_DIR="./backups/$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    
    echo "Backing up Ollama models..."
    docker run --rm -v open-source-project_ollama:/data \
        -v "$(pwd)/$BACKUP_DIR":/backup alpine \
        tar czf /backup/ollama.tar.gz -C /data . 2>/dev/null || true
    
    echo "Backing up Grafana data..."
    docker run --rm -v open-source-project_grafana-data:/data \
        -v "$(pwd)/$BACKUP_DIR":/backup alpine \
        tar czf /backup/grafana.tar.gz -C /data . 2>/dev/null || true
    
    echo "Backing up Open WebUI data..."
    docker run --rm -v open-source-project_open-webui:/data \
        -v "$(pwd)/$BACKUP_DIR":/backup alpine \
        tar czf /backup/open-webui.tar.gz -C /data . 2>/dev/null || true
    
    print_success "Backup completed: $BACKUP_DIR"
}

help() {
    print_header "Docker Compose Management Script"
    echo ""
    echo "Usage: ./manage.sh [command]"
    echo ""
    echo "Commands:"
    echo "  start              Start all services"
    echo "  stop               Stop all services"
    echo "  restart            Restart all services"
    echo "  status             Show status of all services"
    echo "  logs [service]     Show logs (all or specific service)"
    echo "  pull               Pull latest images"
    echo "  update             Pull and restart all services"
    echo "  clean              Remove containers and networks (keep data)"
    echo "  clean-all          Remove everything including data (DANGEROUS)"
    echo "  download-model     Download AI model"
    echo "  list-models        List installed AI models"
    echo "  stats              Show resource usage"
    echo "  backup             Backup all volumes"
    echo "  help               Show this help message"
    echo ""
    echo "Examples:"
    echo "  ./manage.sh start"
    echo "  ./manage.sh logs ollama"
    echo "  ./manage.sh download-model llama2"
    echo "  ./manage.sh status"
}

# Main
case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    status)
        status
        ;;
    logs)
        logs "$@"
        ;;
    pull)
        pull
        ;;
    update)
        update
        ;;
    clean)
        clean
        ;;
    clean-all)
        clean_all
        ;;
    download-model)
        download_model "$@"
        ;;
    list-models)
        list_models
        ;;
    stats)
        stats
        ;;
    backup)
        backup
        ;;
    help|--help|-h)
        help
        ;;
    *)
        print_error "Unknown command: $1"
        echo ""
        help
        exit 1
        ;;
esac
