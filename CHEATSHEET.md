# 🚀 Quick Reference Cheatsheet

## 📋 Essential Commands

### Start/Stop Services
```bash
./manage.sh start          # Start all services
./manage.sh stop           # Stop all services
./manage.sh restart        # Restart all services
./manage.sh status         # Check status + health
```

### Monitoring
```bash
./manage.sh stats          # Resource usage
./manage.sh logs           # All logs
./manage.sh logs ollama    # Specific service logs
```

### AI Models
```bash
./manage.sh download-model llama2    # Download model
./manage.sh list-models              # List installed models
```

### Maintenance
```bash
./manage.sh update         # Update all images
./manage.sh backup         # Backup all data
./manage.sh clean          # Remove containers (keep data)
```

## 🌐 Quick Access URLs

```
Open WebUI:     http://localhost:3000
Grafana:        http://localhost:3001  (admin/admin)
Prometheus:     http://localhost:9090
cAdvisor:       http://localhost:8081
Node Exporter:  http://localhost:9100/metrics
```

## 🐳 Docker Compose Commands

```bash
docker-compose up -d              # Start in background
docker-compose down               # Stop and remove
docker-compose ps                 # List services
docker-compose logs -f [service]  # Follow logs
docker-compose restart [service]  # Restart service
docker-compose pull               # Pull latest images
```

## 🤖 Ollama Commands

```bash
# Download models
docker exec -it ollama ollama pull llama2
docker exec -it ollama ollama pull mistral
docker exec -it ollama ollama pull codellama

# List models
docker exec -it ollama ollama list

# Run model (CLI)
docker exec -it ollama ollama run llama2 "Hello!"

# Remove model
docker exec -it ollama ollama rm llama2
```

## 📊 Grafana Quick Setup

```bash
1. Open: http://localhost:3001
2. Login: admin / admin
3. Click "+" → "Import"
4. Enter Dashboard ID: 1860
5. Select Prometheus datasource
6. Click "Import"
```

### Recommended Dashboards
- **1860** - Node Exporter Full (Server metrics)
- **193** - Docker Container & Host Metrics
- **14282** - cAdvisor exporter

## 🔍 Troubleshooting

### Port Already in Use
```bash
# Find process using port
ss -tlnp | grep <port>

# Kill process
sudo fuser -k <port>/tcp

# Or stop service
sudo systemctl stop <service-name>
```

### Container Won't Start
```bash
# Check logs
docker-compose logs <service-name>

# Remove and recreate
docker-compose down
docker-compose up -d
```

### Reset Everything
```bash
# Remove all (including data)
docker-compose down -v

# Clean Docker system
docker system prune -a

# Start fresh
docker-compose up -d
```

## 📦 Backup & Restore

### Backup
```bash
# Using script
./manage.sh backup

# Manual backup
docker run --rm \
  -v open-source-project_ollama:/data \
  -v $(pwd):/backup alpine \
  tar czf /backup/ollama.tar.gz -C /data .
```

### Restore
```bash
docker run --rm \
  -v open-source-project_ollama:/data \
  -v $(pwd):/backup alpine \
  tar xzf /backup/ollama.tar.gz -C /data
```

## 🔧 Configuration Files

```
docker-compose.yml                              # Main config
monitoring/prometheus.yml                       # Prometheus targets
monitoring/grafana/provisioning/datasources/    # Grafana datasource
monitoring/grafana/provisioning/dashboards/     # Dashboard config
```

## 📊 Prometheus Queries

### CPU Usage
```promql
100 - (avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)
```

### Memory Usage
```promql
(node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes) / node_memory_MemTotal_bytes * 100
```

### Disk Usage
```promql
(node_filesystem_size_bytes - node_filesystem_avail_bytes) / node_filesystem_size_bytes * 100
```

### Container CPU
```promql
rate(container_cpu_usage_seconds_total[5m]) * 100
```

### Container Memory
```promql
container_memory_usage_bytes / container_spec_memory_limit_bytes * 100
```

## 🎯 Common Tasks

### Add New Service
1. Edit `docker-compose.yml`
2. Add service configuration
3. Add to `app-network`
4. Run `docker-compose up -d`

### Change Port
1. Edit `docker-compose.yml`
2. Change port mapping: `<new-port>:<container-port>`
3. Run `docker-compose up -d`

### Update Service
```bash
docker-compose pull <service-name>
docker-compose up -d <service-name>
```

### View Service Logs
```bash
docker-compose logs -f --tail=100 <service-name>
```

## 🔐 Security Checklist

- [ ] Change Grafana default password
- [ ] Use environment variables for secrets
- [ ] Limit port exposure (127.0.0.1:port)
- [ ] Enable SSL/TLS for production
- [ ] Regular backups
- [ ] Update images regularly
- [ ] Monitor security advisories

## 📱 Mobile Access

### Setup Reverse Proxy (Nginx)
```nginx
server {
    listen 80;
    server_name your-domain.com;
    
    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

## 🎓 Learning Resources

### Docker
- https://docs.docker.com/
- https://docs.docker.com/compose/

### Monitoring
- https://prometheus.io/docs/
- https://grafana.com/docs/

### AI/LLM
- https://github.com/ollama/ollama
- https://github.com/open-webui/open-webui

## 💡 Pro Tips

1. **Use manage.sh**: Lebih mudah dari docker-compose
2. **Monitor resources**: Jalankan `./manage.sh stats` secara berkala
3. **Backup regularly**: Terutama Ollama models (besar!)
4. **Start small**: Mulai dengan model kecil (3B-7B)
5. **Check logs**: Jika ada masalah, cek logs dulu
6. **Update often**: `./manage.sh update` untuk latest features

## 🆘 Emergency Commands

```bash
# Everything broken? Nuclear option:
docker-compose down -v
docker system prune -a --volumes
docker-compose up -d

# Out of disk space?
docker system prune -a
docker volume prune

# Service not responding?
docker-compose restart <service-name>

# Need fresh start?
./manage.sh clean-all
./manage.sh start
```

## 📞 Get Help

1. Check [NOTES.md](NOTES.md) for troubleshooting
2. Check [README.md](README.md) for full docs
3. Check logs: `./manage.sh logs`
4. Create issue on GitHub

---

**Print this page for quick reference!**

Last updated: November 12, 2024
