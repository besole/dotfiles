# elevate to root if possible
if [ "${EUID}" != 0 ] && sudo -l "${0}" > /dev/null; then
	exec sudo "${0}" "${@}"
elif [ "${EUID}" != 0 ]; then
	exit 1
fi

# loop over all devices
for device in "${@}"; do

	# add local domain if necessary
	if [ ${#device} -lt 12 ]; then device="0000:${device}"; fi

	# get current driver
	driverpath=$( readlink -f "/sys/bus/pci/devices/${device}/driver" )
	driver=$( basename "${driverpath}" )

	# check curent driver
	if [ "${driver}" != "vfio-pci" ]; then

		# unbind from current driver
		if [ -e "${driverpath}/unbind" ]; then
			echo "${device}" > "${driverpath}/unbind"
			echo "Device '${device}' unbound from '${driver}'"
		fi

		# set new driver
		echo "vfio-pci" > "/sys/bus/pci/devices/${device}/driver_override"
		echo "${device}" > "/sys/bus/pci/drivers/vfio-pci/bind"
		echo "Device '${device}' bound   to   'vfio-pci'"

	fi
done
