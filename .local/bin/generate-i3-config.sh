#!/bin/sh

if [ -d "$HOME/.config/i3/conf.d" ]; then
  cat "$HOME/.config/i3/conf.d/"*.conf > "$HOME/.config/i3/config"
fi
