#!/bin/bash

FULL_RESOLUTION="$(xrandr | grep -Eo 'current [0-9]+ x [0-9]+' | awk '{print $2 "x" $4}')"
TEMPFILE="/tmp/X11-VT${XDG_VTNR}-${USER}-lockscreen-${FULL_RESOLUTION}.png"

if ! [ -r "${TEMPFILE}" ]; then
	# build image for all connected monitors
	while read line; do
		RESOLUTION="$(grep -Eo '[0-9]+x[0-9]+' <<< ${line})"
		GEOMETRY="$(grep -Eo '\+[0-9]+\+[0-9]+' <<< ${line})"
		IMGSTRING="${IMGSTRING} ( ${HOME}/.config/nitrogen/current -resize ${RESOLUTION}^ -gravity center -extent ${RESOLUTION} ) -gravity NorthWest -geometry ${GEOMETRY} -composite"
	done <<< "$(xrandr | grep -Eo '[0-9]+x[0-9]+[+-][0-9]+[+-][0-9]+')"

	# create lock image
	convert -size ${FULL_RESOLUTION} xc:transparent ${IMGSTRING} PNG32:"${TEMPFILE}"
fi

#put monitor to sleep
(sleep 3s && xset dpms force off) &
# mute sound
pactl set-sink-mute @DEFAULT_SINK@ toggle &
pactl set-source-mute @DEFAULT_SOURCE@ toggle &
# lock the screen
convert "${TEMPFILE}" rgb:- | i3lock --nofork --raw ${FULL_RESOLUTION}:rgb --image /dev/stdin || rm -f "${TEMPFILE}"

# i3lock needs "--nofork" to have cleanup commands!
# unmute sound
pactl set-sink-mute @DEFAULT_SINK@ toggle
pactl set-source-mute @DEFAULT_SOURCE@ toggle
