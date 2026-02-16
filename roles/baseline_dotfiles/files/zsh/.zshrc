# ~/.zshrc  — bashrc-equivalent

# Source global definitions
if [[ -f /etc/zshrc ]]; then
  source /etc/zshrc
fi

# User specific environment (PATH)
if [[ ":$PATH:" != *":$HOME/.local/bin:$HOME/bin:"* ]]; then
  export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

# Optional: disable systemd pager
# export SYSTEMD_PAGER=

# User specific aliases and functions (snippet directory)
if [[ -d ~/.zshrc.d ]]; then
  for rc in ~/.zshrc.d/*; do
    [[ -f "$rc" ]] && source "$rc"
  done
  unset rc
fi

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY

# Basic QoL
setopt AUTO_CD
setopt CORRECT
setopt INTERACTIVE_COMMENTS

# Prompt
autoload -Uz promptinit && promptinit
prompt adam1

# Aliases
alias ll='ls -lah'
alias v='nvim'
alias gs='git status'

# fastfetch
command -v fastfetch >/dev/null && fastfetch
