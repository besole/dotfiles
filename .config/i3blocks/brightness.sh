#!/bin/bash

function currentBrightnessPercentage {
  CURRENT=$( brightnessctl get )
  MAX=$(brightnessctl max )
  PERCENTAGE=$((100 * CURRENT / MAX))
  echo ${PERCENTAGE}
}
function getDevice {
  CURRENT=$( currentBrightnessPercentage )
  echo " ${CURRENT}%"
}
function incBrightness {
  CURRENT=$( currentBrightnessPercentage )
  NEW=$(( CURRENT + 5 ))
  sudo brightnessctl set ${NEW}%
}
function decBrightness {
  CURRENT=$( currentBrightnessPercentage )
  NEW=$(( CURRENT - 5 ))
  sudo brightnessctl set ${NEW}%
}

[[ "$1" == "+" ]] && incBrightness
[[ "$1" == "-" ]] && decBrightness
getDevice

