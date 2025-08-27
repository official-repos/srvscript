#!/bin/bash

# =============================
# UFW baseline & variabel sumber
# =============================
PROM_SERVER="10.1.8.2"     # IP server Prometheus yang melakukan scrape
WAZUH_MANAGER="10.1.8.4"   # IP Wazuh Manager (tujuan agent tersambung)

sudo ufw --force reset
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw logging on

# =============
# 1) SSH (22/tcp)
# =============
# Batasi percobaan brute-force (rate limit)
sudo ufw limit 22/tcp comment 'SSH (rate-limited)'

# Jika port SSH Anda custom (mis. 2222), gunakan:
# sudo ufw limit 2222/tcp comment 'SSH custom (rate-limited)'

# =========================
# 2) HTTP/HTTPS (80/443/tcp)
# =========================
sudo ufw allow 80/tcp  comment 'HTTP'
sudo ufw allow 443/tcp comment 'HTTPS'

# =========================================================
# 3) Prometheus exporter (contoh: node_exporter 9100/tcp)
#    Disarankan hanya boleh diakses dari server Prometheus
# =========================================================

# Jika juga menjalankan exporter lain di server ini (opsional):
# Blackbox Exporter (9115/tcp):
# sudo ufw allow from "$PROM_SERVER" to any port 9115 proto tcp comment 'blackbox_exporter from Prometheus'

# (Jika ingin membuka ke semua sumber—kurang aman):
sudo ufw allow 9100/tcp comment 'node_exporter (open)'

# =========================================================
# 4) Wazuh Agent
#    Agent -> Manager (keluar): 1514/udp (events), 1515/tcp (enrollment)
#    Secara default UFW mengizinkan OUTGOING, tapi berikut eksplisit:
# =========================================================
# sudo ufw allow out to "$WAZUH_MANAGER" port 1514 proto udp comment 'Wazuh agent events -> manager'
sudo ufw allow out to "$WAZUH_MANAGER" port 1514 proto tcp comment 'Wazuh agent events -> manager'
sudo ufw allow out to "$WAZUH_MANAGER" port 1515 proto tcp comment 'Wazuh agent enroll -> manager'

# Jika mesin INI adalah Wazuh Manager (bukan agent), buka inbound (opsional):
# sudo ufw allow 1514/udp comment 'Wazuh manager events'
# sudo ufw allow 1515/tcp comment 'Wazuh manager enrollment'
# (API Wazuh Manager, bila perlu)
# sudo ufw allow 55000/tcp comment 'Wazuh API'

# =================
# Aktifkan & cek
# =================
yes | sudo ufw enable
sudo ufw status numbered

