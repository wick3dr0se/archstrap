#!/bin/bash
# usage.sh

# cuz fuck getopts
for i in "$*" ; do
  [[ $i =~ ^-(-)?[a-z] ]] && {
    [[ $i =~ ^-[a-z] ]] && {
      while read -rn1 flag ; do
        flags+=" -${flag}"
      done <<< ${i#-}
    }
    flags="${flags:-$i}"
    
    for i in ${flags%-} ; do
      flag=$i
      case $flag in
        #--hostcache|-c) hostCache=1 ;; # add host packages
        --no-mirrors|-m) hostKeyring=0 ;; # copy host pacman keyring
        --no-keyring|-k) hostMirrors=0 ;; # copy host mirrorlist
        *) _out 'Bad argument' x ;;
      esac
    done
  }
done
