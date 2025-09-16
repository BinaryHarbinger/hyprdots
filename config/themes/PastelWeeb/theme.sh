#!/bin/bash

ln -sf ~/.config/hypr/styles/waybar/floating.css ~/.config/waybar/style.css
ln -sf ~/.config/hypr/styles/waybar/floatConfig ~/.config/waybar/config

bash ~/.config/scripts/wallpaper -s ~/.config/hypr/wallpapers/Arch-chan.png

scheme="pastelweeb"

sed -i "s/vim\.cmd(\"colorscheme .*\")/vim.cmd(\"colorscheme $scheme\")/" ~/.config/nvim/init.lua

sed -i "s/theme: \".*\",/theme: \"$scheme\",/" ~/.config/rmpc/config.ron
