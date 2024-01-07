#!/bin/bash

rootFS="$1"; shift
systemd-machine-id-setup

pacman-key --init
pacman-key --populate
pacman -Syu --needed --noconfirm "$@"&& printf '\e[32m>\e[m: %s\n' 'Updated & installed packages'

printf '\e[32m>\e[m: %s\n%s\n' "Done. Arch installer environment setup; Chaged root into $rootFS" \
  'You may now proceed to: https://wiki.archlinux.org/title/Installation_guide#Partition_the_disks and follow the rest of the installation guide'

printf '%s\n' 'echo "Welcome to Arch Linux"' >>/etc/profile

rm "$0"

bash --login