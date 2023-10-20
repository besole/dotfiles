#!/bin/sh

# vars
KERNELNAME="${1}"
KERNELVERSION=$( cut -d'-' -f1 <<< "${KERNELNAME}" )
GITTAG="v${KERNELVERSION%.0}"

USERBUILD="${USERBUILD:-${HOME}/userbuild}"
GITDIR="${USERBUILD}/kernels/git-source"
PATCHDIR="${USERBUILD}/kernels/patches"
ARCHDIR="${USERBUILD}/kernels/build"
BUILDDIR="${ARCHDIR}/${KERNELNAME}"
BOOTDIR="/boot"


CONFIGNAME=$( cut -d'-' -f2- <<< "${KERNELNAME}" )
CONFIGFILE="${USERBUILD}/kernels/configs/${CONFIGNAME}"

if [ -n "${KERNELNAME}" ]; then
	########
	# build checks

	# check config existence
	if [ -z "${CONFIGNAME}" ] || ! [ -r "${CONFIGFILE}" ]; then
		echo "configfile '${CONFIGNAME}' not found!"
		exit 1
	fi
	# check version syntax
	if ! [[ "${KERNELVERSION}" =~ [0-9]+\.[0-9]+\.[0-9]+ ]]; then
		echo "wrong version syntax"
		exit 1
	fi
	# check existing tree
	if [ -d "${BUILDDIR}" ] && [ "${2}" != "--force" ]; then
		echo "'${BUILDDIR}' already exists!"
		echo "Use '--force' option to  build"
		exit 1
	fi

	# check if git tag exists
	if ! sudo -u besole -- git -C "${GITDIR}" rev-parse "${GITTAG}" ; then
		echo "Could not find git tag '${GITTAG}'"
		exit 1
	fi
	
	########
	# elevate to root if possible
	if [ "$EUID" != 0 ] && sudo -l "$0" >/dev/null; then
		kernel-remove.sh "${KERNELNAME}"
		exec sudo MAKEOPTS="${MAKEOPTS}" USERBUILD="${USERBUILD}" "$0" "$@"
	elif [ "$EUID" != 0 ]; then
		echo "Cannot run as root!"
		exit 1
	fi
	
	########
	# execute user space commands
	
	# start build notification
	echo "Starting build for kernel '${KERNELNAME}' in '${BUILDDIR}'"
	
	# export git dir
	echo "exporting src tree"
	sudo -u besole -- mkdir -p "${BUILDDIR}"
	sudo -u besole -- git -C "${GITDIR}" archive "${GITTAG}" | sudo -u besole -- tar -xf - -C "${BUILDDIR}" || exit 2
	
	# patches
	echo "patching"
	for PATCH in "${PATCHDIR}"/*.patch; do
		echo "    patching ${PATCH}"
		sudo -u besole -- patch -d "${BUILDDIR}" -i "${PATCH}" -p1 || exit 3
	done
	
	# copy old config and generate new
	echo "copying config"
	sudo -u besole -- cp --dereference "${CONFIGFILE}" "${BUILDDIR}/.config"
	echo "generating new config"
	sudo -u besole -- make -C "${BUILDDIR}" oldconfig || exit 4
	
	# build
	echo "building kernel"
	sudo -u besole -- make "${MAKEOPTS:--j`nproc`}" -C "${BUILDDIR}" || exit 5
	
	##########
	# execute root commands
	
	# install modules
	echo "installing modules"
	make ${MAKEOPTS:--j`nproc`} -C "${BUILDDIR}" modules_install || exit 6
	
	# dkms modules
	if command -v dkms >/dev/null; then
		dkms autoinstall -k "${KERNELNAME}"
	fi
	
	echo "installing bzImage and initramfs"
	cp "${BUILDDIR}/arch/x86_64/boot/bzImage" "${BOOTDIR}/vmlinuz-linux-${KERNELNAME}" || exit 8
	mkinitcpio -k "${KERNELNAME}" -g "${BOOTDIR}/initramfs-linux-$KERNELNAME.img" || exit 9
	
	# generate boot entry
	echo "generating boot entries"
	grub-mkconfig -o "${BOOTDIR}/grub/grub.cfg" || exit 10

	##########
	# execute cleanup commands
	#sudo -u besole -- rm -r "${BUILDDIR}" || exit 11
	
fi

# currently installed kernel:
curKernel=$(uname -r)
echo "---------------------------"
echo "Currently installed kernel:"
for dir in /lib/modules/*; do
	kernel=$(basename "$dir")
	if [ "$kernel" = "$curKernel" ]; then
		echo -n '> '
	fi
	echo $kernel
done
