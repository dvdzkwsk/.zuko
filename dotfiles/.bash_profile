# vim: foldmethod=marker foldmarker=(((,)))
set -o vi

# Main Settings (((
ulimit -n 2000 # Increase allowed open file limit
eval "$(hub alias -s)"
#)))

# Functions (((
function pathadd() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}

function pathdedupe() {
  PATH=`printf %s "$PATH" | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}'`
}

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
#)))

# Path (((
#)))

# Node (((
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

NODE_VERSION=$(which node)
NODE_BIN_PATH=${NODE_VERSION%bin/node}
NODE_MODULES_PATH="${NODE_BIN_PATH}lib/node_modules"
export NODE_PATH="$NODE_PATH:$NODE_MODULES_PATH"
#)))

# Aliases (((
alias vi="nvim"
alias ec="emacsclient -c -n"
alias ed="emacs --daemon"
alias ekd="emacsclient -e '(kill-emacs)'"
alias vrc="vi ~/.vimrc"
alias brc="vi ~/.bash_profile"
alias brcs="source ~/.bash_profile"
alias erc="vi ~/.spacemacs"
alias ll="ls -la -Gfh"
alias ls="ls -Gfh"
alias http="python -m SimpleHTTPServer"
alias size="stat -f%z"
alias ga="git add"
alias gm="git merge"
alias gdf="git diff"
alias gls="git branch -l"
alias gco="git checkout"
alias gcp="git cherry-pick"
alias gup="git fetch; git pull"
alias gcm="git commit -m "
alias gad="git add -p"
alias gall="git add --all"
alias gpo="git push origin "
alias gcl="git clone "
alias gst="git status"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gpr="git pull-request "
alias gr="git rebase "
alias grc="git rebase --continue"
alias gbd="git branch -D "
alias ghide="git update-index --assume-unchanged "
alias ghidels="git ls-files -v | grep -e \"^[hsmrck]\""
alias weather="curl wttr.in"
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
alias path='echo -e ${PATH//:/\\n}'
#)))

# Externals (((
source ~/.bash_prompt
source ~/.bash_private
#)))
