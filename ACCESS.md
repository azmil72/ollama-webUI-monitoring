# 🚀 Akses Cepat ke Semua Services

## 🌐 Web Interfaces

### 1. Open WebUI - AI Chat Interface
**URL**: http://localhost:3000

Gunakan untuk:
- Chat dengan AI models (Llama, Mistral, dll)
- Interface yang user-friendly
- Pertama kali: Buat akun baru

---

### 2. Grafana - Monitoring Dashboard
**URL**: http://localhost:3001

**Login**:
- Username: `admin`
- Password: `admin`

Gunakan untuk:
- Visualisasi metrics server dan container
- Membuat custom dashboard
- Setup alerts

**Dashboard yang Direkomendasikan**:
- Import ID `1860` - Node Exporter Full
- Import ID `193` - Docker Container Metrics
- Import ID `14282` - cAdvisor Metrics

---

### 3. Prometheus - Metrics Database
**URL**: http://localhost:9090

Gunakan untuk:
- Query metrics langsung
- Cek status targets: http://localhost:9090/targets
- Explore data mentah

---

### 4. cAdvisor - Container Monitoring
**URL**: http://localhost:8081

Gunakan untuk:
- Monitoring real-time container resources
- Lihat CPU, Memory, Network per container
- Historical data container

---

### 5. Node Exporter - Server Metrics
**URL**: http://localhost:9100/metrics

Gunakan untuk:
- Lihat raw metrics server
- CPU, Memory, Disk, Network stats
- Biasanya diakses via Prometheus/Grafana

---

## 📊 Quick Monitoring Checks

### Cek Status Semua Services
```bash
docker-compose ps
```

### Cek Resource Usage
```bash
docker stats
```

### Cek Logs
```bash
# Semua services
docker-compose logs -f

# Service tertentu
docker-compose logs -f ollama
docker-compose logs -f grafana
```

---

## 🤖 Menggunakan Ollama

### Download Model AI
```bash
# Llama 2 (7B)
docker exec -it ollama ollama pull llama2

# Mistral (7B)
docker exec -it ollama ollama pull mistral

# Code Llama (7B)
docker exec -it ollama ollama pull codellama

# Llama 3.2 (3B) - Lebih ringan
docker exec -it ollama ollama pull llama3.2
```

### List Model yang Sudah Didownload
```bash
docker exec -it ollama ollama list
```

### Test Ollama via CLI
```bash
docker exec -it ollama ollama run llama2 "Hello, how are you?"
```

---

## 📈 Grafana Quick Setup

### Step 1: Login
1. Buka http://localhost:3001
2. Login dengan `admin` / `admin`
3. (Opsional) Ubah password

### Step 2: Import Dashboard
1. Klik icon "+" di sidebar
2. Pilih "Import"
3. Masukkan ID: `1860`
4. Pilih datasource: "Prometheus"
5. Klik "Import"

### Step 3: Lihat Metrics
- CPU Usage
- Memory Usage
- Disk I/O
- Network Traffic
- Container Stats

---

## 🔧 Management Commands

### Start Services
```bash
docker-compose up -d
```

### Stop Services
```bash
docker-compose stop
```

### Restart Services
```bash
docker-compose restart
```

### Stop & Remove Everything
```bash
docker-compose down
```

### Stop & Remove Including Data
```bash
docker-compose down -v
```

### Update All Images
```bash
docker-compose pull
docker-compose up -d
```

---

## 🎯 Recommended Workflow

1. **Start**: `docker-compose up -d`
2. **Download AI Model**: `docker exec -it ollama ollama pull llama2`
3. **Setup Grafana**: Import dashboard ID 1860
4. **Use Open WebUI**: http://localhost:3000
5. **Monitor**: http://localhost:3001

---

## ⚠️ Troubleshooting

### Service tidak bisa start?
```bash
docker-compose logs <service-name>
```

### Port sudah digunakan?
```bash
# Cek port yang digunakan
ss -tlnp | grep <port-number>

# Stop service yang menggunakan port
sudo systemctl stop <service-name>
```

### Ollama service di host conflict?
```bash
sudo systemctl stop ollama
sudo systemctl disable ollama
```

### Reset semua?
```bash
docker-compose down -v
docker-compose up -d
```

---

**Selamat Menggunakan! 🎉**

Untuk dokumentasi lengkap, lihat [README.md](README.md)
