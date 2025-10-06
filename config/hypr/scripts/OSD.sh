#!/bin/bash

widget="volOSD"
prevState=""
timer_pid=""

show_osd() {
    eww update volume="$1"
    ewwii update volume="$1"

    if ! eww active-windows | grep -q "$widget"; then
        eww open "$widget"
    fi

    # Kill old timer
    if [ -n "$timer_pid" ] && kill -0 "$timer_pid" 2>/dev/null; then
        kill "$timer_pid" 2>/dev/null
    fi

    # Start new timer
    (
        sleep 2
        eww close "$widget"
    ) &
    timer_pid=$!
}

while true; do
    currentState=$(pamixer --get-volume)
    if [ "$currentState" != "$prevState" ]; then
        show_osd "$currentState"
        prevState="$currentState"
    fi
    sleep 0.2
done

