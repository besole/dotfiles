#!/bin/sh

if [ -n "$DISPLAY" ]; then
	xrandr \
		--output Virtual-1 --mode 1920x1080 --left-of Virtual-2 \
		--output Virtual-2 --mode 1920x1080 --primary \
		--output Virtual-3 --mode 1920x1080 --right-of Virtual-2
fi
