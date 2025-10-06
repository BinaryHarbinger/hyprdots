#!/bin/bash

case $1 in
    speaker)
        if command -v pamixer &>/dev/null; then
            if [ "$(pamixer --get-mute)" = "true" ]; then
                echo 0
            else
                pamixer --get-volume
            fi
        else
            echo "pamixer not found"
            exit 1
        fi
        ;;
    mic)
        if command -v pamixer &>/dev/null; then
            # Varsayılan mikrofonu kullanarak ses değerini al
            pamixer --source @DEFAULT_SOURCE@ --get-volume
        else
            echo "pamixer not found"
            exit 1
        fi
        ;;
    *)
        echo "Usage: $0 {speaker|mic}"
        exit 1
        ;;
esac


