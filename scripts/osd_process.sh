#!/usr/bin/env bash
#
# osd_process.sh — Show riftbar OSD on volume change, auto-close after 5s.
# Uses pactl subscribe for event-driven detection (no polling).
#
# Dependencies: pactl (pipewire-pulse / pulseaudio), riftbar

STATE_FILE="$(mktemp /tmp/volume-osd.XXXXXX)"
TIMER_PID=""
LAST_SNAPSHOT=""

# ── helpers ──────────────────────────────────────────────────────────────────

# Returns a string representing current volume+mute state of all sinks.
# e.g. "50% 50% no|80% 80% yes"
get_volume_snapshot() {
    pactl list sinks 2>/dev/null \
        | awk '/^\s*Volume:/{vol=$0} /^\s*Mute:/{print vol "|" $0}' \
        | tr -d ' \t'
}

is_open() {
    [[ "$(cat "$STATE_FILE" 2>/dev/null)" == "open" ]]
}

osd_open() {
    if ! is_open; then
        riftbar --ipc open osd
        echo "open" > "$STATE_FILE"
    fi
}

osd_close() {
    riftbar --ipc close osd
    echo "closed" > "$STATE_FILE"
}

cancel_timer() {
    if [[ -n "$TIMER_PID" ]] && kill -0 "$TIMER_PID" 2>/dev/null; then
        kill "$TIMER_PID" 2>/dev/null
        wait "$TIMER_PID" 2>/dev/null
    fi
    TIMER_PID=""
}

reset_timer() {
    cancel_timer
    ( sleep 5 && osd_close ) &
    TIMER_PID=$!
}

# ── cleanup on exit ───────────────────────────────────────────────────────────

cleanup() {
    cancel_timer
    is_open && riftbar --ipc close osd
    rm -f "$STATE_FILE"
    exit 0
}
trap cleanup INT TERM EXIT

# ── main event loop ───────────────────────────────────────────────────────────

LAST_SNAPSHOT="$(get_volume_snapshot)"

while IFS= read -r _line; do
    CURRENT_SNAPSHOT="$(get_volume_snapshot)"
    if [[ "$CURRENT_SNAPSHOT" != "$LAST_SNAPSHOT" ]]; then
        LAST_SNAPSHOT="$CURRENT_SNAPSHOT"
        osd_open
        reset_timer
    fi
done < <(pactl subscribe 2>/dev/null | grep --line-buffered "Event 'change' on sink")
