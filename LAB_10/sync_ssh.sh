#!/bin/bash

# Dane
SRC_DIR="/home/kali/Documents"  #Tu wpisz folder ktory chcesz zsynchronizowac
DEST_USER="kali"    #tu wpisz nazwe uzytkownika z ktorym chcesz sie polaczyc
DEST_HOST="localhost"   #Tu wpisz adres serwera ssh
DEST_DIR="/home/kali/ssh_backup"    #Tu wpisz lokalizacje folderu na serwerze

# 
rsync -avz -e ssh "$SRC_DIR" "$DEST_USER@$DEST_HOST:$DEST_DIR"