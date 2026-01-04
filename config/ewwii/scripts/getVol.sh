#!/bin/bash

require_pamixer() {
    if ! command -v pamixer &>/dev/null; then
        echo "pamixer not found"
        exit 1
    fi
}

case $1 in
    speaker)
        require_pamixer

        if [ "$2" = "listen" ]; then
            prev_vol=$(pamixer --get-volume)
            echo "$prev_vol"

            pactl subscribe | while read -r line; do
                case "$line" in
                    *"Event 'change' on sink"*|*"Event 'change' on server"*)
                        vol=$(pamixer --get-volume)
                        if [ "$vol" != "$prev_vol" ]; then
                            echo "$vol"
                            prev_vol="$vol"
                        fi
                        ;;
                esac
            done
        else
            if [ "$(pamixer --get-mute)" = "true" ]; then
                echo 0
            else
                pamixer --get-volume
            fi
        fi
        ;;

    mic)
        require_pamixer

        if [ "$2" = "listen" ]; then
            prev_vol=$(pamixer --source @DEFAULT_SOURCE@ --get-volume)
            echo "$prev_vol"

            pactl subscribe | while read -r line; do
                case "$line" in
                    *"Event 'change' on source"*|*"Event 'change' on server"*)
                        vol=$(pamixer --source @DEFAULT_SOURCE@ --get-volume)
                        if [ "$vol" != "$prev_vol" ]; then
                            echo "$vol"
                            prev_vol="$vol"
                        fi
                        ;;
                esac
            done
        else
            pamixer --source @DEFAULT_SOURCE@ --get-volume
        fi
        ;;

    *)
        echo "Usage: $0 {speaker|mic} [listen]"
        exit 1
        ;;
esac
