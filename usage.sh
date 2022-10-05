#!/bin/bash
# usage.sh

_usage() {
cat <<-USAGE
 usage | archstrap <newroot> <packages>
-----------------------------------------
 -c,--hostcache | install host packages to newroot
 -k, --keyring | copy host pacman keyring to newroot
 -m, --mirrors | copy host mirrorlist to newroot
USAGE
exit
}

inputFlags="${*##[a-z]*}"

get_flags() { # bcuz fuck getopts
  for flag in $inputFlags ; do
    if [[ $flag =~ ^-[a-z] ]] ; then
      while read -rn1 flag ; do
        flags+="$flag "
      done <<< "${flag##-}"
    else
      flags+="${flag##--} "
    fi
  done

  for i in $flags ; do
    case $i in
      h|u|help|usage) _usage ;;
      debug) set -x ;;
      #c|hostcache) hostCache=1 ;;
      k|no-keyring) hostKeyring=1 ;;
      m|no-mirrors) hostMirrors=1 ;;
      *) _out 'Bad argument' x ;;
    esac
  done
}
