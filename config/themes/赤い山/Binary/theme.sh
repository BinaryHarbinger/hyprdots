#!/bin/bash

cp -r ~/.config/hypr/styles/waybar/default.css ~/.config/waybar/style.css
cp -r ~/.config/hypr/styles/waybar/defaultConfig ~/.config/waybar/config

bash ~/.config/scripts/wallpaper -s ~/.config/hypr/wallpapers/Lines.png

scheme="binaryharbinger"

sed -i "s/vim\.cmd(\"colorscheme .*\")/vim.cmd(\"colorscheme $scheme\")/" ~/.config/nvim/init.lua
