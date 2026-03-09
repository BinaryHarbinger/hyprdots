#!/bin/bash
pkill riftbar
pkill ewwii
sleep 0.2
hyprlock
riftbar &
disown
ewwii d
python ~/Dotfiles/scripts/widgets.py r &
disown
