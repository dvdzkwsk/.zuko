# vim: foldmethod=marker

# Main Settings -------------------------------------------- {{{
set -o vi                # Allow vi-like movements in the terminal
ulimit -n 2000           # Increase allowed open file limit
eval "$(hub alias -s)"   # Enable git extensions
#}}}

# Functions ------------------------------------------------ {{{
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
#}}}

# Aliases -------------------------------------------------- {{{
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
alias size="stat -f%z"
alias weather="curl wttr.in"

# [B]ash
alias brc="vi ~/.bash_profile"
alias brcs="source ~/.bash_profile"

# [E]macs
alias ec="emacsclient -c -n"
alias ed="emacs --daemon"
alias ekd="emacsclient -e '(kill-emacs)'"

# [G]it
alias ga="git add -p"
alias gall="git add --all"
alias gm="git merge"
alias gdf="git diff"
alias gls="git branch -l"
alias gco="git checkout"
alias gcp="git cherry-pick"
alias gup="git fetch; git pull"
alias gc="git commit"
alias gca="git commit --amend"
alias gcs="git commit --amend --no-edit"
alias gcm="git commit -m"
alias gpo="git push origin"
alias gcl="git clone"
alias gst="git status"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias grb="git rebase"
alias grbi="git rebase -i"
alias gpr="git pull-request"
alias gr="git rebase"
alias grc="git rebase --continue"
alias gbd="git branch -D"

# [H]ttp
alias http="python -m SimpleHTTPServer"

# [L]ist
alias ll="ls -la -Gfh"
alias ls="ls -Gfh"

# [V]im
alias vi="nvim"
alias vrc="vi ~/.vimrc"

# [R]anger
alias r="ranger"
#}}}

# Node ----------------------------------------------------- {{{
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                    # Load nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Load nvm bash_completion

NODE_VERSION=$(which node)
NODE_BIN_PATH=${NODE_VERSION%bin/node}
NODE_MODULES_PATH="${NODE_BIN_PATH}lib/node_modules"
export NODE_PATH="$NODE_PATH:$NODE_MODULES_PATH"
#}}}

# Externals ------------------------------------------------ {{{
source ~/.bash_prompt
source ~/.bash_private
#}}}
