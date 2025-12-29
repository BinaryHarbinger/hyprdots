#!/bin/bash
STATE_FILE="/tmp/actioncenter_state"

if [ ! -f "$STATE_FILE" ]; then
    echo "false" > "$STATE_FILE"
fi

current_value=$(cat "$STATE_FILE")

if [ "$current_value" = "true" ]; then
    new_value="false"
    echo "Closed"
else
    new_value="true"
    echo "Opened"
fi

ewwii open --toggle actioncenter

echo "$new_value" | tee "$STATE_FILE" > /dev/null

sleep 0.1
