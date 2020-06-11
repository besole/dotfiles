#!/usr/bin/env sh

# Nouveau
#TEMP=$(cat /sys/bus/pci/devices/0000:01:00.0/hwmon/*/temp1_input)
#TEMP=$((TEMP / 1000))

# Nvidia
TEMP=$(nvidia-settings -t -q '[gpu:0]/gpucoretemp')

# Output
echo " ${TEMP}°C"
