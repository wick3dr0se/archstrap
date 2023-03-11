#!/bin/bash
# usage.sh

_usage() {
cat <<-USAGE
 usage | archstrap <newroot> <packages>
-----------------------------------------
 -c,--cache | install host packages to newroot
 -k, --keyring | copy host pacman keyring to newroot
 -m, --mirrors | copy host mirrorlist to newroot
USAGE
exit
}

inputFlags="${*##[a-z]*}"

get_args() { # bcuz fuck getopts
local arg args flag flags
for flag in $inputFlags ; do
  if [[ $flag =~ ^-[a-z] ]] ; then
    while read -rn1 arg ; do
      args+="$arg "
    done <<< "${flag##-}"
  else
    args+="${flag##--} "
  fi

  for arg in $args ; do
    case $arg in
      h|u|help|usage) _usage ;;
      #c|hostcache) hostCache=1 ;;
      k|keyring) hostKeyring=1 ;;
      m|mirrors) hostMirrors=1 ;;
      *) _out 'Bad argument' x ;;
    esac
  done
done
}
