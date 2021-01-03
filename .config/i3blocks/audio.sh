#!/usr/bin/env sh

getDefaultAttribute(){
	SINK="$(getDefaultIndex)"
	pactl list sinks | awk "/Sink #${SINK}/,/^$/" | grep -Ei "^[[:blank:]]+${1}:" | cut -d " " -f 2-
}

isDefaultMuted(){
	if [ "$(getDefaultAttribute 'mute')" = "no" ]; then
		return 1
	else
		return 0
	fi
}
getDefaultIndex(){
	DEFAULTNAME="$(pactl info | awk -F ": " '/^Default Sink: / {print $2}' )"
	pactl list sinks short | grep "${DEFAULTNAME}" | awk '{print $1}'
}
getDefaultVolume(){
	getDefaultAttribute 'volume' | grep -Eo "[[:digit:]]+%" | head -n1 | grep -Eo "[[:digit:]]+"
}
getNextCardIndex(){
	SINK="$(getDefaultIndex)"
	nextCardIndex="$(pactl list sinks short | grep -EA1 "^${SINK}[[:blank:]]" | grep -Ev "^${SINK}[[:blank:]]" | awk '{print $1}')"
	if [ -z "$nextCardIndex" ]; then
		nextCardIndex="$(pactl list sinks short | head -n1 | awk '{print $1}')"
	fi
	echo "$nextCardIndex"
}
getSoundIcon(){
	cardType=$(getDefaultAttribute 'name')
	icon=""
	if echo "$cardType" | grep -q 'Jabra'; then
		icon=""
	fi
	echo "$icon"
}
moveStreamsToDefault(){
	pactl list sink-inputs short | awk '{print $1}' | while read stream; do
		pactl move-sink-input "${stream}" @DEFAULT_SINK@
	done
}
setNextDefault(){
	pactl set-default-sink "$(getNextCardIndex)"
	moveStreamsToDefault
}

# check if pulseaudio is running
pactl info >/dev/null 2>/dev/null
if [ $? -ne 0 ]; then
	echo ""
	echo ""
	echo "${color_error}"
	return 1
fi

# switch to next card
if [ -n "$button" ]; then
	setNextDefault
fi

# Show notification
title="Volume - $(getSoundIcon)"
if isDefaultMuted; then
	title="${title} - Muted"
fi
currentVolume=$(getDefaultVolume)
info="$(printf "%3d" ${currentVolume})% "
for i in $(seq 0 25); do
	if [ "${currentVolume}" -lt $(( i * 4 )) ] || [ "${currentVolume}" -eq "0" ]; then
		info="${info}░"
	else
		info="${info}█"
	fi
done

paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
notify-send -u critical -h string:x-canonical-private-synchronous:besole-volume "${title}" "${info}"

# Write output
if [ -n "${SHOWICON}" ]; then
	echo "$(getSoundIcon)"
	if isDefaultMuted; then
		echo "$(getSoundIcon)"
		echo "${color_inactive}"
	fi
fi
