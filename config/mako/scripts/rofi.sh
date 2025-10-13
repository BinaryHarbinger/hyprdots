#!/bin/bash
# ~/.config/mako/scripts/rofi.sh
logfile="$HOME/.local/share/mako/notifications.log"
[ -f "$logfile" ] || touch "$logfile"

options="󰃢  Clear All\n󰔡  Toggle DND\n$(tac "$logfile" | head -n 50)"  # only last 50 notifications
chosen=$(echo -e "$options" | rofi -dmenu -i -p "  Notifications" -config ~/.config/rofi/notification.rasi )
[ -z "$chosen" ] && exit 0

if [ "$chosen" = "󰃢  Clear All" ]; then
    rm -rf $logfile
    bash ~/.config/mako/scripts/rofi.sh & disown
    exit 0
elif [ "$chosen" = "󰔡  Toggle DND" ]; then
    makoctl mode -t dnd
    bash ~/.config/mako/scripts/rofi.sh & disown
    exit 0
fi

# Actions
action=$(echo -e "󰌍\n  Resend\n  Delete\n  Copy" | rofi -dmenu -p "Action" -config ~/.config/rofi/sysmenu.rasi -theme-str 'entry {placeholder: "...";}')
line=$(echo "$chosen" | sed -E 's/^\[[0-9]{2}:[0-9]{2}\] //')
title=$(echo "$line" | cut -d'|' -f1 | xargs)           
body=$(echo "$line" | cut -d'|' -f2- | xargs)

case "$action" in
    "󰌍")
        bash ~/.config/mako/scripts/rofi.sh & disown
        ;;
    "  Resend")
        notify-send "$title" "$body"
        ;;
    "  Delete")
        grep -Fxv "$chosen" "$logfile" > "${logfile}.tmp" && mv "${logfile}.tmp" "$logfile"
        ;;
    "  Copy")
        echo "$title | $body" | wl-copy
        ;;
esac

