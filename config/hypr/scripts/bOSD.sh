#!/bin/bash

widget="brightOSD"
prevState=""
timer_pid=""

show_osd() {
    
    if ! ewwii active-windows | grep "$widget"; then
        ewwii open "$widget"
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
    currentState=$(brightnessctl -m echo 'text|jdbc' | sed -e 's/,/\ /g' | awk '{print $3/$5*100}    ')
    if [ "$currentState" != "$prevState" ]; then
        show_osd "$currentState"
        prevState="$currentState"
    fi
    sleep 0.2
done
