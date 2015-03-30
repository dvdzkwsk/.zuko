###### Terminal Customization
export PS1="zuko \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

###### Git
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

###### Node
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

NODE_VERSION=$(which node)
NODE_BIN_PATH=${NODE_VERSION%bin/node}
NODE_MODULES_PATH="${NODE_BIN_PATH}lib/node_modules"
export NODE_PATH="$NODE_PATH:$NODE_MODULES_PATH"

## Increase allowed open file limit
ulimit -n 2000

###### Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

###### functions
function mcd {
  mkdir -p $1
  cd $1
}

function gitgb {
  git clone git@bitbucket.org:gbase/$1
  cd $1
}

function npmgb {
  npm install $2 gstv-$1
}

###### aliases
alias ll="ls -la -Gfh"
alias ls="ls -Gfh"
alias npmclean="npm cache clean; rm ~/.npm/*.lock"

## git-specific
alias gco="git checkout"
alias gup="git fetch; git pull"
alias gcm="git commit -m "
alias gall="git add --all"
alias gcma="git add --all; git commit -m "
alias gpo="git push origin "
alias gcl="git clone "
alias gst="git status"
