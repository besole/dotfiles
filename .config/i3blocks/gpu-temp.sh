#!/usr/bin/env sh

if lsmod | grep -i 'nvidia' &>/dev/null; then
	# Nvidia
	TEMP=$(nvidia-settings -t -q '[gpu:0]/gpucoretemp')
else
	# Nouveau
	TEMP=$(cat /sys/bus/pci/devices/0000:01:00.0/hwmon/*/temp1_input)
	TEMP=$((TEMP / 1000))
fi

# Output
echo " ${TEMP}°C"
