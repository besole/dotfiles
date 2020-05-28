#!/usr/bin/env sh

function defaultIsMuted {
	currentIndex=$(getCurrentIndex)
	if [[ $(pactl list sinks | sed -n "/Sink #${currentIndex}$/,/^$/p" | grep -Pio '(?<=Mute: ).*') != "no" ]]; then
		return 0
	else
		return 1
	fi
}
function getCurrentIndex { 
        pactl list sinks | grep "Name: $(pactl info | grep -Pio '(?<=^Default Sink: ).*')" -B2 | head -n1 | grep -Po '[0-9]+'
}
function getCurrentName {
        currentIndex=$(getCurrentIndex)
        pactl list sinks | sed -n "/Sink #${currentIndex}$/,/^$/p" | grep -Pio '(?<=alsa.card_name = ").*(?=")'
}
function getCurrentVolume {
	currentIndex=$(getCurrentIndex)
	pactl list sinks | 
    sed -n "/Sink #${currentIndex}$/,/^$/p" | 
		egrep -i '^\s*volume:' | 
		egrep -o "[0-9]+%" | 
		head -n1 |
		egrep -o "[0-9]+"
}
function getNextCardIndex {
	currentIndex=$(getCurrentIndex)
	((currentIndex++))

	if ! pactl list sinks | grep -Piq "^Sink #${currentIndex}$"; then
		currentIndex=0
	fi
	echo $currentIndex
}
function getSoundIcon {
	cardType=$(getCurrentName)
	icon=
	if [[ $cardType =~ "Jabra" ]]; then
		icon=
	fi
	echo $icon
}
function moveStreamsToDefault {
	pactl list sink-inputs | grep -Poi '(?<=Sink Input #)[0-9]+' | while read -r stream; do
		pactl move-sink-input $stream @DEFAULT_SINK@
	done
}
function setNextDefault {
	nextCard=$(getNextCardIndex)
	pactl set-default-sink $nextCard
	moveStreamsToDefault
}


title="Volume - $(getSoundIcon)"
if defaultIsMuted; then
	title="${title} - Muted"
fi

currentVolume=$(getCurrentVolume)
info="${currentVolume}% "
for i in $(seq 1 25); do
	if [[ $(( i * 4 )) -le ${currentVolume} ]]; then
		info="${info}█"
	fi
done
#info="${info}]"

paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
notify-send -u critical -h string:x-canonical-private-synchronous:besole-pulse-volume "${title}" "${info}"
