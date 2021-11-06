#!/usr/bin/env bash

USERBUILD=${USERBUILD:-${HOME}/userbuild}
REPOSITORIES=$( find -L "${USERBUILD}" -type d -name ".git" -not -path "*/src/*" -exec dirname {} \; )

while read -u 9 repo; do
	if [ -n "$(git -C "${repo}" clean -d -x -ff --dry-run)" ]; then
		echo "${repo}"
		git -C "${repo}" clean -d -x -ff --dry-run | sed 's/^/	/'
		read -p "	Remove files [y|N]? " answer
		if [ "${answer}" = "y" ] || [ "${answer}" = "Y" ]; then
			echo ""
			git -C "${repo}" clean -d -x -ff
		fi
		echo ""
	fi
done 9<<< "${REPOSITORIES}"
