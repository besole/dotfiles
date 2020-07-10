randslide(){
	dir=${1:-$(pwd)}
	(
		cd $dir
		ls -A | shuf | sxiv -a -b -p -S10 -sf -
	)
}
