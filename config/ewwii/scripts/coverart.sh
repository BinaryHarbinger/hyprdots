#!/bin/sh

CONFIG_DIR="$HOME/.config/eww"
COVER_ART_FILE="$CONFIG_DIR/coverart.png"
INFO_FILE="$CONFIG_DIR/info.txt"

status=$(playerctl status 2>/dev/null)

if [ "$status" = "Playing" ] || [ "$status" = "Paused" ]; then
    :
else
    exit 1
fi

current_title=$(playerctl metadata --format "{{ title }}" 2>/dev/null)
url=$(playerctl metadata --format "{{ mpris:artUrl }}" 2>/dev/null | sed 's/b273/1e02/')

if [ -z "$current_title" ] || [ -z "$url" ]; then
    echo "$url"
    exit 0
fi

case "$url" in
    https://*) ;; 
    *)
        echo "$url"
        exit 0
        ;;
esac

if [ -f "$INFO_FILE" ]; then
    last_title=$(cat "$INFO_FILE")
else
    last_title=""
fi

if [ "$current_title" != "$last_title" ]; then
    echo "$current_title" > "$INFO_FILE"
    wget -q -O "$COVER_ART_FILE" "$url"
    echo "file://$COVER_ART_FILE"
else
    echo "file://$COVER_ART_FILE"
fi

