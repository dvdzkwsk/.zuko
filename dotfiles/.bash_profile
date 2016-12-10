eval "$(rbenv init -)"
RBENV_VERSION=2.3.1

###### Terminal Customization
export PS1="λ \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

###### Git
# Use https://github.com/github/hub
eval "$(hub alias -s)"

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

###### Node (based on an nvm install via Homebrew)
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

NODE_VERSION=$(which node)
NODE_BIN_PATH=${NODE_VERSION%bin/node}
NODE_MODULES_PATH="${NODE_BIN_PATH}lib/node_modules"
export NODE_PATH="$NODE_PATH:$NODE_MODULES_PATH"

## Increase allowed open file limit
ulimit -n 2000

###### functions
function mcd {
  mkdir -p $1
  cd $1
}

function gcb() {
  git rev-parse --abbrev-ref HEAD
}

function grb() {
  git rebase $1
}

function grbi() {
  git rebase -i $1
}

function gsu() {
  git branch --set-upstream-to=$1
}

function gmb() {
  if  [ "$#" = 1 ]; then
    git rebase -i $(git merge-base $(gcb) $1)
  else
    git rebase -i $(git merge-base $1 $2)
  fi
}

function mbr() {
  git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative $1..$2
}

# ref: https://gist.github.com/dergachev/4627207
function mkgif() {
  ffmpeg -i $1 -s 600x400 -pix_fmt rgb24 -r 15 -f gif - | gifsicle --optimize=3 --delay=8 > $2
}

###### aliases
alias v="nvim"
alias c="ec"
alias ec="emacsclient -c -n"
alias ed="emacs --daemon"
alias ekd="emacsclient -e '(kill-emacs)'"
alias vrc="c ~/.vimrc"
alias brc="c ~/.bash_profile"
alias brcs="source ~/.bash_profile"
alias erc="c ~/.spacemacs"
alias ll="ls -la -Gfh"
alias ls="ls -Gfh"
alias http="python -m SimpleHTTPServer"
alias size="stat -f%z"

## git-specific
alias ga="git add"
alias gm="git merge"
alias gdf="git diff"
alias gls="git branch -l"
alias gco="git checkout"
alias gup="git fetch; git pull"
alias gcm="git commit -m "
alias gall="git add --all"
alias gpo="git push origin "
alias gcl="git clone "
alias gst="git status"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gpr="git pull-request "
alias grc="git rebase --continue"
alias gbd="git branch -D "

####### External Configuration
source ~/.bash_private

# Setting PATH for Python 3.5
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH
