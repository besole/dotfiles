# Aliases
alias feh="/usr/bin/feh --scale-down"
alias xinit="echo 'Please use startx!'"
alias startx="/usr/bin/startx '${XDG_CONFIG_HOME}/X11/xinitrc' -- '${XDG_CONFIG_HOME}/X11/xserverrc' ':${XDG_VTNR}' 'vt${XDG_VTNR}' &> /tmp/xinit-${USER}-${XDG_VTNR}"
alias sway="sway-run.sh &> '${HOME}/.local/share/sway/log-${USER}-${XDG_VTNR}'"
