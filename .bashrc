# User Specific binaries
PATH=$HOME/.local/bin:$PATH

# Aliases
if [[ -f ~/.bash_aliases ]]; then
	source ~/.bash_aliases
fi

# Linux Virtual Console Colors
if [ "$TERM" = "linux" ]; then
    _SEDCMD='s/.*\*.color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p'
    for i in $(sed -n "$_SEDCMD" $HOME/.Xresources | awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}'); do
        echo -en "$i"
    done
    clear
fi

# Prompt
GREEN="\[$(tput setaf 2)\]"
BLUE="\[$(tput setaf 4)\]"
RESET="\[$(tput sgr0)\]"
PS1="[${GREEN}\u${RESET}@${BLUE}\h${RESET} \W]\$ "
