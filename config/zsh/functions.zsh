source $HOME/.config/zsh/ewwiicomp.zsh

unalias -m '*'

if command -v ani-cli >/dev/null 2>&1; then
    alias ac=ani-cli
fi

if command -v sudo-rs >/dev/null 2>&1; then
    alias sudo=sudo-rs
fi

if command -v su-rs >/dev/null 2>&1; then
    alias su=su-rs
fi

if command -v eza >/dev/null 2>&1; then
    export EZA_ICONS=true
    alias ls='eza --icons --long --group-directories-first --git'
fi

if command -v bat >/dev/null 2>&1; then
    alias cat=bat
fi

snvim() {
    sudo HOME="/home/$USER" nvim -u "/home/$USER/.config/nvim/init.lua" "$@"
}

if command -v fastfetch >/dev/null 2>&1; then
    alias neofetch=fastfetch
fi

man() {
    if command -v nvim >/dev/null 2>&1; then
        command man "$@" | nvim -R - 
    else
        command man
fi
 }

hclear() {
    history -p
    rm -rf ~/.zsh_history
    clear
    if ! [[ -n "$NVIM" ]]; then
            neofetch
    fi
}
