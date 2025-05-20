#!/bin/bash

# Dane
LOG_FILE="/var/log/vsftpd.log"
DATE=$(date +%Y-%m-%d)
LOG_DATE=$(date -d "$DATE" "+%a %b %e")
REPORT_FILE="/var/log/ftp_report_${DATE}.txt"

# Sprawdzamy czy plik z logami istnieje
if [ ! -f "$LOG_FILE" ]; then
    echo "Błąd: plik logów $LOG_FILE nie istnieje."
    exit 1
fi

# Generujemy raport
{
    echo "Raport FTP dla daty: $DATE"
    echo "==========================="

#   Zalogowani użytkownicy
    echo -e "Zalogowani użytkownicy:"
    grep "$LOG_DATE" "$LOG_FILE" | grep "OK LOGIN" | awk '{print $8}' | sort | uniq

#   Nieudane logowania
    echo -e "Nieudane logowania:"
    grep "$LOG_DATE" "$LOG_FILE" | grep -i "FAIL LOGIN"

#   Pobrane pliki
    echo -e "Pobrane pliki:"
    grep "$LOG_DATE" "$LOG_FILE" | grep "OK DOWNLOAD" | awk -F '", "' '{print $2}' | cut -d'"' -f1

#   Wysłane pliki
    echo -e "Wysłane pliki:"
    grep "$LOG_DATE" "$LOG_FILE" | grep "OK UPLOAD" | awk -F '", "' '{print $2}' | cut -d'"' -f1

} > "$REPORT_FILE"

echo "Raport zapisano do: $REPORT_FILE"
