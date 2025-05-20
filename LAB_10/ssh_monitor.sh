#!/bin/bash


# Generowanie pliku
REPORT_FILE="ssh_suspicious_report_$(date +%F).log"

# Znalezienie nieudanych logowan
journalctl -u ssh --since "$(date +%Y-%m-%d)" --until "$(date +%Y-%m-%d) 23:59:59" --no-pager | grep "Failed password" > "$REPORT_FILE"

# Wypisz nieudane logowania do pliku jesli istnieja
if [ -s "$REPORT_FILE" ]; then
    echo "Znaleziono podejrzane próby logowania. Raport zapisany w $REPORT_FILE"
else
    echo "Brak podejrzanych logowań."
    rm "$REPORT_FILE"
fi