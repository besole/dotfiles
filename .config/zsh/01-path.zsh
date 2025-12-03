#!/usr/bin/env zsh

append_path () {
	case ":$PATH:" in
		*:"$1":*) ;;
		*) PATH="${PATH:+$PATH:}$1" ;;
	esac
}

prepend_path () {
	case ":$PATH:" in
		*:"$1":*) ;;
		*) PATH="$1${PATH:+:$PATH}";;
	esac
}

prepend_path "${HOME}/.local/bin"

unset -f append_path
unset -f prepend_path
