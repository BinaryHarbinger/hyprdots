#!/bin/bash

widget="volOSD"
timer_pid=""

show_osd() {
    local vol
    vol=$(pamixer --get-volume)


    if ! ewwii active-windows | grep -q '^volOSD:'; then
        ewwii open "$widget"
    fi

    if [ -n "$timer_pid" ] && kill -0 "$timer_pid" 2>/dev/null; then
        kill "$timer_pid" 2>/dev/null
    fi

    (
        sleep 2
        ewwii close "$widget"
    ) &
    timer_pid=$!
}

pw-mon | while read -r line; do
    case "$line" in
        *"Audio/Sink"*|*"Props changed"*)
            show_osd
            ;;
    esac
done

