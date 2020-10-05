#!/usr/bin/env sh

randslide(){(
	dir=${1:-$(pwd)}
	cd "${dir}"
	ls -A | shuf | sxiv -a -b -p -S10 -sf -
)}
_randslide(){
	_arguments '1: :_path_files'
}
compdef _randslide randslide
