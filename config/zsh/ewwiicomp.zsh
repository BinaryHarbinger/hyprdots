#compdef ewwii

autoload -U is-at-least

_ewwii() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" : \
'-c+[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--config=[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--debug[Write out debug logs. (To read the logs, run \`ewwii logs\`)]' \
'--force-wayland[Force ewwii to use wayland. This is a no-op if ewwii was compiled without wayland support]' \
'--logs[Watch the log output after executing the command]' \
'--no-daemonize[Avoid daemonizing ewwii]' \
'--restart[Restart the daemon completely before running the command]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_ewwii_commands" \
"*::: :->ewwii" \
&& ret=0
    case $state in
    (ewwii)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:ewwii-command-$line[1]:"
        case $line[1] in
            (shell-completions)
_arguments "${_arguments_options[@]}" : \
'-s+[]:SHELL:(bash elvish fish powershell zsh)' \
'--shell=[]:SHELL:(bash elvish fish powershell zsh)' \
'-c+[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--config=[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--debug[Write out debug logs. (To read the logs, run \`ewwii logs\`)]' \
'--force-wayland[Force ewwii to use wayland. This is a no-op if ewwii was compiled without wayland support]' \
'--logs[Watch the log output after executing the command]' \
'--no-daemonize[Avoid daemonizing ewwii]' \
'--restart[Restart the daemon completely before running the command]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(daemon)
_arguments "${_arguments_options[@]}" : \
'-c+[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--config=[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--debug[Write out debug logs. (To read the logs, run \`ewwii logs\`)]' \
'--force-wayland[Force ewwii to use wayland. This is a no-op if ewwii was compiled without wayland support]' \
'--logs[Watch the log output after executing the command]' \
'--no-daemonize[Avoid daemonizing ewwii]' \
'--restart[Restart the daemon completely before running the command]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(logs)
_arguments "${_arguments_options[@]}" : \
'-c+[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--config=[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--debug[Write out debug logs. (To read the logs, run \`ewwii logs\`)]' \
'--force-wayland[Force ewwii to use wayland. This is a no-op if ewwii was compiled without wayland support]' \
'--logs[Watch the log output after executing the command]' \
'--no-daemonize[Avoid daemonizing ewwii]' \
'--restart[Restart the daemon completely before running the command]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(ping)
_arguments "${_arguments_options[@]}" : \
'-c+[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--config=[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--debug[Write out debug logs. (To read the logs, run \`ewwii logs\`)]' \
'--force-wayland[Force ewwii to use wayland. This is a no-op if ewwii was compiled without wayland support]' \
'--logs[Watch the log output after executing the command]' \
'--no-daemonize[Avoid daemonizing ewwii]' \
'--restart[Restart the daemon completely before running the command]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(inspector)
_arguments "${_arguments_options[@]}" : \
'-c+[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--config=[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--debug[Write out debug logs. (To read the logs, run \`ewwii logs\`)]' \
'--force-wayland[Force ewwii to use wayland. This is a no-op if ewwii was compiled without wayland support]' \
'--logs[Watch the log output after executing the command]' \
'--no-daemonize[Avoid daemonizing ewwii]' \
'--restart[Restart the daemon completely before running the command]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(open)
_arguments "${_arguments_options[@]}" : \
'--id=[]:ID: ' \
'--screen=[The identifier of the monitor the window should open on]:SCREEN: ' \
'-p+[The position of the window, where it should open. (i.e.\: 200x100)]:POS: ' \
'--pos=[The position of the window, where it should open. (i.e.\: 200x100)]:POS: ' \
'-s+[The size of the window to open (i.e.\: 200x100)]:SIZE: ' \
'--size=[The size of the window to open (i.e.\: 200x100)]:SIZE: ' \
'-a+[Sidepoint of the window, formatted like "top right"]:ANCHOR: ' \
'--anchor=[Sidepoint of the window, formatted like "top right"]:ANCHOR: ' \
'--duration=[Automatically close the window after a specified amount of time, i.e.\: 1s]:DURATION: ' \
'-c+[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--config=[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--toggle[If the window is already open, close it instead]' \
'--debug[Write out debug logs. (To read the logs, run \`ewwii logs\`)]' \
'--force-wayland[Force ewwii to use wayland. This is a no-op if ewwii was compiled without wayland support]' \
'--logs[Watch the log output after executing the command]' \
'--no-daemonize[Avoid daemonizing ewwii]' \
'--restart[Restart the daemon completely before running the command]' \
'-h[Print help]' \
'--help[Print help]' \
':window_name -- Name of the window you want to open:' \
&& ret=0
;;
(close)
_arguments "${_arguments_options[@]}" : \
'-c+[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--config=[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--debug[Write out debug logs. (To read the logs, run \`ewwii logs\`)]' \
'--force-wayland[Force ewwii to use wayland. This is a no-op if ewwii was compiled without wayland support]' \
'--logs[Watch the log output after executing the command]' \
'--no-daemonize[Avoid daemonizing ewwii]' \
'--restart[Restart the daemon completely before running the command]' \
'-h[Print help]' \
'--help[Print help]' \
'*::windows:' \
&& ret=0
;;
(reload)
_arguments "${_arguments_options[@]}" : \
'-c+[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--config=[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--debug[Write out debug logs. (To read the logs, run \`ewwii logs\`)]' \
'--force-wayland[Force ewwii to use wayland. This is a no-op if ewwii was compiled without wayland support]' \
'--logs[Watch the log output after executing the command]' \
'--no-daemonize[Avoid daemonizing ewwii]' \
'--restart[Restart the daemon completely before running the command]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(kill)
_arguments "${_arguments_options[@]}" : \
'-c+[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--config=[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--debug[Write out debug logs. (To read the logs, run \`ewwii logs\`)]' \
'--force-wayland[Force ewwii to use wayland. This is a no-op if ewwii was compiled without wayland support]' \
'--logs[Watch the log output after executing the command]' \
'--no-daemonize[Avoid daemonizing ewwii]' \
'--restart[Restart the daemon completely before running the command]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(close-all)
_arguments "${_arguments_options[@]}" : \
'-c+[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--config=[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--debug[Write out debug logs. (To read the logs, run \`ewwii logs\`)]' \
'--force-wayland[Force ewwii to use wayland. This is a no-op if ewwii was compiled without wayland support]' \
'--logs[Watch the log output after executing the command]' \
'--no-daemonize[Avoid daemonizing ewwii]' \
'--restart[Restart the daemon completely before running the command]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(state)
_arguments "${_arguments_options[@]}" : \
'-c+[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--config=[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--debug[Write out debug logs. (To read the logs, run \`ewwii logs\`)]' \
'--force-wayland[Force ewwii to use wayland. This is a no-op if ewwii was compiled without wayland support]' \
'--logs[Watch the log output after executing the command]' \
'--no-daemonize[Avoid daemonizing ewwii]' \
'--restart[Restart the daemon completely before running the command]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(list-windows)
_arguments "${_arguments_options[@]}" : \
'-c+[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--config=[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--debug[Write out debug logs. (To read the logs, run \`ewwii logs\`)]' \
'--force-wayland[Force ewwii to use wayland. This is a no-op if ewwii was compiled without wayland support]' \
'--logs[Watch the log output after executing the command]' \
'--no-daemonize[Avoid daemonizing ewwii]' \
'--restart[Restart the daemon completely before running the command]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(active-windows)
_arguments "${_arguments_options[@]}" : \
'-c+[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--config=[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--debug[Write out debug logs. (To read the logs, run \`ewwii logs\`)]' \
'--force-wayland[Force ewwii to use wayland. This is a no-op if ewwii was compiled without wayland support]' \
'--logs[Watch the log output after executing the command]' \
'--no-daemonize[Avoid daemonizing ewwii]' \
'--restart[Restart the daemon completely before running the command]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(debug)
_arguments "${_arguments_options[@]}" : \
'-c+[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--config=[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--debug[Write out debug logs. (To read the logs, run \`ewwii logs\`)]' \
'--force-wayland[Force ewwii to use wayland. This is a no-op if ewwii was compiled without wayland support]' \
'--logs[Watch the log output after executing the command]' \
'--no-daemonize[Avoid daemonizing ewwii]' \
'--restart[Restart the daemon completely before running the command]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(update)
_arguments "${_arguments_options[@]}" : \
'-i+[Inject variables while updating the UI]:INJECT_VARS: ' \
'--inject=[Inject variables while updating the UI]:INJECT_VARS: ' \
'-c+[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--config=[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'-p[Preserve the new updates. Only meaningful if used with inject]' \
'--preserve[Preserve the new updates. Only meaningful if used with inject]' \
'--debug[Write out debug logs. (To read the logs, run \`ewwii logs\`)]' \
'--force-wayland[Force ewwii to use wayland. This is a no-op if ewwii was compiled without wayland support]' \
'--logs[Watch the log output after executing the command]' \
'--no-daemonize[Avoid daemonizing ewwii]' \
'--restart[Restart the daemon completely before running the command]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(call-fns)
_arguments "${_arguments_options[@]}" : \
'-c+[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--config=[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--debug[Write out debug logs. (To read the logs, run \`ewwii logs\`)]' \
'--force-wayland[Force ewwii to use wayland. This is a no-op if ewwii was compiled without wayland support]' \
'--logs[Watch the log output after executing the command]' \
'--no-daemonize[Avoid daemonizing ewwii]' \
'--restart[Restart the daemon completely before running the command]' \
'-h[Print help]' \
'--help[Print help]' \
'*::calls -- Rhai functions to call. Format\: call-fns "fn_name1(args)" "fn_name2(args)":' \
&& ret=0
;;
(engine-override)
_arguments "${_arguments_options[@]}" : \
'-c+[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'--config=[override path to configuration directory (directory that contains ewwii.rhai and eww.(s)css)]:CONFIG:_files' \
'-p[Weather to print the current engine settings]' \
'--sprint[Weather to print the current engine settings]' \
'--debug[Write out debug logs. (To read the logs, run \`ewwii logs\`)]' \
'--force-wayland[Force ewwii to use wayland. This is a no-op if ewwii was compiled without wayland support]' \
'--logs[Watch the log output after executing the command]' \
'--no-daemonize[Avoid daemonizing ewwii]' \
'--restart[Restart the daemon completely before running the command]' \
'-h[Print help]' \
'--help[Print help]' \
':config_json -- Configuration in JSON format:' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_ewwii__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:ewwii-help-command-$line[1]:"
        case $line[1] in
            (shell-completions)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(daemon)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(logs)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(ping)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(inspector)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(open)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(close)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(reload)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(kill)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(close-all)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(state)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(list-windows)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(active-windows)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(debug)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(update)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(call-fns)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(engine-override)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
}

(( $+functions[_ewwii_commands] )) ||
_ewwii_commands() {
    local commands; commands=(
'shell-completions:Generate a shell completion script' \
'daemon:Start the Ewwii daemon' \
'logs:Print and watch the ewwii logs' \
'ping:Ping the ewwii server, checking if it is reachable' \
'inspector:Open the GTK debugger' \
'open:Open a window' \
'close:Close the given windows' \
'reload:Reload the configuration' \
'kill:Kill the ewwii daemon' \
'close-all:Close all windows, without killing the daemon' \
'state:Prints all the variables in the registery' \
'list-windows:List the names of active windows' \
'active-windows:Show active window IDs, formatted linewise \`<window_id>\: <window_name>\`' \
'debug:Print out the widget structure as seen by ewwii' \
'update:Update the widgets of a particular window. Poll/Listen variables will be cleared' \
'call-fns:Call rhai functions. (NOTE\: All poll/listen will default to their initial value)' \
'engine-override:Override the default runtime engine settings' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'ewwii commands' commands "$@"
}
(( $+functions[_ewwii__active-windows_commands] )) ||
_ewwii__active-windows_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii active-windows commands' commands "$@"
}
(( $+functions[_ewwii__call-fns_commands] )) ||
_ewwii__call-fns_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii call-fns commands' commands "$@"
}
(( $+functions[_ewwii__close_commands] )) ||
_ewwii__close_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii close commands' commands "$@"
}
(( $+functions[_ewwii__close-all_commands] )) ||
_ewwii__close-all_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii close-all commands' commands "$@"
}
(( $+functions[_ewwii__daemon_commands] )) ||
_ewwii__daemon_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii daemon commands' commands "$@"
}
(( $+functions[_ewwii__debug_commands] )) ||
_ewwii__debug_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii debug commands' commands "$@"
}
(( $+functions[_ewwii__engine-override_commands] )) ||
_ewwii__engine-override_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii engine-override commands' commands "$@"
}
(( $+functions[_ewwii__help_commands] )) ||
_ewwii__help_commands() {
    local commands; commands=(
'shell-completions:Generate a shell completion script' \
'daemon:Start the Ewwii daemon' \
'logs:Print and watch the ewwii logs' \
'ping:Ping the ewwii server, checking if it is reachable' \
'inspector:Open the GTK debugger' \
'open:Open a window' \
'close:Close the given windows' \
'reload:Reload the configuration' \
'kill:Kill the ewwii daemon' \
'close-all:Close all windows, without killing the daemon' \
'state:Prints all the variables in the registery' \
'list-windows:List the names of active windows' \
'active-windows:Show active window IDs, formatted linewise \`<window_id>\: <window_name>\`' \
'debug:Print out the widget structure as seen by ewwii' \
'update:Update the widgets of a particular window. Poll/Listen variables will be cleared' \
'call-fns:Call rhai functions. (NOTE\: All poll/listen will default to their initial value)' \
'engine-override:Override the default runtime engine settings' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'ewwii help commands' commands "$@"
}
(( $+functions[_ewwii__help__active-windows_commands] )) ||
_ewwii__help__active-windows_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii help active-windows commands' commands "$@"
}
(( $+functions[_ewwii__help__call-fns_commands] )) ||
_ewwii__help__call-fns_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii help call-fns commands' commands "$@"
}
(( $+functions[_ewwii__help__close_commands] )) ||
_ewwii__help__close_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii help close commands' commands "$@"
}
(( $+functions[_ewwii__help__close-all_commands] )) ||
_ewwii__help__close-all_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii help close-all commands' commands "$@"
}
(( $+functions[_ewwii__help__daemon_commands] )) ||
_ewwii__help__daemon_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii help daemon commands' commands "$@"
}
(( $+functions[_ewwii__help__debug_commands] )) ||
_ewwii__help__debug_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii help debug commands' commands "$@"
}
(( $+functions[_ewwii__help__engine-override_commands] )) ||
_ewwii__help__engine-override_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii help engine-override commands' commands "$@"
}
(( $+functions[_ewwii__help__help_commands] )) ||
_ewwii__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii help help commands' commands "$@"
}
(( $+functions[_ewwii__help__inspector_commands] )) ||
_ewwii__help__inspector_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii help inspector commands' commands "$@"
}
(( $+functions[_ewwii__help__kill_commands] )) ||
_ewwii__help__kill_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii help kill commands' commands "$@"
}
(( $+functions[_ewwii__help__list-windows_commands] )) ||
_ewwii__help__list-windows_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii help list-windows commands' commands "$@"
}
(( $+functions[_ewwii__help__logs_commands] )) ||
_ewwii__help__logs_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii help logs commands' commands "$@"
}
(( $+functions[_ewwii__help__open_commands] )) ||
_ewwii__help__open_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii help open commands' commands "$@"
}
(( $+functions[_ewwii__help__ping_commands] )) ||
_ewwii__help__ping_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii help ping commands' commands "$@"
}
(( $+functions[_ewwii__help__reload_commands] )) ||
_ewwii__help__reload_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii help reload commands' commands "$@"
}
(( $+functions[_ewwii__help__shell-completions_commands] )) ||
_ewwii__help__shell-completions_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii help shell-completions commands' commands "$@"
}
(( $+functions[_ewwii__help__state_commands] )) ||
_ewwii__help__state_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii help state commands' commands "$@"
}
(( $+functions[_ewwii__help__update_commands] )) ||
_ewwii__help__update_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii help update commands' commands "$@"
}
(( $+functions[_ewwii__inspector_commands] )) ||
_ewwii__inspector_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii inspector commands' commands "$@"
}
(( $+functions[_ewwii__kill_commands] )) ||
_ewwii__kill_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii kill commands' commands "$@"
}
(( $+functions[_ewwii__list-windows_commands] )) ||
_ewwii__list-windows_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii list-windows commands' commands "$@"
}
(( $+functions[_ewwii__logs_commands] )) ||
_ewwii__logs_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii logs commands' commands "$@"
}
(( $+functions[_ewwii__open_commands] )) ||
_ewwii__open_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii open commands' commands "$@"
}
(( $+functions[_ewwii__ping_commands] )) ||
_ewwii__ping_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii ping commands' commands "$@"
}
(( $+functions[_ewwii__reload_commands] )) ||
_ewwii__reload_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii reload commands' commands "$@"
}
(( $+functions[_ewwii__shell-completions_commands] )) ||
_ewwii__shell-completions_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii shell-completions commands' commands "$@"
}
(( $+functions[_ewwii__state_commands] )) ||
_ewwii__state_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii state commands' commands "$@"
}
(( $+functions[_ewwii__update_commands] )) ||
_ewwii__update_commands() {
    local commands; commands=()
    _describe -t commands 'ewwii update commands' commands "$@"
}

if [ "$funcstack[1]" = "_ewwii" ]; then
    _ewwii "$@"
else
    compdef _ewwii ewwii
fi
