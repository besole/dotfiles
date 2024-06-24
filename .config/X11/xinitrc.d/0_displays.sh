if xrandr | grep -q '^DVI-I-1-1 connected '; then
  # Tripple Monitors at Home Office
  xrandr \
    --output DP-1      --mode 2560x1440 --pos 0x0      --primary \
    --output eDP-1     --mode 1920x1080 --pos 480x1440 \
    --output DVI-I-1-1 --mode 3440x1440 --pos 2560x0
else
  # Dual Monitors at Work
  xrandr \
    --output DP-1  --mode 5120x2160 --pos 0x0      --scale 0.75 --filter bilinear --primary \
    --output eDP-1 --mode 1920x1080 --pos 960x1620 --scale 1
fi
