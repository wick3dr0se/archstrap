#!/bin/bash

LC_ALL=C
input=${*//-*}

# helper functions 
_out() {
  if [[ $2 == e ]] ; then
    code=3
    msg='Error'
  elif [[ $2 == x ]] ; then
    code=1
    msg='Fatal'
  else
    code=2
    msg='Pass'
  fi
  printf '[\e[1;3%sm%s\e[0m]: %s\n' \
    "$code" "$msg" "$1"
      
  [[ $msg == Fatal ]] && exit 1
}

get_reply() {
  printf '[\e[32my\e[0m/\e[31mN\e[0m]: '
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

# define booleans
#hostPkgs=0
hostMirrors=1
hostKeyring=1

# USAGE
(( $# )) && {
  for i in "$@" ; do
    case $i in
      #--hostcache|-h) hostPkgs=1 ;;
      --no-mirrors|-m) hostMirrors=0 ;;
      --no-keyring|-k) hostKeyring=0 ;;
    esac
  done
}

# ARCHSTRAP
get_packages() {
  # configure API
  baseMirror='https://geo.mirror.pkgbuild.com'
  arch='x86_64'
  repo=${1:-core} && shift
  addPkgs='base'
  addPkgs+="$2"
  repoDB="$repo".db.tar.gz
  mirror="$baseMirror/$repo/os/$arch"

  # get $repo package database
  curl -sLO "$mirror/$repo".db.tar.gz

  # extract to $repo
  [[ -d $repo ]] || mkdir "$repo"
  tar -xf "$repoDB" -C "$repo" 2>/dev/null && rm -fr "$repoDB"

  # create a package list
  [[ -f packages ]] && rm -fr packages
  for i in "$repo"/* ; do
    i="${i/$repo\/}"
    echo "${i%%-[0-9]*}" >> packages
  done

: '(( hostPkg )) && {
    [[ -d /var/lib/pacman ]] && {
      pacman -Qe
    }
  }'
}

make_tmpfs() {
  # get $tmpfs by input, fallback on script name
  tmpfs="${1:-${0%.sh}}"

  # check if $tmpfs already exist 
  [[ -d $tmpfs ]] && {
    _out "$tmpfs already exist. Do you want to overwrite?" e
    get_reply || _out 'Aborting..' x
    rm -fr "$tmpfs"
  }

# make the root filesystem, with proper permissions
  mkmod 777 "$tmpfs"/tmp
  mkmod 755 "$tmpfs"/var/{cache/pacman/pkg,lib/pacman,log} "$tmpfs"/{dev,run,etc/pacman.d}
  mkmod 555 "$tmpfs"/{sys,proc}

  get_packages core "$input"

  # copy network config
  [[ -f /etc/resolv ]] && cp /etc/resolv "$tmpfs"/etc/
  
  # copy keyring
  (( hostKeyring )) && (( ! EUID )) && [[ -d /etc/pacman.d/gnupg ]] &&
    cp -a --no-preserve=ownership /etc/pacman.d/gnupg "$tmpfs"/etc/pacman.d/

  # add global mirror
  echo "Server = $mirror" >> "$tmpfs"/etc/pacman.d/mirrorlist

  # copy host mirrors
  (( hostMirrors )) && [[ -f /etc/pacman.d/mirrorlist ]] &&
    cp -a /etc/pacman.d/mirrorlist "$tmpfs"/etc/pacman.d/
}

make_tmpfs "$input"
