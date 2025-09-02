#!/bin/bash                                                                      

cp -r ~/.config/hypr/styles/waybar/windows.css ~/.config/waybar/style.css
cp -r ~/.config/hypr/styles/waybar/windowsConfig ~/.config/waybar/config

bash ~/.config/scripts/wallpaper -s ~/.config/hypr/wallpapers/Windows.jpg

scheme="windoes"

sed -i "s/vim\.cmd(\"colorscheme .*\")/vim.cmd(\"colorscheme $scheme\")/" ~/.config/nvim/init.lua
