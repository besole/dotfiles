#!/bin/sh

VMPATH="$HOME/virt/win11"

echo 'cont'                         | socat UNIX-CONNECT:"${VMPATH}/sockets/monitor.sock" STDIO
sleep 2s
echo '{"execute":"guest-set-time"}' | socat UNIX-CONNECT:"${VMPATH}/sockets/guestagent.sock" STDIO
