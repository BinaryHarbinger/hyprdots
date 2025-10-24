#!/bin/bash

widget="volOSD"
prevState=""
timer_pid=""

show_osd() {
    
    local state="$1"

    if ! ewwii active-windows | grep -q '^volOSD:'; then
        ewwii open "$widget"
        ewwii update --inject "volume=$1"
    fi

    # Kill old timer
    if [ -n "$timer_pid" ] && kill -0 "$timer_pid" 2>/dev/null; then
        kill "$timer_pid" 2>/dev/null
    fi

    # Start new timer
    (
        sleep 2
        ewwii close "$widget"
    ) &
    timer_pid=$!
}

while true; do
    currentState=$(pamixer --get-volume)
    if [ "$currentState" != "$prevState" ]; then
        ewwii update --inject $currentState
        show_osd "$currentState"
        prevState="$currentState"
    fi
    sleep 0.2
done

