# Aliases
alias feh="feh --scale-down"
alias xinit="echo 'Please use startx!'"
alias startx="startx '${XDG_CONFIG_HOME}/X11/xinitrc' -- '${XDG_CONFIG_HOME}/X11/xserverrc' &> /tmp/xinit-${USER}-${XDG_VTNR}"
alias picom="picom --experimental-backends"
alias bw-search="bw --pretty list items --search"
