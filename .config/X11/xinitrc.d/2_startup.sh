eval $( /usr/bin/gnome-keyring-daemon --start )
export SSH_AUTH_SOCK

spice-vdagent
numlockx &
unclutter --timeout 2 --jitter 10 --ignore-scrolling &
feh --no-fehbg --bg-fill "${HOME}/.config/feh/current" &
dunst &
