#!/bin/bash

logfile="$HOME/.local/share/mako/notifications.log"

case "$1" in
    --dnd-toggle|-d)
        makoctl mode -t dnd 
        exit 0
        ;;
    --status|-s)
        ;;
    "")
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

count=$(wc -l < "$logfile")

if [[ $count -gt 0 ]]; then
    new=1
else
    new=0
fi

if [[ $dnd -eq 1 && $new -eq 1 ]]; then
    echo "<span foreground='gray' rise='7000' size='11000' letter_spacing='-24000'></span>"

elif [[ $dnd -eq 1 && $new -eq 0 ]]; then
    echo "<span foreground='gray' rise='7000' size='11000' letter_spacing='-24000'></span>"
elif [[ $dnd -eq 0 && $new -eq 1 ]]; then
    echo "󱅫"
else
    echo "󰂚"
fi

