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

FORCE_INSTALL=false

while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    -f|--force)
    FORCE_INSTALL=true
    shift # past flag
    ;;
    *)    # unknown option
    shift # past flag
    ;;
esac
done

echo
log "Symlinking ${PWD}/dotfiles/* to ${HOME}"
echo
for file in dotfiles/*; do
  file=${file##*/}
  dest="${HOME}/.${file}"
  info=""
  status=""
  if [ -L $dest ]; then
    if [ "$FORCE_INSTALL" = true ]; then
      status=$OK
      rm ${dest}
      ln -s ${PWD}/dotfiles/${file} ${dest}
      info="(Overwrote existing symlink)"
    else
      status=$ERROR
      info="(Symlink already exists)"
    fi
  elif [ -f $dest ]; then
    if [ "$FORCE_INSTALL" = true ]; then
      status=$OK
      rm ${dest}
      ln -s ${PWD}/dotfiles/${file} ${dest}
      info="(Overwrote existing file)"
    else
      status=$ERROR
      info="(File already exists)"
    fi
  else
    status=$OK
    ln -s ${PWD}/dotfiles/${file} ${dest}
  fi
  echo "${status}  $(column $file) --> $(column "~/.${file}") ${info}"
done
