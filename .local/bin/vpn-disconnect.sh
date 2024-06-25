#!/bin/sh

# Check if vpn is running
pgrep openconnect >/dev/null || exit 0

# Disconnect from vpn
sudo pkill -SIGINT openconnect
