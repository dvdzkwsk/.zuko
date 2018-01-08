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
