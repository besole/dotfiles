#!/bin/sh

if [ -n "$DISPLAY" ]; then
	xrandr \
		--output Virtual-1 --primary --mode 1920x1080 \
		--output Virtual-2 --off \
		--output Virtual-3 --off
fi
