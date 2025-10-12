#!/bin/bash

case $1 in
    speaker)
        if command -v pamixer &>/dev/null && command -v pactl &>/dev/null; then
            if [ "$2" = "listen" ]; then
                # Output current volume immediately
                prev_vol=$(pamixer --get-volume)
                echo "$prev_vol"

                threshold=1  # minimum change to trigger output

                # Listen for changes on the default sink
                pactl subscribe | while read -r line; do
                    if [[ "$line" =~ "Event 'change' on sink" ]]; then
                        sleep 0.05  # Wait a short moment to ensure the volume is updated
                        default_sink=$(pactl info | grep "Default Sink" | awk '{print $3}')
                        vol=$(pamixer --sink "$default_sink" --get-volume)

                        diff=$((vol > prev_vol ? vol - prev_vol : prev_vol - vol))

                        # Only output if different from previous value and exceeds threshold
                        if [ "$diff" -ge "$threshold" ]; then
                            echo "$vol"
                            prev_vol="$vol"
                        fi
                    fi
                done
            else
                if [ "$(pamixer --get-mute)" = "true" ]; then
                    echo 0
                else
                    pamixer --get-volume
                fi
            fi
        else
            echo "pamixer or pactl not found"
            exit 1
        fi
        ;;
    mic)
        if command -v pamixer &>/dev/null; then
            pamixer --source @DEFAULT_SOURCE@ --get-volume
        else
            echo "pamixer not found"
            exit 1
        fi
        ;;
    *)
        echo "Usage: $0 {speaker|mic} [listen]"
        exit 1
        ;;
esac

