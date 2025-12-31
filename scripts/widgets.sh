#!/bin/bash

cd ~/Dotfiles/resources/data/ || exit 1

exec python ~/Dotfiles/scripts/widgets.py $@
