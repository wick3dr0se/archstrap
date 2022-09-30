#!/bin/bash


_out() {
  if [[ $2 == x ]] ; then
    code='1'
    response='Error'
  elif [[ $2 == w ]] ; then
    code='3'
    response='Warning'
  fi
  
  printf '[\e[1;3%sm%s\e[0m]: %s\n' "${code:-2}" "${response:-Pass}" "$1"
}

is_uefi() {
  [[ -d /sys/firmware/efi/efivars ]] && 
    return 0 || 
    return 1
}

is_uefi && { # UEFI booted
  echo bye
} || { # BIOS or CSM booted
  
}
