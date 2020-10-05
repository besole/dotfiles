bwsearch(){
	if ! bw status | grep -q '"status":"unlocked"'; then
		export BW_SESSION="$(bw unlock --raw)"
	fi
	bw --pretty list items --search "$@" | grep -E '"name"|"username"|"password"|"uri"'
}
