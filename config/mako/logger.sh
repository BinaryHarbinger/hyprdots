#!/bin/bash

logfile="$HOME/.local/share/mako/notifications.log"
mkdir -p "$(dirname "$logfile")"
touch "$logfile"

echo "=== Logging started at $(date) ==="

dbus-monitor "interface='org.freedesktop.Notifications'" | while read -r line; do
    echo "DEBUG: got line -> $line"

    if [[ "$line" == *"member=Notify"* ]]; then
        notify=1
        count=0
        strings=()
        title=""
        body=""
        echo "DEBUG: Notify start"
        continue
    fi

    if [[ "$notify" -eq 1 ]]; then
        if [[ "$line" == string* ]]; then
            ((count++))
            content=$(echo "$line" | sed -E 's/string "(.*)"/\1/')
            strings+=("$content")
            echo "DEBUG: count=$count, content='$content'"
        fi

        # Notify bloğu bitişi
        if [[ "$line" == "int32 "* ]] || [[ "$line" == "]" ]]; then
            date_now=$(date '+%H:%M')

            # Title'ı ayarla
            # DBus strings sırası: 0=app, 1=title param, 2+ = body parçaları
            title_param="${strings[1]}"
            body_parts=("${strings[@]:2}")  # count>=3 stringleri

            # Trim spaces
            title_trimmed=$(echo -n "$title_param" | tr -d '[:space:]')
            echo "DEBUG: title_trimmed='$title_trimmed'"

            if [[ -z "$title_trimmed" ]]; then
                echo "DEBUG: Title was empty. Using first non-empty body string as title."
                if [[ ${#body_parts[@]} -gt 0 ]]; then
                    title="${body_parts[0]}"
                    if [[ ${#body_parts[@]} -gt 1 ]]; then
                        body="${body_parts[@]:1}"
                    else
                        body=""
                    fi
                else
                    title=""
                    body=""
                fi
            else
                title="$title_param"
                if [[ ${#body_parts[@]} -gt 0 ]]; then
                    body="${body_parts[@]}"
                else
                    body=""
                fi
            fi

            if [[ -n "$title" ]]; then
                title="$title |"
            fi

            echo "[$date_now] $title $body" >> "$logfile"
            echo "DEBUG: Logging -> Title: $title | Body: $body"

            notify=0
        fi
    fi
done

