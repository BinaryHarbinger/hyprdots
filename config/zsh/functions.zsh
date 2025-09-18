unalias -m '*'

sudo() {
    if command -v sudo-rs >/dev/null 2>&1; then
        command sudo-rs "$@"
    else
        command sudo "$@"
    fi
}

su() {
    if command -v su-rs >/dev/null 2>&1; then
        command su-rs "$@"
    else
        command su "$@"
    fi
}

ls() {
    if command -v eza >/dev/null 2>&1; then
        command eza --icons "$@"
    else
        command ls "$@"
    fi
}

cat() {
    if command -v bat >/dev/null 2>&1; then
        command bat "$@"
    else
        command cat "$@"
    fi
}

grep() {
    if command -v rg >/dev/null 2>&1; then
        command rg --color=always --line-number "$@"
    else
        command grep "$@"
    fi
}

hclear() {
    history -p
    clear
    neofetch
}

snvim() {
    sudo HOME="/home/$USER" nvim -u "/home/$USER/.config/nvim/init.lua" "$@"
}

neofetch() {
    if command -v fastfetch >/dev/null 2>&1; then
        fastfetch
    else
        /usr/sbin/neofetch
    fi
}

man() {
    if command -v bat >/dev/null 2>&1; then
        command man "$@" | col -bx | bat -l man
    else
        command man "$@"
    fi
}
