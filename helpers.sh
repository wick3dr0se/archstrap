#!/bin/bash
# helpers.sh

_out() {
  local code msg

  if [[ $2 == e ]] ; then
    code=3
    msg='Error'
  elif [[ $2 == x ]] ; then
    code=1
    msg='Fatal'
  fi

  printf '[\e[1;3%sm%s\e[0m]: %s\n' \
    "${code:-2}" "${msg:-Pass}" "$1"

  [[ $msg == Fatal ]] && exit 1
  code='' ; msg=''
}

get_reply() {
  printf '[\e[32my\e[0mes/\e[31mN\e[0mo]: '
  
  local reply

  read -r reply
  reply="${reply:-N}"

  [[ ${reply,,} == y || ${reply,,} == yes ]] &&
    return 0 ||
    return 1
}

mkmod() {
  local one="$1" ; shift

  mkdir -p "$@" && chmod "$one" "$@"
}


del() {
  local dest file filepath

  if [[ $1 == -d ]] ; then
    dest="$2" ; shift 2
    file="${*}"

    for i in $file ; do
      filepath="$dest/$i"
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
