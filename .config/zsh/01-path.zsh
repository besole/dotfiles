#!/usr/bin/evn zsh

append_path () {
	case ":$PATH:" in
		*:"$1"*) ;;
		*) PATH="${PATH:+$PATH:}$1" ;;
	esac
}

append_path "${HOME}/.local/bin"

unset -f append_path
