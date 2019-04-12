#!/bin/sh

[ -f $HOME/.Xresources ] && xrdb -merge $HOME/.Xresources

xcompmgr &
exec /usr/bin/i3
