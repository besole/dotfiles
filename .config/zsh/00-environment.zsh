# Environment
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
# Fix a few bad apps
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME}/android"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java"
export VIMINIT=":source ${XDG_CONFIG_HOME}/vim/vimrc"
export XAUTHORITY="${XDG_DATA_HOME}/Xauthority"

# Tools
export EDITOR="vim"
export PAGER="less"
export LESS="-FRX"

# Aliases
alias pwsafe="pwsafe -g \"${XDG_CONFIG_HOME}\"/pwsafe"
alias feh="feh --scale-down"
