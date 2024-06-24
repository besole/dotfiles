#!/bin/sh

MOUNTPOINT=/mnt/z

if mount | grep -q " ${MOUNTPOINT} "; then
  echo "Userdrive already mounted. Check ${MOUNTPOINT}" >&2
  exit 1
fi

sudo mount -t cifs -o username=bsolenthaler,domain=sasag.intra,uid=$(id -u),gid=$(id -g) //dc01.sasag.intra/data "${MOUNTPOINT}"
