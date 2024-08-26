if [ -f "${HOME}/.Xresources" ]; then
   xrdb -merge "${HOME}/.Xresources"
fi
