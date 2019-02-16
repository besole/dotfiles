# Aliases
if [[ -f ~/.bash_aliases ]]; then
	source ~/.bash_aliases
fi

# Prompt
GREEN="\[$(tput setaf 2)\]"
BLUE="\[$(tput setaf 4)\]"
RESET="\[$(tput sgr0)\]"
PS1="[${GREEN}\u${RESET}@${BLUE}\h${RESET} \W]\$ "
