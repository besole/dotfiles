#!/usr/bin/env sh
if ! ip link | grep -q 'wlp2s0: .* state UP '; then
  echo "󱛅 "
  echo "󱛅 "
  echo "${color_warning}"
else
  echo "󱚽 "
  echo "󱚽 "
fi
