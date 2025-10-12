#!/bin/sh

percent="$1"

duration=$(playerctl metadata mpris:length 2>/dev/null)
duration_sec=$((duration / 1000000))

# POSIX uyumlu tamsayı hesaplama
seek_sec=$((duration_sec * percent / 100))

playerctl position "$seek_sec"

