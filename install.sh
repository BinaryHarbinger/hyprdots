#!/bin/bash

set -euo pipefail

if [ ! -t 0 ]; then
    curl -fsSL -o /tmp/install.sh https://raw.githubusercontent.com/BinaryHarbinger/binarydots/main/install.sh
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

confirmation() {
    local title="$1"
    shift

    if [ -t 1 ]; then
        # TTY var, renk seçenekleri olmadan çalıştır
        gum confirm "$title"
    else
        # TTY yok, renkli seçeneklerle çalıştır
        gum confirm "$title" --selected.background="100" --prompt.foreground="1000"
    fi
}

confirmation_alt() {
    local title="$1"
    shift

    if [ -t 1 ]; then
        # TTY var, renk seçenekleri olmadan
        gum confirm "$title"
    else
        # TTY yok, renkli seçeneklerle
        gum confirm "$title" --selected.background="75" --prompt.foreground="1000"
    fi
}


info() { gum style --foreground "#49A22C" -- <<< "➤ $1"; }

process() {
    local title="$1"
    shift
    gum spin --spinner dot --title "$title" -- "$@" 
}

error() { gum style --foreground "#FF5555" -- <<< "✖ $1"; }

echo -e "${BLUE}
██████╗ ██╗███╗   ██╗ █████╗ ██████╗ ██╗   ██╗██████╗  ██████╗ ████████╗███████╗
██╔══██╗██║████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝
██████╔╝██║██╔██╗ ██║███████║██████╔╝ ╚████╔╝ ██║  ██║██║   ██║   ██║   ███████╗
██╔══██╗██║██║╚██╗██║██╔══██║██╔══██╗  ╚██╔╝  ██║  ██║██║   ██║   ██║   ╚════██║
██████╔╝██║██║ ╚████║██║  ██║██║  ██║   ██║   ██████╔╝╚██████╔╝   ██║   ███████║
╚═════╝ ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝ \n${RESET}"

# Root check for necessary commands
if [[ $EUID -eq 0 ]]; then
    error "Please do not run this script as root.\n"
    exit 1
fi

echo -e "   Binary Harbinger's Hyprland dotfiles\n\n"
confirmation "Proceed with setup?" || exit 0

# --- Update system ---
if ! check_dep paru; then
    
    if confirmation "Install paru?"; then
        info "Installing dependecies..."
        sudo pacman -S --needed base-devel git rust
        if [ ! -d "paru" ]; then
        process "Cloning paru repository..." git clone https://aur.archlinux.org/paru.git || error "Failed to clone paru"
fi
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

info "Updating System..."
paru -Syu --repo --no-confirm || error "Failed to Update system try manually." && exit 1
info "System Updated."

# --- Packages ---
PACKAGES=(
    breeze nwg-look qt6ct papirus-icon-theme bibata-cursor-theme catppuccin-gtk-theme-mocha
    ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-fira-code ttf-firacode-nerd otf-fira-code-symbol ttf-material-design-iconic-font ttf-cascadia-mono-nerd noto-fonts-cjk
    yazi wiremix fzf
    hyprland hyprlock hypridle hyprpolkitagent hyprsunset hyprpicker
    power-profiles-daemon udiskie network-manager-applet brightnessctl
    cliphist stow git zsh unzip fastfetch pamixer mako foot swww
    mpv mpd mpdris2-rs rmpc
    base-devel
    python-flask python-requests
    pcmanfm-qt riftbar-bin ewwii-bin
    walker-bin
)

PACKAGES_URL="https://raw.githubusercontent.com/BinaryHarbinger/binarydots/refs/heads/main/PACKAGES"

PACKAGES=($(curl -s "$PACKAGES_URL")) || true

# --- Install packages ---
if ! paru -S --needed "${PACKAGES[@]}"; then
    error "Package installation failed."
    exit 1
else
    info "Installed packages."    
fi

if confirmation_alt "Install qutebrowser? (Not Recommended) A keyboard-driven, vim-like browser based on Python and Qt"; then
    if paru -S --skip-installed qutebrowser; then
        info "Installed qutebrowser."
    else
        error "Failed to install qutebrowser"
    fi
fi

# --- NVIDIA detection & driver installation ---
NVIDIGPU="yes"
if lspci | grep -qi 'NVIDIA'; then
    info "NVIDIA GPU detected."
    if ! pacman -Qi nvidia-dkms >/dev/null 2>&1; then
        process "Installing nvidia-dkms (required for NVIDIA GPUs)..." paru -S --noconfirm --needed nvidia-dkms || error "Failed to install 'nvidia-dkms'. Please install manually" 
        info "nvidia-dkms installed successfully."
    else
        info "nvidia-dkms already installed."
    fi
else
NVIDIGPU="no"
fi

# --- Clone dotfiles ---

if [ ! -d "./config" ]; then
    [ -d "$HOME/Dotfiles.old" ] && rm -rf "$HOME/Dotfiles.old" || true
    [ -d "$HOME/Dotfiles" ] && mv ~/Dotfiles ~/Dotfiles.old || true
    
    REPO_URL="https://github.com/BinaryHarbinger/binarydots.git"
    PROXY_URL="https://gh-proxy.com/$REPO_URL"

    process "Cloning binarydots repository..." git clone "$PROXY_URL" ~/Dotfiles
    if [ $? -ne 0 ]; then
        echo "Proxy failed, trying direct GitHub clone..."
        process "Cloning binarydots repository (direct)..." git clone "$REPO_URL" || { 
            error "Failed to clone repository."
            exit 1
        }
    fi


    info "Cloned Repository."

else
    info "Files already installed."
fi

# --- Link scripts/configs ---

process "Moving scripts and configs..." bash -c '

[ -d "$HOME/dots.old" ] && rm -rf "$HOME/dots.old"

mkdir -p "$HOME/dots.old"

folders=(
    "binarydots" "cava" "ewwii" "fastfetch" "foot" "gtk-3.0" "gtk-4.0"
    "hypr" "mako" "mpd" "mpv" "pcmanfm-qt" "nwg-look" "qt6ct" 
    "qutebrowser" "rmpc" "walker" "riftbar" "wiremix" "yazi"
    "zsh"
)

for item in "${folders[@]}"; do
    src="$HOME/Dotfiles/config/$item"
    dest="$HOME/.config/$item"

    if [ -d "$dest" ] && [ ! -L "$dest" ]; then
        [ -e "$HOME/dots.old/$item" ] && rm -rf "$HOME/dots.old/$item"
        mv "$dest" "$HOME/dots.old/" 2>/dev/null || true
    elif [ -L "$dest" ]; then
        rm "$dest" 2>/dev/null || true
    fi

    if [ -e "$src" ]; then
        ln -s "$src" "$dest"
    fi
done

chmod +x \
    "$HOME/Dotfiles/bin/"* \
    "$HOME/Dotfiles/scripts/"* \
    "$HOME/Dotfiles/config/hypr/scripts/"* \
    "$HOME/Dotfiles/config/ewwii/scripts/"* \
    "$HOME/Dotfiles/config/mako/scripts/"* || true
'

info "Linked scripts and config files."

if [ "$NVIDIGPU" != 'yes' ]; then
  if confirmation_alt "Is your main monitor external?"; then
    sed -i 's/^env = AQ_DRM_DEVICES,\/dev\/dri\/card0:\/dev\/dri\/card1/#&/' ~/.config/hypr/hyprland.conf
  fi
fi



# --- Polkit agent ---
process "Setting up polkit agent..." systemctl --user enable --now hyprpolkitagent.service

if [ $? -eq 0 ]; then
    info "Polkit agent set up successfully."
else
    error "Failed to enable polkit agent."
fi

# --- MPD services ---

if confirmation_alt "Set up MPD? (Not Recommended for new users)"; then
    process "Setting Up MPD" bash -c '

    systemctl --user enable mpd 
    
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
    sed -i "s/kb_layout = tr/kb_layout = ${LAYOUT}/g" "$HOME/.config/hypr/hyprland.conf"
fi

# --- Change shell ---

current_shell=$(getent passwd "$USER" | cut -d: -f7)

if [ "$current_shell" != "/usr/bin/zsh" ] && [ "$current_shell" != "/bin/zsh" ]; then
    if confirmation_alt "Change default shell to zsh?"; then
        if chsh -s /bin/zsh "$USER"; then
            info "Default shell changed to zsh."

            if [ ! -d "$HOME/.oh-my-zsh" ]; then
                sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
            fi            
            CUSTOM_PLUGIN_DIR="$HOME/.oh-my-zsh/custom/plugins"
            mkdir -p "$CUSTOM_PLUGIN_DIR"
            declare -A plugins
            plugins=(
            [zsh-autosuggestions]="https://github.com/zsh-users/zsh-autosuggestions.git"
            [zsh-syntax-highlighting]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
            [rust]="https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/rust.git"
            )

            # Clone each plugin silently
            for plugin in "${!plugins[@]}"; do
            PLUGIN_DIR="$CUSTOM_PLUGIN_DIR/$plugin"
                if [ ! -d "$PLUGIN_DIR" ]; then
                    git clone -q "${plugins[$plugin]}" "$PLUGIN_DIR" > /dev/null 2>&1
                fi
            done
            

            ln -sf ~/Dotfiles/home/.zshrc $HOME/.zshrc

            info "Configured ZSH."
            if confirmation_alt "Install some rust utils? (Recommended)"; then
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

    # ewwii restart
    if pgrep ewwii >/dev/null; then
        killall ewwii
        ewwii daemon >/dev/null 2>&1 & disown
        for widget in "status" "desktopmusic" ; do
            ewwii open "$widget" >/dev/null 2>&1 &
        done

    fi
    setsid swww-daemon >/dev/null 2>&1 &
    hyprctl reload'

    info "Reloaded Components."
fi

# --- Cleanup ---
cd ..
process "Cleaning up..." rm -rf binarydots
info "Cleaned."

$HOME/Dotfiles/bin/change-theme -c Binary >> /dev/null
echo -e  "${GREEN}✅ Installation complete!"
