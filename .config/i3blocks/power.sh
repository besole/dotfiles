#!/usr/bin/env bash

BAT=/sys/class/power_supply/BAT0

CAPACITY=$(cat "${BAT}/capacity")

if [[ $( cat "${BAT}/status" ) = "Charging" ]]; then
  ICON=""
elif [[ ${CAPACITY} -ge 65 ]]; then
  ICON=""
elif [[ ${CAPACITY} -ge 40 ]]; then
  ICON=""
elif [[ ${CAPACITY} -ge 15 ]]; then
  ICON=""
else
  ICON=""
	color="#ff0000"
fi

echo "${ICON} ${CAPACITY}%"
echo "${ICON} ${CAPACITY}%"
if ! [[ -z "${color}" ]]; then echo "${color}"; fi
