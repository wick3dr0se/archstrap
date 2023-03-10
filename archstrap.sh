#!/bin/bash

set -eEuo pipefail

archTar='archlinux-bootstrap-x86_64.tar.gz'
officialURL='archlinux.org'
globalMirror='geo.mirror.pkgbuild.com'

printf '\e7Downloading bootstrap tar and signature..'
{
  curl -s https://"$officialURL"/iso/latest/"$archTar".sig -o /tmp/"$archTar".sig
  curl -s https://"$globalMirror"/iso/latest/"$archTar" -o /tmp/"$archTar"
}&& printf '\e[2K\e8'

gpg --verify /tmp/"$archTar".sig /tmp/"$archTar"||{ 
  printf 'Bad signature. Script aborted.\n'
  exit 1
}

tar xzf /tmp/"$archTar" -C /tmp --numeric-owner&& rm -fr /tmp/"$archTar" /tmp/"$archTar".sig
echo 'Server = https://geo.mirror.pkgbuild.com/$repo/os/$arch' >> /tmp/root.x86_64/etc/pacman.d/mirrorlist

/tmp/root.x86_64/bin/arch-chroot /tmp/root.x86_64 bash <(curl -s https://raw.githubusercontent.com/wick3dr0se/snake/main/snake.sh)
