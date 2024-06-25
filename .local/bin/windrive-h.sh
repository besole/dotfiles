#!/bin/sh

MOUNTPOINT=/mnt/h

if mount | grep -q " ${MOUNTPOINT} "; then
  echo "Userdrive already mounted. Check ${MOUNTPOINT}" >&2
  exit 1
fi

sudo mount -t cifs -o username=bsolenthaler,domain=sasag.intra,uid=$(id -u),gid=$(id -g) //file02.sasag.intra/userdrives/bsolenthaler "${MOUNTPOINT}"
