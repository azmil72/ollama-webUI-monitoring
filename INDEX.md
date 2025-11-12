# 📚 Dokumentasi Index

Selamat datang di project monitoring stack dengan Ollama & Open WebUI!

## 🚀 Mulai Cepat

**Baru pertama kali?** Mulai dari sini:
1. [QUICK_START.md](QUICK_START.md) - Panduan 5 menit untuk memulai
2. [ACCESS.md](ACCESS.md) - Daftar URL dan cara akses semua services

## 📖 Dokumentasi Lengkap

### Untuk Pemula
- **[QUICK_START.md](QUICK_START.md)** - Panduan cepat memulai
- **[ACCESS.md](ACCESS.md)** - URL dan credentials semua services
- **[manage.sh](manage.sh)** - Script helper untuk management

### Untuk Developer
- **[README.md](README.md)** - Dokumentasi lengkap project
- **[PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)** - Struktur dan arsitektur
- **[NOTES.md](NOTES.md)** - Tips, troubleshooting, dan best practices

### Referensi
- **[CHANGELOG.md](CHANGELOG.md)** - History perubahan project
- **[LICENSE](LICENSE)** - Informasi lisensi

## 🎯 Quick Reference

### Services & Ports
| Service | Port | URL | Credentials |
|---------|------|-----|-------------|
| Open WebUI | 3000 | http://localhost:3000 | Buat akun baru |
| Grafana | 3001 | http://localhost:3001 | admin/admin |
| Prometheus | 9090 | http://localhost:9090 | - |
| cAdvisor | 8081 | http://localhost:8081 | - |
| Node Exporter | 9100 | http://localhost:9100/metrics | - |
| Ollama | 11434 | http://localhost:11434 | - |

### Common Commands

```bash
# Start everything
./manage.sh start

# Check status
./manage.sh status

# Download AI model
./manage.sh download-model llama2

# View logs
./manage.sh logs

# Stop everything
./manage.sh stop
```

## 🏗️ Arsitektur

```
┌─────────────────────────────────────────┐
│         AI Services                     │
│  ┌──────────┐      ┌──────────┐        │
│  │  Ollama  │◄─────┤Open WebUI│        │
│  └──────────┘      └──────────┘        │
└─────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────┐
│      Monitoring Stack                   │
│  ┌──────────────────────────┐          │
│  │      Prometheus          │          │
│  │  (Metrics Collection)    │          │
│  └──────────────────────────┘          │
│         ▲         ▲                     │
│         │         │                     │
│  ┌──────┴───┐ ┌──┴────────┐           │
│  │  Node    │ │ cAdvisor  │           │
│  │ Exporter │ │(Container)│           │
│  │ (Server) │ │  Metrics  │           │
│  └──────────┘ └───────────┘           │
│         │                               │
│         ▼                               │
│  ┌──────────────────────────┐          │
│  │       Grafana            │          │
│  │   (Visualization)        │          │
│  └──────────────────────────┘          │
└─────────────────────────────────────────┘
```

## 📊 Apa yang Bisa Dipantau?

### Server Metrics (Node Exporter)
- ✅ CPU usage per core
- ✅ Memory usage (RAM)
- ✅ Disk I/O dan space
- ✅ Network traffic
- ✅ System load

### Container Metrics (cAdvisor)
- ✅ CPU usage per container
- ✅ Memory usage per container
- ✅ Network I/O per container
- ✅ Disk I/O per container
- ✅ Container health status

### Application Metrics
- ✅ Service availability
- ✅ Response time
- ✅ Request count

## 🎓 Learning Path

### Level 1: Basic Usage
1. Start services dengan `./manage.sh start`
2. Download model AI
3. Chat dengan AI di Open WebUI
4. Lihat monitoring di Grafana

### Level 2: Monitoring
1. Import Grafana dashboards
2. Understand metrics yang dikumpulkan
3. Setup custom dashboards
4. Monitor resource usage

### Level 3: Advanced
1. Setup alerting di Grafana
2. Custom Prometheus queries
3. Backup dan restore data
4. Performance tuning
5. Production deployment

## 🔧 Troubleshooting

**Services tidak start?**
→ Lihat [NOTES.md](NOTES.md) bagian Troubleshooting

**Port conflict?**
→ Cek [NOTES.md](NOTES.md) untuk solusi port conflicts

**Butuh help?**
→ Jalankan `./manage.sh help`

## 📦 Komponen Project

### AI Stack
- **Ollama**: Platform untuk menjalankan LLM lokal
- **Open WebUI**: Interface web untuk chat dengan AI

### Monitoring Stack
- **Prometheus**: Time-series database untuk metrics
- **Grafana**: Dashboard dan visualization
- **Node Exporter**: Metrics dari server (CPU, RAM, Disk, Network)
- **cAdvisor**: Metrics dari Docker containers

## 🎯 Use Cases

### Development
- Test AI models lokal
- Monitor resource usage saat development
- Debug performance issues

### Production
- Deploy AI services dengan monitoring
- Track resource usage over time
- Setup alerts untuk issues
- Capacity planning

### Learning
- Belajar Docker Compose
- Belajar monitoring dengan Prometheus/Grafana
- Belajar AI/LLM deployment
- Belajar DevOps practices

## 📝 File Structure

```
.
├── docker-compose.yml          # Main configuration
├── manage.sh                   # Helper script
├── monitoring/                 # Monitoring configs
│   ├── prometheus.yml
│   └── grafana/
├── README.md                   # Full documentation
├── QUICK_START.md             # Quick start guide
├── ACCESS.md                  # URLs and access info
├── NOTES.md                   # Tips and troubleshooting
├── PROJECT_STRUCTURE.md       # Architecture details
├── CHANGELOG.md               # Version history
├── LICENSE                    # License information
└── INDEX.md                   # This file
```

## 🤝 Contributing

Ingin berkontribusi? Lihat [CHANGELOG.md](CHANGELOG.md) untuk planned features.

## 📄 License

MIT License - Lihat [LICENSE](LICENSE) untuk detail.

---

**Happy Monitoring! 🎉**

Untuk pertanyaan atau issues, buat issue di repository atau cek dokumentasi lengkap di [README.md](README.md).
