#!/bin/sh

# Source System Configuration Files
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Set Look and Feel
[ -f $HOME/.Xresources ] && xrdb -merge $HOME/.Xresources

# Import systemd display environment
systemctl --user import-environment DISPLAY

# Run the Environment
numlockx &
picom &
nitrogen --restore &
nextcloud &
exec /usr/bin/i3
