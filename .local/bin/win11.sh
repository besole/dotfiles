#!/bin/sh

VMDIR=/home/bsolenthaler/virt/win11

cd "${VMDIR}"
sh ./qemu.sh
remote-viewer spice+unix://./sockets/spice.sock >/dev/null 2>/dev/null
