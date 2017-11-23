#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
cyan=`tput setaf 6`
reset=`tput sgr0`

OK="${green}✔${reset}"
ERROR="${red}✖${reset}"

function log {
  echo "${cyan}> ${1}${reset}"
}
function column {
  str+="$1$(printf " %0.s" {1..20})"
  echo "${str:0:20}"
}
function command_exists {
  type "$1" &> /dev/null
}

echo
log "Symlinking ${PWD}/dotfiles/* to ${HOME}"
echo
for file in dotfiles/*; do
  file=${file##*/}
  dest="${HOME}/.${file}"
  info=""
  status=""
  if [ -L $dest ]; then
    status=$ERROR
    info="(Symlink already exists)"
  elif [ -f $dest ]; then
    status=$ERROR
    info="(File already exists)"
  else
    status=$OK
    ln -s ${PWD}/dotfiles/${file} ${dest}
  fi
  echo "${status}  $(column $file) --> $(column "~/.${file}") ${info}"
done

function install_dependencies {
  log "Installing missing dependencies: $1"
  brew install $1
}

echo
log "Checking dependencies..."
echo
declare -a deps=(
  "jq"
  "nvm"
  "postgres"
  "rg"
  "tree"
  "watchman"
  "yarn"
)
declare -a missing_deps=()
for dep in "${deps[@]}"
do
  if command_exists $dep ; then
    echo "${OK}  $(column $dep) (Already installed)"
  else
    missing_deps+=("$dep")
  fi
done

echo
if [ ${#missing_deps[@]} -eq 0 ]; then
  echo "No missing dependencies!"
else
  echo "Missing dependencies: ${cyan}${missing_deps}${reset}"
  read -p "Install these dependencies (Y/n)? " -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo
    echo
    install_dependencies ${missing_deps}
  fi
fi
