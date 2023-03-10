#!/bin/bash

set -eEuo pipefail

rootfs='root.x86_64'
archTar='archlinux-bootstrap-x86_64.tar.gz'
officialURL='https://archlinux.org'
globalMirror='https://geo.mirror.pkgbuild.com'
chrootDest='https://raw.githubusercontent.com/wick3dr0se/archstrap/alpha/archstrap-chroot.sh'

printf 'Downloading bootstrap signature & tarball..\n'
curl "$officialURL"/iso/latest/"$archTar".sig -o /tmp/"$archTar".sig
curl "$globalMirror"/iso/latest/"$archTar" -o /tmp/"$archTar"

printf 'Verifying tarball GPG signature..\n'
if gpg --verify /tmp/"$archTar".sig /tmp/"$archTar"; then
  printf 'Signature verified!\n'
else
  printf 'Bad signature. Script aborted.\n'
  exit 1
fi

tar xzf /tmp/"$archTar" -C /tmp --numeric-owner&& rm -fr /tmp/"$archTar"*
mkdir /tmp/"$archTar"/run/shm/
printf 'Server = %s/$repo/os/$arch\n' "$chrootDest" >> /tmp/"$rootfs"/etc/pacman.d/mirrorlist

/tmp/"$rootfs"/bin/arch-chroot /tmp/"$rootfs" bash <(curl -s "$chrootDest")
