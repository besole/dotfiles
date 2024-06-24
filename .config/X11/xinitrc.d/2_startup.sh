eval $( /usr/bin/gnome-keyring-daemon --start )
export SSH_AUTH_SOCK

numlockx &
unclutter --timeout 2 --jitter 10 --ignore-scrolling &
feh --no-fehbg --bg-max --image-bg '#05202b' "${HOME}/.config/feh/current"
dunst &
linphone --iconified &
sasagcallmonitor2 &

xset s off
xset -dpms
