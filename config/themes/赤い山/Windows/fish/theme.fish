if status is-interactive
    # Commands to run in interactive sessions can go here
    set distro (grep '^NAME=' /etc/os-release | cut -d '=' -f2 | tr -d '"')
    echo "$distro [Version 10.0.19045.4529]"
    echo "(c) GNU/Linux Corporation. All rights reserved."
    echo ""
end
