#!/bin/sh

VMPATH="$HOME/virt/win11"

echo stop | socat UNIX-CONNECT:"${VMPATH}/sockets/monitor.sock" STDIO
