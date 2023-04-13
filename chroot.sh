#!/bin/bash

. helpers.sh

mnt="$1"; shift
basePackages=(
  'dosfstools'
  'ntfs-3g'
  'parted'
  'gdisk'
  "$@"
)
_div

systemd-machine-id-setup

pacman-key --init; pacman-key --populate
_div

pacman -Syu --needed --noconfirm "${basePackages[@]}"&& _msg 'Updated & installed packages'
_div

_msg "Done. Arch Installer environment setup; Changed root into $mnt/root.x86_64"
printf 'You may now proceed to: https://wiki.archlinux.org/title/Installation_guide#Partition_the_disks and follow the rest of the installation guide\n'

printf '%s\n' 'echo "Welcome to Arch Linux"'>> /etc/profile
bash --login
