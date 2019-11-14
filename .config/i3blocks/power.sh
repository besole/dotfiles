#!/usr/bin/env bash

BAT=/sys/class/power_supply/BAT0

CAPACITY=$(cat "${BAT}/capacity")

if [[ $( cat "${BAT}/status" ) = "Charging" ]]; then
  ICON=""
elif [[ ${CAPACITY} -ge 70 ]]; then
  ICON=""
elif [[ ${CAPACITY} -ge 40 ]]; then
  ICON=""
elif [[ ${CAPACITY} -ge 10 ]]; then
  ICON=""
else
  ICON=""
fi

echo "${ICON} ${CAPACITY}%"
