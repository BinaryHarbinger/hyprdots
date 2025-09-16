#!/bin/bash

ln -sf ~/.config/hypr/styles/waybar/default.css ~/.config/waybar/style.css
ln -sf ~/.config/hypr/styles/waybar/defaultConfig ~/.config/waybar/config

bash ~/.config/scripts/wallpaper -s ~/.config/hypr/wallpapers/赤い山.jpg

scheme="akaiyama"

sed -i "s/vim\.cmd(\"colorscheme .*\")/vim.cmd(\"colorscheme $scheme\")/" ~/.config/nvim/init.lua

sed -i "s/theme: \".*\",/theme: \"$scheme\",/" ~/.config/rmpc/config.ron

