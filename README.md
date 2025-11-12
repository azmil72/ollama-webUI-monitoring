# Project Monitoring Stack dengan Ollama & Open WebUI

Dokumentasi lengkap untuk project yang menggabungkan beberapa tools open source untuk AI dan monitoring infrastruktur.

> � **aBaru pertama kali?** Mulai dengan [QUICK_START.md](QUICK_START.md) atau [INDEX.md](INDEX.md)

## 📚 Dokumentasi

- **[INDEX.md](INDEX.md)** - Overview dan navigasi dokumentasi
- **[QUICK_START.md](QUICK_START.md)** - Panduan cepat 5 menit
- **[ACCESS.md](ACCESS.md)** - Daftar URL dan credentials
- **[NOTES.md](NOTES.md)** - Tips dan troubleshooting
- **[PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)** - Arsitektur detail
- **[CHANGELOG.md](CHANGELOG.md)** - History perubahan

## 📋 Daftar Isi

- [Gambaran Umum](#gambaran-umum)
- [Komponen Project](#komponen-project)
- [Arsitektur](#arsitektur)
- [Prasyarat](#prasyarat)
- [Instalasi & Menjalankan](#instalasi--menjalankan)
- [Akses Aplikasi](#akses-aplikasi)
- [Monitoring & Metrics](#monitoring--metrics)
- [Konfigurasi](#konfigurasi)
- [Troubleshooting](#troubleshooting)

## 🎯 Gambaran Umum

Project ini menggabungkan beberapa tools open source untuk membuat environment AI yang lengkap dengan monitoring infrastruktur:

- **Ollama**: Platform untuk menjalankan Large Language Models (LLM) secara lokal
- **Open WebUI**: Interface web untuk berinteraksi dengan Ollama
- **Prometheus**: System monitoring dan alerting
- **Grafana**: Platform visualisasi dan analytics
- **Node Exporter**: Exporter untuk metrics hardware dan OS
- **cAdvisor**: Monitoring untuk container Docker

## 🧩 Komponen Project

### 1. Ollama
- **Image**: `ollama/ollama:latest`
- **Port**: 11434
- **Fungsi**: Menjalankan model AI seperti Llama, Mistral, dll secara lokal
- **Volume**: Menyimpan model yang didownload

### 2. Open WebUI
- **Image**: `ghcr.io/open-webui/open-webui:main`
- **Port**: 3000
- **Fungsi**: Interface web untuk chat dengan AI models
- **Dependencies**: Ollama

### 3. Prometheus
- **Image**: `prom/prometheus:latest`
- **Port**: 9090
- **Fungsi**: Mengumpulkan dan menyimpan metrics dari semua services
- **Konfigurasi**: `monitoring/prometheus.yml`

### 4. Grafana
- **Image**: `grafana/grafana:latest`
- **Port**: 3001
- **Fungsi**: Visualisasi metrics dalam bentuk dashboard
- **Default Login**: admin/admin

### 5. Node Exporter
- **Image**: `prom/node-exporter:latest`
- **Port**: 9100
- **Fungsi**: Mengumpulkan metrics server (CPU, RAM, Disk, Network)

### 6. cAdvisor
- **Image**: `gcr.io/cadvisor/cadvisor:latest`
- **Port**: 8081
- **Fungsi**: Monitoring resource usage container Docker

## 🏗️ Arsitektur

```
┌─────────────────────────────────────────────────────────────┐
│                        Host Server                          │
│                                                             │
│  ┌──────────────┐         ┌──────────────┐                │
│  │   Ollama     │◄────────┤  Open WebUI  │                │
│  │   :11434     │         │    :3000     │                │
│  └──────────────┘         └──────────────┘                │
│         │                        │                          │
│         │                        │                          │
│         ▼                        ▼                          │
│  ┌─────────────────────────────────────────┐              │
│  │           Prometheus :9090              │              │
│  │     (Metrics Collection & Storage)      │              │
│  └─────────────────────────────────────────┘              │
│         ▲          ▲           ▲                           │
│         │          │           │                           │
│  ┌──────┴───┐  ┌──┴────┐  ┌───┴──────┐                   │
│  │  Node    │  │cAdvisor│  │ Services │                   │
│  �� Exporter │  │ :8080  │  │ Metrics  │                   │
│  │  :9100   │  └────────┘  └──────────┘                   │
│  └──────────┘                                              │
│         │                                                   │
│         ▼                                                   │
│  ┌─────────────────────────────────────────┐              │
│  │           Grafana :3001                 │              │
│  │      (Metrics Visualization)            │              │
│  └─────────────────────────────────────────┘              │
└─────────────────────────────────────────────────────────────┘
```

## 📦 Prasyarat

- Docker Engine 20.10+
- Docker Compose 2.0+
- Minimal 8GB RAM (16GB recommended untuk model AI besar)
- 20GB disk space kosong

## 🚀 Instalasi & Menjalankan

### 1. Clone atau Download Project

```bash
git clone <repository-url>
cd <project-directory>
```

### 2. Jalankan Semua Services

```bash
docker-compose up -d
```

### 3. Verifikasi Services Berjalan

```bash
docker-compose ps
```

Semua services harus dalam status "Up".

### 4. Download Model AI (Opsional)

```bash
# Masuk ke container Ollama
docker exec -it ollama ollama pull llama2

# Atau model lain seperti:
# docker exec -it ollama ollama pull mistral
# docker exec -it ollama ollama pull codellama
```

## 🌐 Akses Aplikasi

| Service | URL | Credentials |
|---------|-----|-------------|
| Open WebUI | http://localhost:3000 | Buat akun saat pertama kali |
| Grafana | http://localhost:3001 | admin / admin |
| Prometheus | http://localhost:9090 | - |
| cAdvisor | http://localhost:8081 | - |
| Node Exporter | http://localhost:9100/metrics | - |

## 📊 Monitoring & Metrics

### Metrics yang Dikumpulkan

#### 1. Server Metrics (Node Exporter)
- CPU usage per core
- Memory usage (total, used, available)
- Disk I/O dan space usage
- Network traffic (bytes in/out)
- System load average
- Uptime

#### 2. Container Metrics (cAdvisor)
- CPU usage per container
- Memory usage per container
- Network I/O per container
- Disk I/O per container
- Container restart count

#### 3. Application Metrics
- Ollama API response time
- Open WebUI request count
- Service availability

### Setup Dashboard Grafana

1. Login ke Grafana (http://localhost:3001)
2. Credentials: `admin` / `admin`
3. Import dashboard yang sudah tersedia:
   - **Node Exporter Full**: Dashboard ID `1860`
   - **Docker Container & Host Metrics**: Dashboard ID `193`
   - **cAdvisor**: Dashboard ID `14282`

#### Cara Import Dashboard:

1. Klik icon "+" di sidebar → "Import"
2. Masukkan Dashboard ID
3. Pilih Prometheus sebagai datasource
4. Klik "Import"

### Membuat Alert (Opsional)

Grafana dapat dikonfigurasi untuk mengirim alert jika:
- CPU usage > 80%
- Memory usage > 90%
- Disk space < 10%
- Container down/restart

## ⚙️ Konfigurasi

### Mengubah Port

Edit file `docker-compose.yml`:

```yaml
ports:
  - "<port-baru>:<port-container>"
```

### Mengubah Password Grafana

Edit environment variable di `docker-compose.yml`:

```yaml
environment:
  - GF_SECURITY_ADMIN_PASSWORD=password_baru
```

### Menambah Scrape Target di Prometheus

Edit file `monitoring/prometheus.yml`:

```yaml
scrape_configs:
  - job_name: 'service-baru'
    static_configs:
      - targets: ['service-name:port']
```

Reload Prometheus:

```bash
docker-compose restart prometheus
```

## 🔧 Troubleshooting

### Container Tidak Bisa Start

```bash
# Cek logs
docker-compose logs <service-name>

# Contoh:
docker-compose logs ollama
docker-compose logs grafana
```

### Prometheus Tidak Bisa Scrape Metrics

1. Cek konfigurasi di `monitoring/prometheus.yml`
2. Pastikan semua services dalam network yang sama
3. Cek status targets di http://localhost:9090/targets

### Grafana Tidak Bisa Connect ke Prometheus

1. Pastikan Prometheus running: `docker-compose ps prometheus`
2. Cek datasource configuration di Grafana
3. URL harus: `http://prometheus:9090`

### cAdvisor Error di Linux

Jika ada error terkait `/cgroup`, edit `docker-compose.yml`:

```yaml
volumes:
  - /:/rootfs:ro
  - /var/run:/var/run:ro
  - /sys:/sys:ro
  - /var/lib/docker:/var/lib/docker:ro
  # Hapus atau comment line ini jika error:
  # - /cgroup:/cgroup:ro
```

### Ollama Kehabisan Memory

Tambahkan memory limit di `docker-compose.yml`:

```yaml
ollama:
  deploy:
    resources:
      limits:
        memory: 8G
```

## 📝 Perintah Berguna

### Menggunakan Script Helper (Recommended)

```bash
# Lihat semua perintah
./manage.sh help

# Start semua services
./manage.sh start

# Stop semua services
./manage.sh stop

# Cek status dan health
./manage.sh status

# Lihat logs
./manage.sh logs
./manage.sh logs ollama

# Download model AI
./manage.sh download-model llama2

# List model yang terinstall
./manage.sh list-models

# Lihat resource usage
./manage.sh stats

# Backup data
./manage.sh backup

# Update semua services
./manage.sh update
```

### Menggunakan Docker Compose Langsung

```bash
# Start semua services
docker-compose up -d

# Stop semua services
docker-compose down

# Restart service tertentu
docker-compose restart <service-name>

# Lihat logs
docker-compose logs -f <service-name>

# Lihat resource usage
docker stats

# Hapus semua data (HATI-HATI!)
docker-compose down -v
```

## 🔄 Update Services

```bash
# Pull image terbaru
docker-compose pull

# Restart dengan image baru
docker-compose up -d
```

## 📚 Referensi

- [Ollama Documentation](https://github.com/ollama/ollama)
- [Open WebUI Documentation](https://github.com/open-webui/open-webui)
- [Prometheus Documentation](https://prometheus.io/docs/)
- [Grafana Documentation](https://grafana.com/docs/)
- [Node Exporter](https://github.com/prometheus/node_exporter)
- [cAdvisor](https://github.com/google/cadvisor)

## 📄 Lisensi

Project ini menggunakan berbagai tools open source dengan lisensi masing-masing. Silakan cek lisensi individual untuk setiap komponen.

## 🤝 Kontribusi

Kontribusi sangat diterima! Lihat [CONTRIBUTING.md](CONTRIBUTING.md) untuk panduan lengkap.

Cara cepat:
1. Fork repository
2. Buat branch baru (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'feat: Add some AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Buat Pull Request

---

**Dibuat dengan ❤️ menggunakan Docker & Open Source Tools**
