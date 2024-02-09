# Source p10k library
[ -f ~/.config/powerlevel10k/lib/powerlevel10k.zsh-theme ] && source ~/.config/powerlevel10k/lib/powerlevel10k.zsh-theme

# P10K Config
if [ "$TERM" = "linux" ]; then
  # Linux Console
  [ -f ~/.config/powerlevel10k/p10k-config-console.zsh ] && source ~/.config/powerlevel10k/p10k-config-console.zsh
else
  # Graphical
  [ -f ~/.config/powerlevel10k/p10k-config.zsh ] && source ~/.config/powerlevel10k/p10k-config.zsh
fi
