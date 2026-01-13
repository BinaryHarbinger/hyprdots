#!/bin/bash

widget="volOSD"
media_widget="mediaOSD"
timer_pid=""
prev_vol=$(pamixer --get-volume)
prev_track=""
prev_status=""

# --- Show volume OSD ---
show_osd() {
    local vol
    vol=$(pamixer --get-volume)
    [ "$vol" = "$prev_vol" ] && return
    prev_vol="$vol"

    ewwii active-windows | grep -q "^$media_widget:" && ewwii close "$media_widget"
    ! ewwii active-windows | grep -q "^$widget:" && ewwii open "$widget"

    [ -n "$timer_pid" ] && kill "$timer_pid" 2>/dev/null
    ( sleep 2; ewwii close "$widget" ) &
    timer_pid=$!
}

# --- Show media OSD ---
show_media_osd() {
    ewwii active-windows | grep -q "^$widget:" && ewwii close "$widget"
    ! ewwii active-windows | grep -q "^$media_widget:" && ewwii open "$media_widget"

    [ -n "$timer_pid" ] && kill "$timer_pid" 2>/dev/null
    ( sleep 2; ewwii close "$media_widget" ) &
    timer_pid=$!
}

# --- Volume watcher ---
(
    while true; do
        vol=$(pamixer --get-volume)
        [ "$vol" != "$prev_vol" ] && show_osd
        sleep 0.8
    done
) &

# --- Media watcher ---
# Follow both title and playback status
playerctl metadata --follow --format 'TITLE:{{xesam:title}}' 2>/dev/null | while read -r line; do
    # Track title change
    if [[ "$line" == TITLE:* ]]; then
        track="${line#TITLE:}"
        if [ "$track" != "$prev_track" ]; then
            prev_track="$track"
            show_media_osd
        fi
    fi
done &

# Separate status watcher
playerctl --follow status 2>/dev/null | while read -r status; do
    if [ "$status" != "$prev_status" ]; then
        prev_status="$status"
        show_media_osd
    fi
done

wait
