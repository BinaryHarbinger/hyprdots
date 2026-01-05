#!/bin/bash

widget="volOSD"
media_widget="mediaOSD"
timer_pid=""
prev_vol=""

# Kill any existing instances of this script
existing_pids=$(pidof -x "$0")
for pid in $existing_pids; do
    if [ "$pid" != "$$" ]; then
        kill "$pid" 2>/dev/null
    fi
done

# Flag to ignore events during warmup
ignore_events=true

# Start a 2-second warmup timer
(
    sleep 2
    ignore_events=false
) &

# Function to show volume OSD
show_osd() {
    local vol
    vol=$(pamixer --get-volume)

    # Only show if volume has changed
    if [ "$vol" = "$prev_vol" ]; then
        return
    fi
    prev_vol="$vol"

    # Ignore events during warmup
    if [ "$ignore_events" = true ]; then
        return
    fi

    # Close media widget if open
    if ewwii active-windows | grep -q "^$media_widget:"; then
        ewwii close "$media_widget"
    fi

    # Open volume widget if not already open
    if ! ewwii active-windows | grep -q "^$widget:"; then
        ewwii open "$widget"
    fi

    # Kill previous timer if exists
    if [ -n "$timer_pid" ] && kill -0 "$timer_pid" 2>/dev/null; then
        kill "$timer_pid" 2>/dev/null
    fi

    # Close widget after 2 seconds
    (
        sleep 2
        ewwii close "$widget"
    ) &
    timer_pid=$!
}

# Function to show media OSD
show_media_osd() {
    # Ignore events during warmup
    if [ "$ignore_events" = true ]; then
        return
    fi

    # Close volume widget if open
    if ewwii active-windows | grep -q "^$widget:"; then
        ewwii close "$widget"
    fi

    # Open media widget if not already open
    if ! ewwii active-windows | grep -q "^$media_widget:"; then
        echo "media"  # Media event detected
        ewwii open "$media_widget"
    fi

    # Kill previous timer if exists
    if [ -n "$timer_pid" ] && kill -0 "$timer_pid" 2>/dev/null; then
        kill "$timer_pid" 2>/dev/null
    fi

    # Close media widget after 2 seconds
    (
        sleep 2
        ewwii close "$media_widget"
    ) &
    timer_pid=$!
}

# Monitor PipeWire events
pw-mon | while read -r line; do
    case "$line" in
        *"Audio/Sink"*)   # Volume change event
            show_osd
            ;;
        *"Player"*|*"Metadata"*)  # Only real media events
            show_media_osd
            ;;
    esac
done
