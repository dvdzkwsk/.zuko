##### Node

# NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# If you're using NVM, you have to add the version-specific node_modules
# folder to your path to prevent issues with globally installed packages.
NODE_BIN_PATH=${NODE_VERSION%bin/node}
NODE_MODULES_PATH="${NODE_BIN_PATH}lib/node_modules"
export NODE_PATH="$NODE_PATH:$NODE_MODULES_PATH"

# increase allowed resource count (lower number can break npm install).
ulimit -n 2000

###### Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

###### Terminal Customization
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="zuko \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

###### Aliases
alias ll="ls -la -Gfh"
alias ls="ls -Gfh
