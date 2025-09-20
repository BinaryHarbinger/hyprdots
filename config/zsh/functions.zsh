unalias -m '*'


if command -v sudo-rs >/dev/null 2>&1; then
    alias sudo=sudo-rs
fi

if command -v su-rs >/dev/null 2>&1; then
    alias su=su-rs
fi

if command -v eza >/dev/null 2>&1; then
    alias ls='eza --icons'
fi

if command -v bat >/dev/null 2>&1; then
    alias cat=bat
fi

if command -v rg >/dev/null 2>&1; then
    alias grep='rg --color=always --line-number "$@"'
fi

snvim() {
    sudo HOME="/home/$USER" nvim -u "/home/$USER/.config/nvim/init.lua" "$@"
}

if command -v fastfetch >/dev/null 2>&1; then
    alias neofetch=fastfetch
fi

man() {
    if command -v bat >/dev/null 2>&1; then
        command man "$@" | col -bx | bat -l man
    else
        command man
fi
 }

hclear() {
    history -p
    clear
    neofetch
}
