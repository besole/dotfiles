#!/usr/bin/env sh

slideshow () {(
	dir=${1:-$(pwd)}
	cd "${dir}"
	ls -A | sxiv -a -b -p -S10 -sf -
)}
_slideshow(){
	_arguments '1: :_path_files'
}
compdef _slideshow slideshow
