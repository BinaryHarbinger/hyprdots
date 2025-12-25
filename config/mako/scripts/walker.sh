#!/bin/bash
# ~/.config/mako/scripts/walker.sh

get_notification_num() {
    local target="$1"
    
    echo $target
    makoctl history \
        | grep "$target" \
        | sed -n 's/^Notification \([0-9]\+\):.*/\1/p'
}

logfile="$HOME/.local/share/mako/notifications.log"
[ -f "$logfile" ] || touch "$logfile"

options="󰃢  Clear All\n󰔡  Toggle DND\n$(tac "$logfile" | head -n 50)"  # only last 50 notifications
chosen=$(echo -e "$options" | walker -d -p "  Notifications")
[ -z "$chosen" ] && exit 0

if [ "$chosen" = "󰃢  Clear All" ]; then
    rm -rf $logfile
    bash ~/.config/mako/scripts/walker.sh & disown
    makoctl dismiss --all -h
    exit 0
elif [ "$chosen" = "󰔡  Toggle DND" ]; then
    makoctl mode -t dnd
    bash ~/.config/mako/scripts/walker.sh & disown
    exit 0
fi
echo "$chosen"

# Actions
action=$(echo -e "󰌍\n  Resend\n  Delete\n  Copy" | walker -d -p "  Notifications")
line=$(echo "$chosen" | sed -E 's/^\[[0-9]{2}:[0-9]{2}\] //')
title=$(echo "$line" | cut -d'|' -f1 | xargs)           
body=$(echo "$line" | cut -d'|' -f2- | xargs)

case "$action" in
    "󰌍")
        bash ~/.config/mako/scripts/walker.sh & disown
        ;;
    "  Resend")
        echo "$title"
        num=$(get_notification_num "$title")

        makoctl restore "$num"
        ( sleep 3 && makoctl dismiss "$num" ) & disown
        ;;
    "  Delete")
        grep -Fxv "$chosen" "$logfile" > "${logfile}.tmp" && mv "${logfile}.tmp" "$logfile"
        ;;
    "  Copy")
        echo "$title | $body" | wl-copy
        ;;
esac

