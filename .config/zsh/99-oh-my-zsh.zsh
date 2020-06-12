# Configuration
ZSH="/usr/share/oh-my-zsh"
ZSH_CACHE_DIR="${HOME}/.cache/oh-my-zsh"
ZSH_CUSTOM="${XDG_DATA_HOME}/oh-my-zsh"
ZSH_THEME="ys"
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=( colored-man-pages virtualenv )

# oh my zsh entry point
source "${ZSH}/oh-my-zsh.sh"

# Compinit
compinit -d "${XDG_CACHE_HOME}/zcompdump-${ZSH_VERSION}"
