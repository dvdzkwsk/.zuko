# vim: foldmethod=marker

# Main Settings -------------------------------------------- {{{
set -o vi                    # Allow vi-like commands in bash
ulimit -n 2000               # Increase allowed open file limit
eval "$(hub alias -s)"       # Enable git extensions
export VISUAL=nvim           # Global default editor
export EDITOR="$VISUAL"      # ibid
fpath=(/usr/local/share/zsh-completions $fpath)
#}}}

# Functions ------------------------------------------------ {{{
function pathadd() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}

function mcd {
  mkdir -p $1
  cd $1
}
#}}}

# Node ----------------------------------------------------- {{{
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                    # Load nvm

NODE_VERSION=$(which node)
NODE_BIN_PATH=${NODE_VERSION%bin/node}
NODE_MODULES_PATH="${NODE_BIN_PATH}lib/node_modules"
export NODE_PATH="$NODE_PATH:$NODE_MODULES_PATH"
#}}}

# Externals ------------------------------------------------ {{{
source ~/.bash_aliases
source ~/.bash_private
source ~/.zsh_aliases
source ~/.zsh_prompt
#}}}
