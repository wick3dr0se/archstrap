#!/bin/bash

mnt="$1"; shift
systemd-machine-id-setup

pacman-key --init; pacman-key --populate
pacman -Syu --needed --noconfirm "$@"&& printf '\e[32m>\e[m: %s\n' 'Updated & installed packages'

printf '\e[32m>\e[m: %s\n%s\n' "Done. Arch installer environment setup; Chaged root into $mnt/root.x86_64" \
  'You may now proceed to: https://wiki.archlinux.org/title/Installation_guide#Partition_the_disks and follow the rest of the installation guide'

printf '%s\n' 'echo "Welcome to Arch Linux"'>> /etc/profile
bash --login