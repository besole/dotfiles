# Random Slideshow with optional path argument
randslide(){
	dir=${1:-$(pwd)}
	(
		cd $dir
		ls -A | shuf | sxiv -a -b -p -S10 -sf -
	)
}

# Search Bitwarden and grep for needed data
bwsearch(){
	if ! bw status | grep -q '"status":"unlocked"'; then
		export BW_SESSION="$(bw unlock --raw)"
	fi
	bw --pretty list items --search "$@" | grep -E '"name"|"username"|"password"'
}
