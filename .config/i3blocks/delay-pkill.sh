#!/bin/bash

script_name=$( readlink -f "${0}")
for pid in $(pidof -x $script_name); do
	if [ $pid != $$ ]; then
		kill -9 $pid
	fi
done

sleep 0.05s
pkill -RTMIN+1 i3blocks
