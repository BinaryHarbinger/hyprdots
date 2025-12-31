
# Path to your Oh My Zsh installation.
ZSH_DISABLE_COMPFIX='true' 
export ZSH="$HOME/.oh-my-zsh"

# ZSH theme
ZSH_THEME="sunaku"

# === Plugins ===
plugins=(git 
    zsh-autosuggestions 
    extract 
    sudo 
    zsh-syntax-highlighting 
    command-not-found 
    rust)

source $ZSH/oh-my-zsh.sh
# ===============



# === Variables ===
ZSH_CONFIG="$HOME/.config/zsh/"
# =================



# === Sources ===
source $ZSH_CONFIG/functions.zsh


# === Custom Paths ===
export PATH="$HOME/Dotfiles/bin:$PATH"

# User configuration

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

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
        neofetch
    fi
fi

# export PATH="$HOME/.eiipm/bin:$PATH"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
