#!/usr/bin/env sh

BAT=/sys/class/power_supply/BAT0

CAPACITY=$(cat "${BAT}/capacity")

if [ "$( cat "${BAT}/status" )" = "Charging" ]; then
  ICON=""
elif [ "${CAPACITY}" -ge 80 ]; then
  ICON=""
elif [ "${CAPACITY}" -ge 60 ]; then
  ICON=""
elif [ "${CAPACITY}" -ge 40 ]; then
  ICON=""
elif [ "${CAPACITY}" -ge 20 ]; then
  ICON=""
else
  ICON=""
	color="#ff0000"
fi

echo "${ICON}  ${CAPACITY}%"
echo "${ICON}  ${CAPACITY}%"
if [ -n "${color}" ]; then echo "${color}"; fi
