#!/bin/bash

set -euo pipefail

if [ ! -t 0 ]; then
    # Pipe ile çalıştırılıyor
    curl -fsSL -o /tmp/install.sh https://raw.githubusercontent.com/BinaryHarbinger/hyprdots/main/install.sh
    chmod +x /tmp/install.sh
    exec /tmp/install.sh "$@"
fi

# --- Colors ---
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
RESET=$(tput sgr0)

# --- Get sudo password ---
echo "Enter your sudo password:"
sudo echo
echo -e "${GREEN}➤ Succses. ${RESET}"

# --- Dependency check --
check_dep() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo -e "${RED}✖'$1' is not installed.${RESET}"
        return 1
    fi
}


# --- Gum check & install ---
if ! check_dep gum; then
    echo -e "${BLUE}Installing gum...${RESET}"
    if ! sudo pacman -S --noconfirm gum; then
        echo -e "${RED}✖ Failed to install gum. Please install it manually. ${RESET}"
        exit 1
    fi
fi



info() { gum style --foreground "#49A22C" -- <<< "➤ $1"; }
process() {
    local title="$1"
    shift
    gum spin --spinner dot --title "$title" -- "$@" 
}
error() { gum style --foreground "#FF5555" -- <<< "✖ $1"; }

echo -e "${BLUE}
░█▀▄░▀█▀░█▀█░█▀█░█▀▄░█░█░░░█▀▄░█▀█░▀█▀░█▀▀
░█▀▄░░█░░█░█░█▀█░█▀▄░░█░░░░█░█░█░█░░█░░▀▀█
░▀▀░░▀▀▀░▀░▀░▀░▀░▀░▀░░▀░░░░▀▀░░▀▀▀░░▀░░▀▀▀ \n${RESET}"

# Root check for necessary commands
if [[ $EUID -eq 0 ]]; then
    error "Please do not run this script as root.\n"
    exit 1
fi

echo -e "   Binary Harbinger's Hyprland dotfiles\n\n"
gum confirm "Proceed with setup?" || exit 0

# --- Update system ---
if ! check_dep paru; then
    
    if gum confirm "Install paru?"; then
        info "Installing dependecies..."
        sudo pacman -S --needed base-devel git
        process "Cloning paru repository..." git clone https://aur.archlinux.org/paru.git 
        info "Building package..."
        cd paru
        makepkg -si
        cd ..
        rm -rf paru
        info "Package (paru) installed."
    else
        error "Aborting setup."
        rm -rf paru 
        exit 1
    fi
fi

if process "Updating system..." bash -c '
    if ! paru -Syu --noconfirm --repo >/dev/null 2>&1; then
        error "System update failed. Try to update manually."
        exit 1
    fi
'; then
    info "System updated."
else
    error "System update failed. Try manually."
    exit 1
fi

# --- Packages ---
PACKAGES=(
    breeze nwg-look qt6ct papirus-icon-theme bibata-cursor-theme catppuccin-gtk-theme-mocha
    ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-fira-code ttf-firacode-nerd otf-fira-code-symbol ttf-material-design-iconic-font
    yazi wiremix
    hyprland hyprlock hypridle hyprpolkitagent hyprsunset hyprpicker
    wlogout
    power-profiles-daemon udiskie network-manager-applet brightnessctl
    cliphist stow git fish unzip fastfetch pamixer swaync foot swww
    mpv mpd mpd-mpris rmpc
    base-devel
    waybar eww
    rofi-wayland rofimoji
)

if ! process "Installing packages..." paru -S --noconfirm --needed "${PACKAGES[@]}"; then
    error "Package installation failed."
    exit 1
fi

# --- NVIDIA detection & driver installation ---
if lspci | grep -qi 'NVIDIA'; then
    info "NVIDIA GPU detected."
    if ! pacman -Qi nvidia-dkms >/dev/null 2>&1; then
        process "Installing nvidia-dkms (required for NVIDIA GPUs)..." paru -S --noconfirm --needed nvidia-dkms || error "Failed to install 'nvidia-dkms'. Please install manually" 
        info "nvidia-dkms installed successfully."
    else
        info "nvidia-dkms already installed."
    fi
fi

# --- Clone dotfiles ---

rm -rf ./hyprdots

REPO_URL="https://github.com/BinaryHarbinger/hyprdots.git"
PROXY_URL="https://gh-proxy.com/$REPO_URL"

process "Cloning hyprdots repository..." git clone "$PROXY_URL"
if [ $? -ne 0 ]; then
    echo "Proxy failed, trying direct GitHub clone..."
    process "Cloning hyprdots repository (direct)..." git clone "$REPO_URL" || { 
        error "Failed to clone repository."
        exit 1
    }
fi

cd hyprdots || { error "Cannot enter dotfiles directory"; exit 1; }

info "Cloned Repository."


# --- Move scripts/configs ---

process "Moving scripts and configs..." bash -c '
    mkdir ~/dots.old
    mv ~/.config/scripts/ ~/dots.old/ > /dev/null 2>&1
    mv ~/.config/hypr/ ~/dots.old/ > /dev/null 2>&1
    mv ~/.config/eww/ ~/dots.old/ > /dev/null 2>&1
    mv ~/.config/fastfetch/ ~/dots.old/ > /dev/null 2>&1
    mv ~/.config/nvim/ ~/dots.old/ > /dev/null 2>&1
    mv ~/.config/rofi/ ~/dots.old/ > /dev/null 2>&1
    mv ~/.config/waybar/ ~/dots.old/ > /dev/null 2>&1
    mv ~/.config/foot/ ~/dots.old/ > /dev/null 2>&1
    mv ~/.config/mpd/ ~/dots.old/ > /dev/null 2>&1
    mv ~/.config/rmpc/ ~/dots.old/ > /dev/null 2>&1
    cp -rf ./scripts ~/.config/ > /dev/null 2>&1
    chmod +x ~/.config/scripts/* || true
    cp -rf ./config/* ~/.config/ > /dev/null 2>&1
    chmod +x ~/.config/hypr/scripts/* ~/.config/eww/scripts/* || true' 

info 'Moved scripts and config files.'

# --- Polkit agent ---
process "Setting up polkit agent..." systemctl --user enable --now hyprpolkitagent.service

if [ $? -eq 0 ]; then
    info "Polkit agent set up successfully."
else
    error "Failed to enable polkit agent."
fi

# --- MPD services ---

if gum confirm "Set up MPD? (Not Recommended for new users)"; then
    process "Setting Up MPD" bash -c '

    systemctl --user enable mpd 
    systemctl --user enable mpd-mpris
    
    systemctl --user start mpd-mpris
    systemctl --user start mpd
    '

    if [ $? -eq 0 ]; then
        info "MPD setup succeeded"
    else
        error "MPD setup failed"
    fi
else
    rm -rf ~/.config/rmpc/ 
    rm -rf ~/.config/mpd/ 
    if [ -d "$HOME/dots.old/rmpc" ]; then
        cp -r "$HOME/dots.old/rmpc" "$HOME/.config/" > /dev/null 2>&1
    fi
    if [ -d "$HOME/dots.old/mpd" ]; then
        cp -r "$HOME/dots.old/mpd" "$HOME/.config/" > /dev/null 2>&1
    fi


fi

# --- Layout update ---

LAYOUT=$(localectl status | awk -F': ' '/X11 Layout/{print $2}')

if [[ -z $LAYOUT ]]; then
    error "Could not detect keyboard layout."
else
    sed -i "s/kb_layout = tr/kb_layout = ${LAYOUT}/g" ./config/hypr/hyprland.conf
fi

# Change shell

current_shell=$(getent passwd "$USER" | cut -d: -f7)

if [ "$current_shell" != "/usr/bin/fish" ] && [ "$current_shell" != "/bin/fish" ]; then
    if gum confirm "Change default shell to fish?"; then
        if chsh -s /bin/fish "$USER"; then
            info "Default shell changed to fish."
            if gum confirm "Install some rust utils? (Recommended)"; then
                if process "Installing rust utilities" paru -S --needed --noconfirm eza sudo-rs bat ripgrep sd fd ; then
                    info "Successfully installed rust utils." 
                else
                    error "Failed to install rust utilities."
                fi
            fi
        else
            error "Failed to change shell."
        fi
    fi
fi

# --- Post installation ---

ln -sf "$HOME/.config/hypr/wallpapers/lines.jpg" "$HOME/.config/hypr/wallppr.png"

python ~/.config/hypr/scripts/wallpapers.py changeWallpaper Lines >/dev/null 2>&1 & disown

if pgrep Hyprland >/dev/null; then
    info "Detected Hyprland session."

   process "Reloading Components..." bash -c '
    
    pkill waybar >/dev/null 2>&1 & disown
    
    # swww-daemon restart
    if pgrep swww-daemon >/dev/null; then
        pkill swww-daemon
        sleep 0.5
    fi 

    # eww restart
    if pgrep eww >/dev/null; then
        killall eww
        eww daemon >/dev/null 2>&1 &
        disown
        eww open-many stats desktopmusic >/dev/null 2>&1
    fi
    nohup waybar >/dev/null 2>&1 & disown
    setsid swww-daemon >/dev/null 2>&1 &'

    info "Reloaded Components."
fi

# --- Cleanup ---
cd ..
process "Cleaning up..." rm -rf hyprdots
info "Cleaned."

bash $HOME/.config/scripts/change-theme -p
echo -e  "${GREEN}✅ Installation complete!"
