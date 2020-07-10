#!/usr/bin/env sh

getDefaultAttribute(){
	pacmd list-sinks | grep -E "\* index:|^[[:blank:]]+${1}:" | grep -A1 '* index' | tail -n1 | cut -d " " -f 2-
}

isDefaultMuted(){
	if [ "$(getDefaultAttribute 'muted')" = "no" ]; then
		return 1
	else
		return 0
	fi
}
getDefaultIndex(){
        pacmd list-sinks | grep '* index:' | grep -Eo '[0-9]+'
}
getDefaultVolume(){
	getDefaultAttribute 'volume' | grep -Eo "[0-9]+%" | head -n1 | grep -Eo "[0-9]+"
}
getNextCardIndex(){
	nextCardIndex=$(pacmd list-sinks | grep 'index:' | grep -A1 '* index:' | tail -n1 | grep -Eo "[0-9]+")
	if [ "$nextCardIndex" = "$(getDefaultIndex)" ]; then
		nextCardIndex=$(pacmd list-sinks | grep 'index:' | head -n1 | grep -Eo "[0-9]+")
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
	pacmd list-sink-inputs | grep -E 'index:' | grep -Eo '[0-9]+' | while read -r stream; do
		pacmd move-sink-input "$stream" @DEFAULT_SINK@
	done
}
setNextDefault(){
	pacmd set-default-sink "$(getNextCardIndex)"
	moveStreamsToDefault
}


# Switch output
if [ -n "$button" ]; then
	setNextDefault
fi

# Write output
if [ -n "${SHOWICON}" ]; then
	echo "$(getSoundIcon)"
	if isDefaultMuted; then
		echo "${color_inactive}"
		echo "${color_inactive}"
	fi
fi

# Show notification
title="Volume - $(getSoundIcon)"
if isDefaultMuted; then
	title="${title} - Muted"
fi
currentVolume=$(getDefaultVolume)
info="${currentVolume}% "
for i in $(seq 1 25); do
	if [ $(( i * 4 )) -le "${currentVolume}" ]; then
		info="${info}█"
	fi
done
paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
notify-send -u critical -h string:x-canonical-private-synchronous:besole-volume "${title}" "${info}"
