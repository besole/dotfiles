#!/bin/sh

VMDIR="${HOME}/virt/win11"

${VMDIR}/run.sh
remote-viewer "spice+unix://${VMDIR}/sockets/spice.sock" >/dev/null 2>/dev/null
