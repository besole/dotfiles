# generate random 32 (or per argument) alphanumeric string (upper and lowercase)
random-string () {
	cat /dev/urandom |\
		tr -dc 'a-zA-Z0-9' |\
		fold -w "${1:-32}" | \
		head -n 1
}
