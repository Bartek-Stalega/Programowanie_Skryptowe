#!/bin/bash

# Dane logowania
REMOTE_USER="kali"  # Tu wpisz username
REMOTE_HOST="localhost" #Tu wpisz adres serwera
REMOTE_PORT="22"

# Plik logu
OUTPUT_FILE="ssh_output_$(date +%F_%T).log"

# Polecenia do wykonania
COMMANDS=(
    "ls -la ~"
    "ps aux --sort=-%mem"
)

# Nagłówek
{
    echo "=== RAPORT ZDALNEGO SERWERA ==="
    echo "Data wykonania: $(date)"
    echo "Host: $REMOTE_HOST"
    echo "Użytkownik: $REMOTE_USER"
    echo "--------------------------------"
} > "$OUTPUT_FILE"

# Wykonywanie poleceń z nagłówkami
for CMD in "${COMMANDS[@]}"; do
{
    echo ""
    echo ">>> Polecenie: $CMD"
    echo "-----------------------------"
    # Zalogowanie sie na serwer przy pomocy stworzonych wczesniej kluczy ssh i wykonanie komend
    ssh -i ~/.ssh/id_rsa -p "$REMOTE_PORT" "$REMOTE_USER@$REMOTE_HOST" "$CMD"
    echo "-----------------------------"
} >> "$OUTPUT_FILE"
done

echo "Zapisano log do pliku: $OUTPUT_FILE"
