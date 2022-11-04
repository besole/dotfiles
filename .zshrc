# Source executable files from userconfig directory

if [ -n "${ZSH_USER_CONFIG}" ]; then return; fi

ZSH_USER_CONFIG=$HOME/.config/zsh
for file in $ZSH_USER_CONFIG/*.zsh; do
  [[ -x "$file" ]] && source $file
done
unset file

echo "ZSH Env Setup"
