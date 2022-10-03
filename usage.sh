#!/bin/bash
# usage.sh

(( $# )) && {
  for i in "$@" ; do
    case $i in
      -?(-)[a-z]?([a-z])*) [[ $i =~ ^-- ]] || {
          while read -rn1 flag ; do
            flags+=" -${flag}"
          done <<< ${i#-}
        }
        flags="${flags:-$i}"
        for i in ${flags%-} ; do
          flag=$i
          case $flag in
            #--hostcache|-h) hostCache=1 ;; # add host packages
            --no-mirrors|-m) hostKeyring=0 ;; # copy host pacman keyring
            --no-keyring|-k) hostMirrors=0 ;; # copy host mirrorlist
            *) _out 'Bad argument' x ;;
          esac
        done
      ;;
    esac
  done
}
