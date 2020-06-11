#!/usr/bin/env sh

TEMP="-not found-"
for typeFile in /sys/class/thermal/thermal_zone*/type; do
	typeName=$( cat "$typeFile" )
	if [[ $typeName == "x86_pkg_temp" ]]; then
		TEMP=$( cat "$( dirname "$typeFile" )/temp" )
		TEMP=$(( TEMP / 1000 ))
	fi
done

echo " $TEMP°C"
echo " $TEMP°C"
if [[ $TEMP == "-not found-" ]] || [[ $TEMP -gt 70 ]]; then echo "$color_error"; fi
