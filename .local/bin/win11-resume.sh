#!/bin/sh

VMPATH="$HOME/virt/win11"

# Build set-time command
GA_SETTIME=$( cat <<EOF
{
  "execute": "guest-set-time",
  "arguments": {
    "time": $( date '+%s%N' )
  }
}
EOF
)

# Resume VM and set time
echo 'cont'          | socat UNIX-CONNECT:"${VMPATH}/sockets/monitor.sock"    STDIO
echo "${GA_SETTIME}" | socat UNIX-CONNECT:"${VMPATH}/sockets/guestagent.sock" STDIO
