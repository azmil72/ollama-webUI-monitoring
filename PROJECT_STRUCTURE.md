# 📁 Struktur Project

```
Open-source-project/
│
├── docker-compose.yml              # Konfigurasi utama semua services
│
├── monitoring/                     # Folder konfigurasi monitoring
│   ├── prometheus.yml              # Konfigurasi Prometheus scrape targets
│   └── grafana/
│       └── provisioning/           # Auto-provisioning Grafana
│           ├── datasources/
│           │   └── datasource.yml  # Konfigurasi Prometheus datasource
│           └── dashboards/
│               └── dashboard.yml   # Konfigurasi dashboard provider
│
├── README.md                       # Dokumentasi lengkap project
├── QUICK_START.md                  # Panduan cepat memulai (5 menit)
├── ACCESS.md                       # Daftar URL dan cara akses semua services
├── NOTES.md                        # Catatan troubleshooting dan tips
├── PROJECT_STRUCTURE.md            # File ini - struktur project
└── .gitignore                      # File yang diabaikan Git

# Docker Volumes (dibuat otomatis)
├── ollama/                         # Model AI yang didownload
├── open-webui/                     # Data chat dan konfigurasi
├── prometheus-data/                # Time-series metrics database
└── grafana-data/                   # Dashboard dan konfigurasi Grafana
```

## 📄 Deskripsi File

### File Utama

#### `docker-compose.yml`
File konfigurasi Docker Compose yang mendefinisikan 6 services:
1. **ollama** - AI model server
2. **open-webui** - Web interface untuk AI
3. **prometheus** - Metrics collection
4. **grafana** - Visualization dashboard
5. **node-exporter** - Server metrics exporter
6. **cadvisor** - Container metrics exporter

#### `README.md`
Dokumentasi lengkap meliputi:
- Gambaran umum project
- Komponen dan arsitektur
- Instalasi dan konfigurasi
- Troubleshooting
- Referensi

#### `QUICK_START.md`
Panduan singkat untuk:
- Menjalankan project dalam 5 menit
- Download model AI
- Akses aplikasi
- Setup monitoring

#### `ACCESS.md`
Daftar lengkap:
- URL semua services
- Credentials login
- Command-line tools
- Quick reference

#### `NOTES.md`
Catatan penting:
- Port yang digunakan
- Troubleshooting yang sudah diselesaikan
- Tips penggunaan
- Maintenance guide

### Folder Monitoring

#### `monitoring/prometheus.yml`
Konfigurasi Prometheus untuk scraping metrics dari:
- Prometheus itself
- Node Exporter (server metrics)
- cAdvisor (container metrics)
- Ollama service
- Open WebUI service

#### `monitoring/grafana/provisioning/`
Auto-provisioning Grafana saat startup:
- **datasources/datasource.yml**: Otomatis menambahkan Prometheus sebagai datasource
- **dashboards/dashboard.yml**: Konfigurasi dashboard provider

## 🔧 Services dan Port

| Service | Internal Port | External Port | Volume |
|---------|---------------|---------------|--------|
| Ollama | 11434 | 11434 | ollama |
| Open WebUI | 8080 | 3000 | open-webui |
| Prometheus | 9090 | 9090 | prometheus-data |
| Grafana | 3000 | 3001 | grafana-data |
| Node Exporter | 9100 | 9100 | - |
| cAdvisor | 8080 | 8081 | - |

## 🌐 Network

Semua services terhubung dalam satu Docker network: `app-network`

Ini memungkinkan:
- Inter-service communication menggunakan service name
- Isolasi dari network lain
- Service discovery otomatis

## 💾 Data Persistence

### Volumes yang Persistent

1. **ollama**
   - Lokasi: Docker volume
   - Isi: Model AI yang didownload (bisa 2-10GB per model)
   - Backup: Penting jika tidak ingin download ulang

2. **open-webui**
   - Lokasi: Docker volume
   - Isi: Chat history, user data, konfigurasi
   - Backup: Penting untuk data user

3. **prometheus-data**
   - Lokasi: Docker volume
   - Isi: Time-series metrics database
   - Backup: Opsional (data historical)

4. **grafana-data**
   - Lokasi: Docker volume
   - Isi: Dashboard, alerts, konfigurasi
   - Backup: Penting jika sudah custom dashboard

### Cara Backup Volume

```bash
# Backup ollama models
docker run --rm -v open-source-project_ollama:/data \
  -v $(pwd):/backup alpine \
  tar czf /backup/ollama-backup.tar.gz -C /data .

# Backup grafana data
docker run --rm -v open-source-project_grafana-data:/data \
  -v $(pwd):/backup alpine \
  tar czf /backup/grafana-backup.tar.gz -C /data .
```

### Cara Restore Volume

```bash
# Restore ollama models
docker run --rm -v open-source-project_ollama:/data \
  -v $(pwd):/backup alpine \
  tar xzf /backup/ollama-backup.tar.gz -C /data

# Restore grafana data
docker run --rm -v open-source-project_grafana-data:/data \
  -v $(pwd):/backup alpine \
  tar xzf /backup/grafana-backup.tar.gz -C /data
```

## 🔄 Workflow Development

### 1. Initial Setup
```bash
git clone <repository>
cd Open-source-project
docker-compose up -d
```

### 2. Download AI Models
```bash
docker exec -it ollama ollama pull llama2
```

### 3. Configure Monitoring
- Login ke Grafana
- Import dashboard
- Setup alerts (opsional)

### 4. Daily Usage
- Akses Open WebUI untuk chat
- Monitor via Grafana
- Check logs jika ada issue

### 5. Maintenance
```bash
# Update images
docker-compose pull
docker-compose up -d

# Backup data
./backup.sh  # (buat script sendiri)

# Clean up
docker system prune
```

## 📊 Monitoring Flow

```
Server Hardware
    ↓
Node Exporter (collect server metrics)
    ↓
Prometheus (store metrics)
    ↓
Grafana (visualize)
    ↓
User Dashboard

Docker Containers
    ↓
cAdvisor (collect container metrics)
    ↓
Prometheus (store metrics)
    ↓
Grafana (visualize)
    ↓
User Dashboard
```

## 🚀 Deployment Considerations

### Development
- Gunakan konfigurasi default
- Port exposed ke localhost
- No SSL/TLS

### Production
- Ubah password default
- Setup reverse proxy (Nginx/Traefik)
- Enable SSL/TLS
- Batasi port exposure
- Setup backup otomatis
- Configure retention policy
- Setup alerting

### Resource Requirements

**Minimum**:
- CPU: 4 cores
- RAM: 8GB
- Disk: 50GB

**Recommended**:
- CPU: 8 cores
- RAM: 16GB
- Disk: 100GB SSD

## 📚 Referensi Cepat

- **Start**: `docker-compose up -d`
- **Stop**: `docker-compose stop`
- **Logs**: `docker-compose logs -f`
- **Status**: `docker-compose ps`
- **Clean**: `docker-compose down -v`

---

**Last Updated**: November 2024
