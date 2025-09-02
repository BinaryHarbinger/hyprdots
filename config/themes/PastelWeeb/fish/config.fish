
if status is-interactive
    # Commands to run in interactive sessions can go here
    fastfetch
end

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

set -Ux fish_user_paths $fish_user_paths ~/.config/scripts

# Created by `pipx` on 2025-02-20 15:01:21
set PATH $PATH ~/.local/bin

