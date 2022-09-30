#!/bin/bash

LC_ALL=C
input=${@//-*}

# helper functions 
_out() {
  if [[ $2 == x ]] ; then
    code=1
    response='Err'
  elif [[ $2 == w ]] ; then
    code=3
    response='Warn'
  fi

  printf '[\e[1;3%sm%s\e[0m]: %s\n' \
    "${code:-2}" "${response:-Pass}" "$1"

  [[ $code == 1 ]] && exit 1
}

get_reply() {
  printf '[\e[32my\e[0m/\e[31mN\e[0m]: '
  read reply
  reply=${reply:-N}

  [[ $reply == y || $reply == yes ]] && 
    return 0 ||
    return 1
}

# define booleans
hostPkgs=0
hostMirrors=1
hostKeyring=1

# USAGE
(( $# )) && {
  for i in $@ ; do
    case $i in
      --hostcache|-h) hostPkgs=1 ;;
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
  repoDB="$repo.db.tar.gz"
  mirror="$baseMirror/$repo/os/$arch"

  # download package database
  _out "Downloading $repo packages.."
  curl -sLO $mirror/$repo.db.tar.gz

  # extract to $repo
  [[ -d $repo ]] || mkdir $repo
  tar xf $repoDB -C $repo 2>/dev/null && rm -fr $repoDB

: ' # copy host packages 
  (( $hostPkg )) && {
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
    _out "$tmpfs already exist. Do you want to overwrite?" w
    get_reply || _out 'Aborting..' x
    rm -fr $tmpfs
  }

  # make the root filesystem, with proper permissions
  mkdir -m 755 -p "$tmpfs"/var/{cache/pacman/pkg,lib/pacman,log} "$tmpfs"/{dev,run,etc/pacman.d}
  mkdir -m 777 -p "$tmpfs"/tmp
  mkdir -m 555 -p "$tmpfs"/{sys,proc}

  get_packages core "$input"

  # copy network config
  [[ -f /etc/resolv ]] && cp /etc/resolv "$tmpfs/etc/"
  
  # copy keyring
  (( $hostKeyring )) && [[ -d /etc/pacman.d/gnupg ]] &&
    cp -a --no-preserve=ownership /etc/pacman.d/gnupg "$tmpfs/etc/pacman.d/"

  # add global mirror
  echo "Server = $mirror" >> "$tmpfs/etc/pacman.d/mirrorlist"

  # copy host mirrors
  (( $hostMirrors )) && [[ -f /etc/pacman.d/mirrorlist ]] &&
    cp -a /etc/pacman.d/mirrorlist "$tmpfs/etc/pacman.d/"
}

make_tmpfs "$input"
