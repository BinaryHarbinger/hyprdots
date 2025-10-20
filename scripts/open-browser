#!/bin/bash

# Varsayılan tarayıcı .desktop dosyasını al
DESKTOP_FILE=$(xdg-settings get default-web-browser)

# .desktop dosyasının tam yolu
DESKTOP_PATH=$(find /usr/share/applications ~/.local/share/applications -name "$DESKTOP_FILE" 2>/dev/null | head -n 1)

if [ -z "$DESKTOP_PATH" ]; then
    echo "Varsayılan tarayıcı bulunamadı."
    exit 1
fi

# Exec satırını çek, % ile başlayan parametreleri çıkar
BROWSER_CMD=$(grep '^Exec=' "$DESKTOP_PATH" | head -n1 | cut -d= -f2 | sed 's/ %.*//')

# Tarayıcı komutunu boş aç
$BROWSER_CMD &

exit 0

