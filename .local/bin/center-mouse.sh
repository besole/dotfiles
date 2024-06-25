#!/bin/bash

if ! ps -e | grep -i 'xorg' &>/dev/null; then
	# WAYLAND
	exit 0
else

	# XORG
	ACTIVEWINDOW=$( xdotool getwindowfocus )
	GEOMETRY=$( xdotool getwindowgeometry "${ACTIVEWINDOW}" )
	GEOMETRY=$( echo "${GEOMETRY}" | grep -oP '[0-9]+x[0-9]+' )

	IFS='x' read WWIDTH WHEIGHT <<< $( echo "${GEOMETRY}" )

	if [[ $WWIDTH -le 1 ]] || [[ $WHEIGHT -le 1 ]]; then
		exit 0;
	fi

	HALFWIDTH=$(( WWIDTH / 2 ))
	HALFHEIGHT=$(( WHEIGHT / 2 ))

	xdotool mousemove --window "${ACTIVEWINDOW}" "${HALFWIDTH}" "${HALFHEIGHT}"
fi
