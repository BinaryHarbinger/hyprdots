if status is-interactive
    # Commands to run in interactive sessions can go here
    if type -q fastfetch
        fastfetch
    else
        /usr/sbin/neofetch
    end
end
