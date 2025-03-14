#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

NEEDED_DIRS=(
	".config"
	".local"
	".local/share"
)
LINKS=(
	".zshenv"

	".config/dunst"
	".config/feh"
	".config/i3"
	".config/i3blocks"
	".config/kitty"
	".config/nitrogen"
	".config/picom"
	".config/powerlevel10k"
	".config/rofi"
	".config/sway"
	".config/vim"
	".config/X11"
	".config/xfce4"
	".config/zsh"

	".local/bin"
	".local/share/fonts"
)

for dir in "${NEEDED_DIRS[@]}"; do
	mkdir -p "${HOME}/${dir}"
done

for file in "${LINKS[@]}"; do
	if [[ -d "${HOME}/${file}" ]] || [[ -f "${HOME}/${file}" ]]; then
		rm -r "${HOME}/${file}"
	fi

	ln -snf "${SCRIPTDIR}/${file}" "${HOME}/${file}"
done
