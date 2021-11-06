#!/bin/sh

if [ -n "$DISPLAY" ]; then
	xrandr \
		--output Virtual-1 --mode 1920x1080 --primary \
		--output Virtual-2 --mode 1920x1080 --right-of Virtual-1 \
		--output Virtual-3 --off
fi
