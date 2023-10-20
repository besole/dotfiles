# Source executable files from userconfig directory
for file in ${ZDOTDIR}/*.zsh; do
  if [ -x "$file" ]; then
		source $file
	fi
done
unset file
