#!/bin/sh

logfile="$HOME/.local/share/mako/notifications.log"

case "$1" in
    --dnd-toggle|-d) makoctl mode -t dnd; exit 0 ;;
    --status|-s|"") ;;
    *) echo "Unknown option: $1"; exit 1 ;;
esac

dnd=0
makoctl mode | grep -q '^dnd$' && dnd=1

new=0
[ "$(wc -l < "$logfile")" -gt 0 ] && new=1

if [ "$dnd" -eq 1 ] && [ "$new" -eq 1 ]; then
    echo "<span rise='7000' size='11000' letter_spacing='-24000'></span>"
elif [ "$dnd" -eq 1 ] && [ "$new" -eq 0 ]; then
    echo "<span foreground='gray' rise='7000' size='11000' letter_spacing='-24000'></span>"
elif [ "$dnd" -eq 0 ] && [ "$new" -eq 1 ]; then
    echo "󱅫"
else
    echo "󰂚"
fi

