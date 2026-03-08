#!/bin/bash

# Volume monitor script
# Listens for volume changes and outputs D characters proportional to volume
# Total D count = 8, filled with D based on volume percentage

TOTAL=30
LAST_VOL=-1

get_volume() {
    # Try pactl (PulseAudio/PipeWire)
    if command -v pactl &>/dev/null; then
        pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null \
            | grep -oP '\d+(?=%)' | head -1
        return
    fi
    # Fallback: amixer (ALSA)
    if command -v amixer &>/dev/null; then
        amixer get Master 2>/dev/null \
            | grep -oP '\d+(?=%)' | head -1
        return
    fi
    echo ""
}

build_output() {
    local vol=$1
    # Number of D's = round(vol * TOTAL / 100), clamped 0..TOTAL
    local filled=$(( (vol * TOTAL + 50) / 100 ))
    (( filled < 0 )) && filled=0
    (( filled > TOTAL )) && filled=TOTAL
    local empty=$(( TOTAL - filled ))

    local out=""
    # filled █'s
    for (( i=0; i<filled; i++ )); do out+="█"; done
    out+=""
    # empty spaces
    for (( i=0; i<empty; i++ )); do out+=" "; done
    echo "$out"
}

# If pactl is available, use subscribe for instant events
if command -v pactl &>/dev/null; then
    # Print initial state
    VOL=$(get_volume)
    if [[ -n "$VOL" ]]; then
        LAST_VOL=$VOL
        echo "$VOL"
    fi

    # Listen for sink/source change events
    pactl subscribe 2>/dev/null | while read -r line; do
        if echo "$line" | grep -qE "sink|source|change"; then
            VOL=$(get_volume)
            if [[ -n "$VOL" && "$VOL" != "$LAST_VOL" ]]; then
                LAST_VOL=$VOL
                echo "$VOL"
            fi
        fi
    done
else
    # Fallback: polling loop (works with ALSA or any backend)
    while true; do
        VOL=$(get_volume)
        if [[ -n "$VOL" && "$VOL" != "$LAST_VOL" ]]; then
            LAST_VOL=$VOL
            build_output "$VOL"
        fi
        sleep 0.3
    done
fi
