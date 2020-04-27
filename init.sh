#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

NEEDED_DIRS=(
	".config"
)
LINKS=(
	".xinitrc"
	".Xresources"
	".xserverrc"
	".zshrc"

	".config/i3"
	".config/i3blocks"
	".config/nitrogen"
	".config/picom"
	".config/sway"
	".config/vim"
	".config/xfce4"
	".config/zsh"
)

for dir in "${NEEDED_DIRS[@]}"; do
	mkdir -p "${HOME}/${dir}"
done

for file in "${LINKS[@]}"; do
	if [[ -d "${HOME}/${file}" ]] || [[ -f "${HOME}/${file}" ]]; then
		rm -r "${HOME}/${file}"
	fi

	ln -s "${SCRIPTDIR}/${file}" "${HOME}/${file}"
done
