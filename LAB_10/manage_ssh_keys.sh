#!/bin/bash

ACTION=$1
USER=$2
KEY_FILE=$3
SERVERS="localhost"

if [[ "$ACTION" != "add" && "$ACTION" != "remove" ]]; then
  echo "Użycie: $0 [add|remove] [user] [key_file]"
  exit 1
fi

for SERVER in "${SERVERS[@]}"; do
  echo "Przetwarzanie $SERVER..."
  if [[ "$ACTION" == "add" ]]; then
    ssh "$USER@$SERVER" "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys" < "$KEY_FILE"
  elif [[ "$ACTION" == "remove" ]]; then
    KEY_CONTENT=$(cat "$KEY_FILE")
    ssh "$USER@$SERVER" "sed -i '\|$KEY_CONTENT|d' ~/.ssh/authorized_keys"
  fi
done