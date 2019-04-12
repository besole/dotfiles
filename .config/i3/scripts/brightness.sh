#!/bin/bash

function round {
  echo $1 | awk '{print int($1 + 0.5)}'
}
function getDevice {
  CURRENT=$( xbacklight -get )
  echo " $( round $CURRENT )"
}
function incBrightness {
  CURRENT=$( xbacklight -get )
  CURRENT=$( round $CURRENT )
  NEW=$(( CURRENT + 5 ))
  xbacklight -set ${NEW}
}
function decBrightness {
  CURRENT=$( xbacklight -get )
  CURRENT=$( round $CURRENT )
  NEW=$(( CURRENT - 5 ))
  NEW=$( round $NEW )
  xbacklight -set ${NEW}
}

[[ "$1" == "+" ]] && incBrightness
[[ "$1" == "-" ]] && decBrightness
getDevice
