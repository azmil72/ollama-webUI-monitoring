# Catatan Penting

## Port yang Digunakan

- **3000**: Open WebUI
- **3001**: Grafana
- **8081**: cAdvisor (diubah dari 8080 karena konflik)
- **9090**: Prometheus
- **9100**: Node Exporter
- **11434**: Ollama

## Troubleshooting yang Sudah Diselesaikan

### 1. Port 11434 Already in Use

**Masalah**: Ollama service berjalan di host system dan menggunakan port 11434.

**Solusi**:
```bash
# Stop Ollama service di host
sudo systemctl stop ollama

# Disable agar tidak auto-start (opsional)
sudo systemctl disable ollama
```

### 2. Port 8080 Already in Use

**Masalah**: Port 8080 sudah digunakan oleh PHPMyAdmin atau service lain.

**Solusi**: Ubah port cAdvisor ke 8081 di `docker-compose.yml`:
```yaml
ports:
  - 8081:8080
```

### 3. Container Name Conflict

**Masalah**: Container dengan nama yang sama sudah ada.

**Solusi**:
```bash
# Hapus container lama
docker rm -f container-name

# Atau hapus semua
docker-compose down
```

## Tips Penggunaan

### Menghentikan Sementara

Jika ingin menghentikan semua services tanpa menghapus data:
```bash
docker-compose stop
```

Untuk menjalankan kembali:
```bash
docker-compose start
```

### Melihat Logs

```bash
# Semua services
docker-compose logs -f

# Service tertentu
docker-compose logs -f ollama
docker-compose logs -f grafana
```

### Mengecek Resource Usage

```bash
# Lihat penggunaan resource per container
docker stats

# Atau akses cAdvisor di browser
http://localhost:8081
```

### Download Model AI

```bash
# Masuk ke container Ollama
docker exec -it ollama bash

# Download model
ollama pull llama2
ollama pull mistral
ollama pull codellama

# List model yang sudah didownload
ollama list
```

## Konfigurasi Grafana Dashboard

### Dashboard yang Direkomendasikan

1. **Node Exporter Full** (ID: 1860)
   - Monitoring lengkap server: CPU, Memory, Disk, Network
   
2. **Docker Container & Host Metrics** (ID: 193)
   - Monitoring container Docker
   
3. **cAdvisor exporter** (ID: 14282)
   - Detail metrics per container

### Cara Import Dashboard

1. Login ke Grafana: http://localhost:3001
2. Username: `admin`, Password: `admin`
3. Klik icon "+" di sidebar → "Import"
4. Masukkan Dashboard ID (contoh: 1860)
5. Pilih "Prometheus" sebagai datasource
6. Klik "Import"

## Maintenance

### Update Images

```bash
# Pull image terbaru
docker-compose pull

# Restart dengan image baru
docker-compose up -d
```

### Backup Data

Volume yang perlu di-backup:
- `ollama`: Model AI yang sudah didownload
- `open-webui`: Data chat dan konfigurasi
- `prometheus-data`: Historical metrics
- `grafana-data`: Dashboard dan konfigurasi

```bash
# Backup volume
docker run --rm -v open-source-project_ollama:/data -v $(pwd):/backup alpine tar czf /backup/ollama-backup.tar.gz -C /data .
```

### Clean Up

```bash
# Hapus semua termasuk volumes (HATI-HATI!)
docker-compose down -v

# Hapus unused images
docker image prune -a

# Hapus semua unused resources
docker system prune -a --volumes
```

## Monitoring Best Practices

1. **Set Alert di Grafana** untuk:
   - CPU usage > 80%
   - Memory usage > 90%
   - Disk space < 10%
   - Container restart

2. **Retention Policy Prometheus**:
   - Default: 15 hari
   - Bisa diubah dengan flag `--storage.tsdb.retention.time=30d`

3. **Regular Backup**:
   - Backup Grafana dashboards
   - Backup Prometheus data jika perlu historical data
   - Backup Ollama models (ukuran besar)

## Keamanan

### Ubah Password Default

Edit `docker-compose.yml`:
```yaml
grafana:
  environment:
    - GF_SECURITY_ADMIN_PASSWORD=password_kuat_anda
```

### Batasi Akses Network

Jika tidak perlu akses dari luar:
```yaml
ports:
  - 127.0.0.1:3001:3000  # Hanya localhost
```

### Enable HTTPS (Production)

Gunakan reverse proxy seperti Nginx atau Traefik dengan SSL certificate.
