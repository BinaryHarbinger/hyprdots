function sudo
    if type -q sudo-rs
        command sudo-rs $argv
    else
        command sudo $argv
    end
end

function su
    if type -q su-rs
        command su-rs $argv
    else
        command su $argv
    end
end

function ls
    if type -q eza
        command eza --icons $argv
    else
        command ls $argv
    end
end

function cat
    if type -q bat
        command bat $argv
    else
        command cat $argv
    end
end

function grep
    if type -q rg
        command rg --color=always --line-number $argv
    else
        command grep $argv
    end
end

function hclear
    echo yes | history clear >/dev/null 2>&1
    clear
    neofetch
end

function snvim
    sudo HOME=/home/$USER nvim -u /home/$USER/.config/nvim/init.lua $argv
end

function neofetch
    if type -q fastfetch
        fastfetch
    else
        /usr/sbin/neofetch
    end
end

function man
    if type -q bat
        command man $argv | col -bx | bat -l man
    else
        man $argv
    end
end

