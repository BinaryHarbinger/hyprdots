#!/bin/sh

# Get brightness info in machine-readable format
brightnessctl -m \
  | sed 's/,/ /g' \
  | awk '{print $3/$5*100}'

