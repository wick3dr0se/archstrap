#!/bin/bash
# usage.sh

_usage() {
cat <<-USAGE
 usage | archstrap <newroot> <packages>
-----------------------------------------
 -c,--hostcache | install host packages to newroot
 -k, --no-keyring | don't copy host pacman keyring to newroot
 -m, --no-mirrors | don't copy host mirrorlist to newroot
USAGE
exit
}

get_flags() { # bcuz fuck getopts
for i in $inputFlags ; do
  [[ $i =~ ^-[a-z] ]] && {
    while read -rn1 flag ; do
      flags+=" -${flag#-}"
    done <<< $i
  }
  flags=${flags:-$i}

  for i in ${flags//-} ; do
    case $i in
      h|u|help|usage) _usage ;; # get usage
      #c|hostcache) hostCache=1 ;; # add host packages
      k|no-keyring) hostKeyring=0 ;; # don't copy host pacman keyring
      m|no-mirrors) hostMirrors=0 ;; # don't copy host mirrorlist
      *) _out 'Bad argument' x ;;
    esac
  done
done
}
