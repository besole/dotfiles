# Colors
alias ls="ls --color=auto"
alias diff="diff --color=auto"
alias grep="grep --color=auto"

# Aliases
alias feh="/usr/bin/feh --scale-down"
alias xinit="echo 'Please use startx!'"
alias startx="/usr/bin/startx '${XDG_CONFIG_HOME}/X11/xinitrc' -- '${XDG_CONFIG_HOME}/X11/xserverrc' 2>&1 | tee /tmp/xinit-${USER}-${XDG_VTNR}"
alias sway="sway-run.sh &> '${HOME}/.local/share/sway/log-${USER}-${XDG_VTNR}'"
alias scrcpy="/usr/bin/scrcpy --disable-screensaver --turn-screen-off --stay-awake"
