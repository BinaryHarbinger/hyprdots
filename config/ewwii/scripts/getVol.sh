#!/bin/bash

case $1 in
    speaker)
        if command -v pamixer &>/dev/null; then
            if [ "$2" = "listen" ]; then
                prev_vol=$(pamixer --get-volume)
                echo "$prev_vol"
                threshold=1  # minimum değişim

                while true; do
                    vol=$(pamixer --get-volume)
                    diff=$((vol > prev_vol ? vol - prev_vol : prev_vol - vol))
                    if [ "$diff" -ge "$threshold" ]; then
                        echo "$vol"
                        prev_vol="$vol"
                    fi
                    sleep 0.5  # yarım saniye bekle
                done
            else
                if [ "$(pamixer --get-mute)" = "true" ]; then
                    echo 0
                else
                    pamixer --get-volume
                fi
            fi
        else
            echo "pamixer not found"
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

