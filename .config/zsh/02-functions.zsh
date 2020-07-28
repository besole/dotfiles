randslide(){
	dir=${1:-$(pwd)}
	(
		cd $dir
		ls -A | shuf | sxiv -a -b -p -S10 -sf -
	)
}

# Search Bitwarden and grep for needed data
bw-search(){
	bw --pretty list items --search "$@" | grep -E '"name"|"username"|"password"'
}
