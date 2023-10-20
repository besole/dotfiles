#!/usr/bin/env sh
echo "直"
echo "直"
if ! ip link | grep -q 'wlp2s0: .* state UP '; then
	echo "${color_inactive}"
fi
