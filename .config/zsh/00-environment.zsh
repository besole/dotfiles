# Prompt
if [ -n "${SSH_CLIENT}" ]; then
	export PS1="%(?..%F{red}%?%f| )%F{green}%n%f@%F{red}%m%f:%~ %# "
else
	export PS1="%(?..%F{red}%?%f| )%F{green}%n%f@%F{green}%m%f:%~ %# "
fi

# Tab Names
preexec () {print -Pn "\e]0;${3}\a"}
precmd () {print -Pn "\e]0;%n@%m:%~\a"}

# Autcomplete Spaces
ZLE_REMOVE_SUFFIX_CHARS=

# Do not count special characters as words
WORDCHARS=

# Environment
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

# History
export HISTFILE="${XDG_DATA_HOME}/zsh-history"
export HISTSIZE=1000000
export SAVEHIST=1000000
setopt share_history

# Tools
export EDITOR="vim"
export PAGER="less"
export LESS="-FRS --shift 5"

# Fix a few bad apps
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME}/android"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java"
export VIMINIT=":source ${XDG_CONFIG_HOME}/vim/vimrc"
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
export XSERVERRC="${XDG_CONFIG_HOME}/X11/xserverrc"
