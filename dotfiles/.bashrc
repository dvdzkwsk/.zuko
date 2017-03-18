# vim: foldmethod=marker foldmarker=(((,)))
set -o vi

if [ "$DEBUG" == 'true' ]; then
  set -x
else
  set +x
fi

# Terminal Prompt (((
eval "$(hub alias -s)"
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

prompt_git() {
	local s='';
	local branchName='';

	# Check if the current directory is in a Git repository.
	if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

		# check if the current directory is in .git before running git checks
		if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

			# Ensure the index is up to date.
			git update-index --really-refresh -q &>/dev/null;

			# Check for uncommitted changes in the index.
			if ! $(git diff --quiet --ignore-submodules --cached); then
				s+='+';
			fi;

			# Check for unstaged changes.
			if ! $(git diff-files --quiet --ignore-submodules --); then
				s+='!';
			fi;

			# Check for untracked files.
			if [ -n "$(git ls-files --others --exclude-standard)" ]; then
				s+='?';
			fi;

			# Check for stashed files.
			if $(git rev-parse --verify refs/stash &>/dev/null); then
				s+='$';
			fi;

		fi;

		# Get the short symbolic ref.
		# If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
		# Otherwise, just give up.
		branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
			git rev-parse --short HEAD 2> /dev/null || \
			echo '(unknown)')";

		[ -n "${s}" ] && s=" [${s}]";

		echo -e "${1}${branchName}${2}${s}";
	else
		return;
	fi;
}

if tput setaf 1 &> /dev/null; then
	tput sgr0; # reset colors
	bold=$(tput bold);
	reset=$(tput sgr0);
	# Solarized colors, taken from http://git.io/solarized-colors.
	black=$(tput setaf 0);
	blue=$(tput setaf 33);
	cyan=$(tput setaf 37);
	green=$(tput setaf 64);
	orange=$(tput setaf 166);
	purple=$(tput setaf 125);
	red=$(tput setaf 124);
	violet=$(tput setaf 61);
	white=$(tput setaf 15);
	yellow=$(tput setaf 136);
else
	bold='';
	reset="\e[0m";
	black="\e[1;30m";
	blue="\e[1;34m";
	cyan="\e[1;36m";
	green="\e[1;32m";
	orange="\e[1;33m";
	purple="\e[1;35m";
	red="\e[1;31m";
	violet="\e[1;35m";
	white="\e[1;37m";
	yellow="\e[1;33m";
fi;

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
	userStyle="${red}";
else
	userStyle="${orange}";
fi;

# Set the terminal title and prompt.
PS1="\[\033]0;\W\007\]";               # working directory base name
PS1+="\[${bold}\]\n";                  # newline
PS1+="\[${userStyle}\]λ";              # username
PS1+="\[${white}\] at \[${green}\]\w"; # working directory full path

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
	hostStyle="${bold}${red}";
  PS1+="\[${white}\] in \[${hostStyle}\]\h"; # host
else
	hostStyle="${yellow}";
fi;
PS1+="\$(prompt_git \"\[${white}\] on \[${violet}\]\" \"\[${blue}\]\")"; # Git repository details
PS1+="\n";
PS1+="\[${white}\]\$ \[${reset}\]"; # `$` (and reset color)
export PS1;

PS2="\[${yellow}\]→ \[${reset}\]";
export PS2;
# export PS1="λ \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
#)))

# File System (((
ulimit -n 2000 # Increase allowed open file limit
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
#)))

# Node (((
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

NODE_VERSION=$(which node)
NODE_BIN_PATH=${NODE_VERSION%bin/node}
NODE_MODULES_PATH="${NODE_BIN_PATH}lib/node_modules"
export NODE_PATH="$NODE_PATH:$NODE_MODULES_PATH"
#)))

# Freaking Ruby (((
eval "$(rbenv init -)"
RBENV_VERSION=2.3.1
#)))

# Path (((
pathadd "/Library/Frameworks/Python.framework/Versions/3.5/bin"
pathadd "/Applications/Racket v6.5/bin"
#)))

# Aliases (((
alias vi="nvim"
alias ec="emacsclient -c -n"
alias ed="emacs --daemon"
alias ekd="emacsclient -e '(kill-emacs)'"
alias vrc="vi ~/.vimrc"
alias brc="vi ~/.bashrc"
alias brcs="source ~/.bashrc"
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
#)))

# Externals (((
source ~/.bash_private
#)))
