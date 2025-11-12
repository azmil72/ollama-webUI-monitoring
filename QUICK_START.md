# 🚀 Quick Start Guide

Panduan cepat untuk menjalankan project dalam 5 menit.

## Langkah 1: Jalankan Services

```bash
# Cara 1: Menggunakan script helper (recommended)
./manage.sh start

# Cara 2: Menggunakan docker-compose langsung
docker-compose up -d
```

## Langkah 2: Tunggu Semua Services Ready (~2 menit)

```bash
# Cek status dengan health check
./manage.sh status

# Atau menggunakan docker-compose
docker-compose ps
```

## Langkah 3: Download Model AI

```bash
# Cara 1: Menggunakan script helper (recommended)
./manage.sh download-model llama2

# Cara 2: Langsung ke container
docker exec -it ollama ollama pull llama2
```

## Langkah 4: Akses Aplikasi

1. **Open WebUI**: http://localhost:3000
   - Buat akun baru
   - Mulai chat dengan AI

2. **Grafana**: http://localhost:3001
   - Login: `admin` / `admin`
   - Import dashboard ID: `1860` (Node Exporter)
   - Import dashboard ID: `193` (Docker Metrics)

## Langkah 5: Monitoring

Buka Grafana dan lihat:
- CPU usage server
- Memory usage
- Docker container metrics
- Network traffic

## Selesai! 🎉

Sekarang Anda punya:
- ✅ AI chatbot lokal (Ollama + Open WebUI)
- ✅ Monitoring server lengkap (Prometheus + Grafana)
- ✅ Metrics container Docker (cAdvisor)

## Troubleshooting Cepat

**Services tidak start?**
```bash
docker-compose logs <service-name>
```

**Ingin restart?**
```bash
docker-compose restart
```

**Ingin stop semua?**
```bash
docker-compose down
```

Untuk dokumentasi lengkap, baca [README.md](README.md)
