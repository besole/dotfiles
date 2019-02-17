#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

FILES=(
	".bash_aliases"
	".bash_profile"
	".bashrc"
	".xinitrc"
	".Xresources"
	".xserverrc"

	".config/compton.conf"
	".config/i3/"
	".config/nitrogen/"
)

DIRS=(
	".config"
)

for dir in "${DIRS[@]}"; do
	mkdir -p "${HOME}/${dir}"
done

shopt -s extglob
for file in "${FILES[@]}"; do
	file="${file%%+(/)}"
	if [[ -d "${HOME}/${file}" ]] || [[ -f "${HOME}/${file}" ]]; then
		rm -r "${HOME}/${file}"
	fi

	if [[ "${1}" == "copy" ]]; then
		cp -r "${SCRIPTDIR}/${file}" "${HOME}/${file}"
	else 
		ln -s "${SCRIPTDIR}/${file}" "${HOME}/${file}"
	fi
done
