#!/bin/bash
# helpers.sh

_out() {
  local char code
  code="${2:-2}"
  if (( code == 1 )) ; then
    char='X'
  elif (( code == 3 )) ; then
    char='–'
  fi

  printf '[\e[3%sm%s\e[0m]: %s\n' \
    "$code" "${char:-✔}" "$1"

  (( code == 1 )) && exit 1
  code=''
}

get_reply() {
  printf '[\e[32my\e[0mes/\e[31mN\e[0mo]: '

  read -r
  REPLY="${REPLY:-N}"

  [[ ${REPLY,,} =~ y(es)? ]] && :
}

mkmod() {
  local one
  one="$1" ; shift

  mkdir -p "$@" && chmod "$one" "$@"
}


del() {
  local dest file files filepath

  if [[ $1 == -d ]] ; then
    dest="$2" ; shift 2
    files="${*}"

    for file in $files ; do
      filepath="$dest/$file"
      rm -fr "$filepath"
    done
  else
    rm -fr "$@"
  fi
}

untar() {
  local file dest

  file="${1##*/}"
  dest="${1%%/*}"

  tar -xf "$file" -C "$dest" 2>/dev/null
  del "$file"
}
