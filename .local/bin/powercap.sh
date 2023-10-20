#!/bin/sh

if [ "${EUID}" != 0 ] && sudo -l "${0}" >/dev/null; then
	exec sudo "${0}" "${@}"
elif [ "${EUID}" != 0 ]; then
	exit 1
fi

echo 15000000 | tee /sys/class/powercap/intel-rapl:0/constraint_*_power_limit_uw >/dev/null
#echo 1500000  | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq >/dev/null

echo "Power Limits:"
cat /sys/class/powercap/intel-rapl:0/constraint_*_power_limit_uw

echo
echo "Frequency Limits:"
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
