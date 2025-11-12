# Contributing Guide

Terima kasih atas minat Anda untuk berkontribusi! 🎉

## 🤝 Cara Berkontribusi

### 1. Fork Repository
```bash
# Fork via GitHub UI, kemudian clone
git clone https://github.com/your-username/Open-source-project.git
cd Open-source-project
```

### 2. Buat Branch Baru
```bash
git checkout -b feature/nama-fitur-anda
# atau
git checkout -b fix/nama-bug-yang-diperbaiki
```

### 3. Lakukan Perubahan
- Tulis code yang clean dan readable
- Follow existing code style
- Tambahkan comments jika perlu
- Update dokumentasi jika ada perubahan

### 4. Test Perubahan
```bash
# Test bahwa semua services masih berjalan
./manage.sh start
./manage.sh status

# Test script helper
./manage.sh help
```

### 5. Commit Changes
```bash
git add .
git commit -m "feat: deskripsi singkat perubahan"
```

**Commit Message Format:**
- `feat:` untuk fitur baru
- `fix:` untuk bug fixes
- `docs:` untuk perubahan dokumentasi
- `refactor:` untuk refactoring code
- `test:` untuk menambah tests
- `chore:` untuk maintenance tasks

### 6. Push ke GitHub
```bash
git push origin feature/nama-fitur-anda
```

### 7. Buat Pull Request
- Buka repository di GitHub
- Klik "New Pull Request"
- Pilih branch Anda
- Isi deskripsi lengkap tentang perubahan
- Submit PR

## 📝 Guidelines

### Code Style
- Gunakan 2 spaces untuk indentation di YAML
- Gunakan 4 spaces untuk indentation di Python/Bash
- Gunakan nama variable yang descriptive
- Tambahkan comments untuk logic yang complex

### Documentation
- Update README.md jika ada perubahan major
- Update CHANGELOG.md dengan perubahan Anda
- Tambahkan comments di code
- Update relevant documentation files

### Testing
- Test semua perubahan sebelum submit PR
- Pastikan semua services masih berjalan
- Test di environment yang clean (fresh install)

## 🎯 Area Kontribusi

### High Priority
- [ ] Alert rules untuk Grafana
- [ ] Custom Grafana dashboards
- [ ] Automated backup script
- [ ] SSL/TLS support
- [ ] Environment-based configuration

### Medium Priority
- [ ] Health check endpoints
- [ ] Log aggregation
- [ ] API gateway
- [ ] Multi-language documentation
- [ ] CI/CD pipeline

### Low Priority
- [ ] Additional AI models configuration
- [ ] Performance optimization
- [ ] UI improvements
- [ ] Additional monitoring metrics

## 🐛 Melaporkan Bug

### Sebelum Melaporkan
1. Cek apakah bug sudah dilaporkan di Issues
2. Cek dokumentasi troubleshooting di NOTES.md
3. Pastikan Anda menggunakan versi terbaru

### Cara Melaporkan
Buat issue baru dengan informasi:
- **Deskripsi bug**: Apa yang terjadi?
- **Expected behavior**: Apa yang seharusnya terjadi?
- **Steps to reproduce**: Langkah-langkah untuk reproduce bug
- **Environment**: OS, Docker version, dll
- **Logs**: Relevant logs dari `docker-compose logs`
- **Screenshots**: Jika applicable

**Template:**
```markdown
## Bug Description
[Deskripsi singkat bug]

## Expected Behavior
[Apa yang seharusnya terjadi]

## Actual Behavior
[Apa yang sebenarnya terjadi]

## Steps to Reproduce
1. [Langkah 1]
2. [Langkah 2]
3. [Langkah 3]

## Environment
- OS: [e.g., Ubuntu 22.04]
- Docker: [e.g., 24.0.0]
- Docker Compose: [e.g., 2.20.0]

## Logs
```
[Paste relevant logs here]
```

## Screenshots
[If applicable]
```

## 💡 Mengusulkan Fitur

### Sebelum Mengusulkan
1. Cek apakah fitur sudah diusulkan di Issues
2. Cek CHANGELOG.md untuk planned features
3. Diskusikan di Issues terlebih dahulu

### Cara Mengusulkan
Buat issue baru dengan label "enhancement":
- **Deskripsi fitur**: Apa fitur yang diusulkan?
- **Use case**: Kapan fitur ini berguna?
- **Benefit**: Apa keuntungannya?
- **Implementation idea**: Ide implementasi (opsional)

## 📚 Dokumentasi

### Jenis Dokumentasi
- **README.md**: Dokumentasi utama dan lengkap
- **QUICK_START.md**: Panduan cepat untuk pemula
- **ACCESS.md**: Reference untuk URLs dan access
- **NOTES.md**: Tips, tricks, dan troubleshooting
- **PROJECT_STRUCTURE.md**: Arsitektur dan struktur
- **INDEX.md**: Navigation dan overview

### Update Dokumentasi
Jika perubahan Anda mempengaruhi:
- Cara penggunaan → Update README.md dan QUICK_START.md
- URLs atau ports → Update ACCESS.md
- Troubleshooting → Update NOTES.md
- Struktur project → Update PROJECT_STRUCTURE.md

## 🔍 Review Process

### Apa yang Kami Cek
1. **Functionality**: Apakah perubahan bekerja dengan baik?
2. **Code quality**: Apakah code clean dan maintainable?
3. **Documentation**: Apakah dokumentasi sudah diupdate?
4. **Testing**: Apakah sudah ditest dengan baik?
5. **Breaking changes**: Apakah ada breaking changes?

### Timeline
- Initial review: 1-3 hari
- Feedback dan revisi: Tergantung kompleksitas
- Merge: Setelah approved

## 🎓 Resources

### Belajar Docker
- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)

### Belajar Monitoring
- [Prometheus Documentation](https://prometheus.io/docs/)
- [Grafana Documentation](https://grafana.com/docs/)

### Belajar AI/LLM
- [Ollama Documentation](https://github.com/ollama/ollama)
- [Open WebUI Documentation](https://github.com/open-webui/open-webui)

## 💬 Komunikasi

### Channels
- **GitHub Issues**: Bug reports dan feature requests
- **Pull Requests**: Code contributions
- **Discussions**: General questions dan diskusi

### Response Time
- Issues: 1-3 hari
- Pull Requests: 1-5 hari
- Urgent bugs: 1 hari

## 🙏 Terima Kasih

Setiap kontribusi, sekecil apapun, sangat dihargai! Baik itu:
- Code contributions
- Documentation improvements
- Bug reports
- Feature suggestions
- Spreading the word

**Contributors akan dicantumkan di CHANGELOG.md dan README.md**

---

**Happy Contributing! 🚀**

Jika ada pertanyaan, jangan ragu untuk bertanya di Issues atau Discussions.
