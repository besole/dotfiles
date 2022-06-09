#!/usr/bin/env sh

VMROOT=/mnt/nvme/virt/qemu
VMNAME=$(basename "$0")

if ! [ -x "${VMROOT}/${VMNAME}/run.sh" ]; then
	echo "could not find vm start script for vm '${VMNAME}'"
	exit 1
fi

cd "${VMROOT}/${VMNAME}"
./run.sh

if [ -f ./lg-spice.ini ]; then
	screen -d -m -- looking-glass-client app:configFile=./lg-spice.ini
elif [ -S sockets/spice.sock ]; then
	screen -d -m -- remote-viewer spice+unix://sockets/spice.sock
fi
