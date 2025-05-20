#!/bin/bash

# Konfiguracja
SRC_DIR="/home/kali/Documents"
BACKUP_NAME="backup_$(date +%F_%H-%M-%S).tar.gz"
FTP_HOST="127.0.0.1"
FTP_USER="ftpuser"
FTP_PASS="ftppassword"
FTP_DIR="/backups"

# Tworzenie archiwum
tar -czf "$BACKUP_NAME" -C "$SRC_DIR" .

# Wysyłanie na FTP
ftp -inv "$FTP_HOST" <<EOF
user $FTP_USER $FTP_PASS
mkdir $FTP_DIR
cd $FTP_DIR
put $BACKUP_NAME
bye
EOF

# Usuwamy backup z dysku
rm -f "$BACKUP_NAME"

echo "Kopia zapasowa została wysłana jako $BACKUP_NAME"