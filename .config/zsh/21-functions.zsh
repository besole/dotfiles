if [ -d "${ZDOTDIR}/functions" ]; then

	for file in "${ZDOTDIR}/functions/"*.zsh; do
		[ -x "${file}" ] && source "${file}"
	done

fi
