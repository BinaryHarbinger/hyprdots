#!/bin/bash

percent="$1"

duration=$(playerctl metadata mpris:length)

duration_sec=$((duration / 1000000))

seek_sec=$(awk "BEGIN { printf \"%.0f\", $duration_sec * $percent / 100 }")

playerctl position "$seek_sec"

