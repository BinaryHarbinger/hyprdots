#!/bin/bash

logfile="$HOME/.local/share/mako/notifications.log"

case "$1" in
    --dnd-toggle|-d)
        # Sadece DND toggle
        makoctl mode -t dnd 
        exit 0
        ;;
    --status|-s)
        # Sadece Waybar JSON
        ;;
    "")
        # Parametre yoksa varsayılan Waybar JSON
        ;;
    *)
        echo "Unknown option: $1"
        exit 1
        ;;
esac

if makoctl mode | grep -q '^dnd$'; then
    dnd=1
else
    dnd=0
fi

# Notification count
count=$(wc -l < "$logfile")

if [[ $count -gt 0 ]]; then
    new=1
else
    new=0
fi

# JSON üret
if [[ $dnd -eq 1 && $new -eq 1 ]]; then
    echo "{\"text\": \"$count\", \"alt\": \"dnd-notification\", \"tooltip\": \"\", \"class\": \"dnd-notification\"}"
elif [[ $dnd -eq 1 && $new -eq 0 ]]; then
    echo "{\"text\": \"$count\", \"alt\": \"dnd-none\", \"tooltip\": \"\", \"class\": \"dnd-none\"}"
elif [[ $dnd -eq 0 && $new -eq 1 ]]; then
    echo "{\"text\": \"$count\", \"alt\": \"notification\", \"tooltip\": \"\", \"class\": \"notification\"}"
else
    echo "{\"text\": \"$count\", \"alt\": \"none\", \"tooltip\": \"\", \"class\": \"none\"}"
fi

