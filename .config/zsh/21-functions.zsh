for file in "${ZSH_USER_CONFIG}/functions/"*.zsh; do
	[ -x "${file}" ] && source "${file}"
done
