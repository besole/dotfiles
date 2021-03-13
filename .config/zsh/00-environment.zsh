# Prompt & tab name
export PS1="%(?..%F{red}%?%f| )%F{green}%n@%m%f:%~ %# "
preexec () {print -Pn "\e]0;${3}\a"}
precmd () {print -Pn "\e]0;%n@%m:%~\a"}

# Environment
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

# History
export HISTSIZE=1000
export HISTFILE="${XDG_DATA_HOME}/zsh-history"
export SAVEHIST=1000000

# Tools
export EDITOR="vim"
export PAGER="less"
export LESS="-R"

# Fix a few bad apps
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME}/android"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java"
export VIMINIT=":source ${XDG_CONFIG_HOME}/vim/vimrc"
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
export XSERVERRC="${XDG_CONFIG_HOME}/X11/xserverrc"
