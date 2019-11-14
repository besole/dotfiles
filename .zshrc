# Source executable files from userconfig directory
ZSH_USER_CONFIG=$HOME/.config/zsh
for file in $ZSH_USER_CONFIG/*.zsh; do
  [[ -x "$file" ]] && source $file
done;

