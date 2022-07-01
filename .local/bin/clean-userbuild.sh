#!/usr/bin/env bash

main(){
	USERBUILD=${USERBUILD:-${HOME}/userbuild}
	REPOSITORIES=$( find -L "${USERBUILD}" -type d -name ".git" -not -path "*/src/*" -exec dirname {} \; )

	while read -r repo; do

		if isDotfile "${repo}"; then continue; fi
		if isClean   "${repo}"; then continue; fi

		cleanRepo "${repo}"
		echo ""

	done <<< "${REPOSITORIES}"
}

cleanRepo(){
	echo "${1} - files to clean:"
	git -C "${1}" clean -d -x -ff --dry-run | sed 's/^/  /'

	echo -n 'Delete files? [y|N] '
	read -r answer < /dev/tty
	if [ "${answer}" = 'y' ] || [ "${answer}" = "Y" ]; then
		git -C "${1}" clean -d -x -ff -q
		echo "Done."
	else
		echo "Skipping."
	fi
}

isDotfile(){
	if echo "${1}" | grep -F -q "git/dotfiles"; then
		return 0
	else
		return 1
	fi
}

isClean(){
	if [ -z "$(git -C "${1}" clean -d -x -ff --dry-run)" ]; then
		return 0
	else
		return 1
	fi
}

main
