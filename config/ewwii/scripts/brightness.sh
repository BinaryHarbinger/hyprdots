#!/bin/bash

brightnessctl -m echo 'text|jdbc' | sed -e 's/,/\ /g' | awk '{print $3/$5*100}'
