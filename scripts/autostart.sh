# ==================== Start Up Commands ====================
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP QT_QPA_PLATFORMTHEME
wlr-randr --output eDP-1 --off
systemctl --user start xdg-desktop-portal &
hypridle
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
(sleep 1 && python ~/Dotfiles/scripts/wallpapers.py --init) &
(sleep 1.6 && python ~/Dotfiles/scripts/widgets.py s) &
riftbar &
mako &
bash ~/.config/mako/scripts/logger.sh &
(sleep 5 && bash ~/Dotfiles/scripts/osd_process.sh) &
udiskie &
blueman-applet &
mpdris2-rs -n &
syncthing --no-browser &
tuxedo-control-center --tray &
# ===========================================================
