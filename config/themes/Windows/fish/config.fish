if status is-interactive
    # Commands to run in interactive sessions can go here
    set distro (grep '^NAME=' /etc/os-release | cut -d '=' -f2 | tr -d '"')
    echo "$distro [Version 10.0.19045.4529]"
    echo "(c) GNU/Linux Corporation. All rights reserved."
    echo ""
end

set -Ux fish_user_paths $fish_user_paths ~/.config/scripts




# Created by `pipx` on 2025-02-20 15:01:21
set PATH $PATH ~/.local/bin

