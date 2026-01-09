# === Custom Options ===
setopt dot_glob
setopt extended_glob
# ======================



# === Custom Prompt ===

# Define the prompt
PROMPT='%{$fg_bold[blue]%}$(git_prompt_status)%{$reset_color%}$(git_prompt_info)%{$fg[$user_color]%}%(?.%{$fg_bold[green]%}%~%{$reset_color%}.%{$fg_bold[red]%}%~%{$reset_color%})%(!.#.➤) '
# =====================



# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi

THEME_VAR="binaryharbinger"

# Only run in interactive shells
if [[ $- == *i* ]]; then
    if [[ $THEME_VAR == "windoes" ]]; then
        distro=$(grep '^NAME=' /etc/os-release | cut -d '=' -f2 | tr -d '"')
        echo "$distro [Version 10.0.19045.4529]"
        echo "(c) GNU/Linux Corporation. All freedom preserved"
        echo ""
    else
        if ! [[ -n "$NVIM" ]]; then
            neofetch
        fi
    fi
fi
