#!/usr/bin/env bash

function main {
#	info="$(getSoundIcon) $(getCurrentVolume) ($(getCurrentName))"
	info="$(getSoundIcon) $(getCurrentVolume)"
	echo "$(getPango "$info")"
}
function getPango {
	if defaultIsMuted; then
		echo "<span foreground=\"#444444\">$1</span>"
	else
		echo "<span>$1</span>"
	fi
}
function defaultIsMuted {
        currentIndex=$(getCurrentIndex)
        if [[ $(pactl list sinks | sed -n "/Sink #${currentIndex}$/,/^$/p" | grep -Pio '(?<=Mute: ).*') != "no" ]]
	then
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
		grep -Pi '^\s*volume:' | 
		grep -Po "[0-9]+%" | 
		head -n1
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
	icon=
	if [[ $cardType == "Jabra Link 370" ]]; then
		icon=
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


if ! [[ -z $BLOCK_BUTTON ]]; then
	setNextDefault
fi

echo $(main)
