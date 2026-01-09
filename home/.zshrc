
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

source "$ZSH_CONFIG/config.zsh"

# export PATH="$HOME/.eiipm/bin:$PATH"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
