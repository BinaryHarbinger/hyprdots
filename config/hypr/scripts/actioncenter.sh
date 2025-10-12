#!/bin/bash
STATE_FILE="/tmp/actioncenter_state"

# Dosya yoksa oluştur ve default false
if [ ! -f "$STATE_FILE" ]; then
    echo "false" > "$STATE_FILE"
fi

# Mevcut durumu oku
current_value=$(cat "$STATE_FILE")

if [ "$current_value" = "true" ]; then
    new_value="false"
    echo "Closed"
else
    new_value="true"
    echo "Opened"
fi

ewwii open --toggle actioncenter

# Dosyayı güncelle ve stdout’a yaz
echo "$new_value" | tee "$STATE_FILE" > /dev/null

# Küçük gecikme
sleep 0.1
