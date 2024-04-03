autoload -U +X compinit
compinit -d "${XDG_CACHE_HOME}/zcompdump-${ZSH_VERSION}"

autoload -U +X bashcompinit
bashcompinit
