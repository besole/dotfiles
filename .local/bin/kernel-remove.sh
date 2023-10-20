#!/bin/sh

# vars
KERNELNAME="${1}"
USERBUILD="${USERBUILD:-"${HOME}/userbuild"}"
BUILDDIR="${USERBUILD}/kernels/build/${KERNELNAME}"
BOOTDIR=/boot

if [ -n "${KERNELNAME}" ]; then
	# check if kernel is running
	if [ $( uname -r ) == "${KERNELNAME}" ]; then
		echo "currently running kernel '${KERNELNAME}', not removing!"
		exit 1
	fi
	
	# elevate to root if possible
	if [ "$EUID" != 0 ] && sudo -l "$0" >/dev/null; then
		exec sudo USERBUILD="${USERBUILD}" "$0" "$@"
	elif [ "$EUID" != 0 ]; then
		echo "Cannot execute script as root!"
		exit 1
	fi
	
	echo "removing kernel '${KERNELNAME}'"

	# build dir
	rm -rf "${BUILDDIR}"
	
	# dkms modules
	if command -v dkms >/dev/null; then
		while read line; do
			MOD="$( cut -d ',' -f 1 <<< "${line}" )"
			if [ -n "$MOD" ]; then
				dkms remove "${MOD}" -k "${KERNELNAME}"
			fi
		done <<< $(dkms status -k "${KERNELNAME}" | grep "installed")
	fi
	
	# delete modules
	rm -rf "/lib/modules/${KERNELNAME}"
	
	# removing vmlinuz and initramfs
	rm -f "${BOOTDIR}/vmlinuz-linux-${KERNELNAME}"
	rm -f "${BOOTDIR}/initramfs-linux-${KERNELNAME}.img"
	
	# generate boot entry
	grub-mkconfig -o "${BOOTDIR}/grub/grub.cfg"
fi

# currently installed kernel:
curKernel=$(uname -r)
echo "---------------------------"
echo "Currently installed kernel:"
for dir in /lib/modules/*; do
	kernel=$(basename "$dir")
	if [ "$kernel" = "${curKernel}" ]; then
		echo -n '> '
	fi
	echo $kernel
done

