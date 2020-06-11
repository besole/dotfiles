#!/usr/bin/env sh

CURRENT=$( brightnessctl get )
MAX=$(brightnessctl max )
PERCENTAGE=$((100 * CURRENT / MAX))
echo " ${PERCENTAGE}%"
