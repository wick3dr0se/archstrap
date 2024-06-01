#!/bin/bash

installGuide='https://wiki.archlinux.org/title/Installation_guide'

printf 'Changed root\n'

systemd-machine-id-setup

pacman-key --init
pacman-key --populate

pacman -Syu --needed --noconfirm&&
    printf 'Updated & synced repositories\n'

printf '%s\n' 'Arch installer environment setup' \
    "Proceed with: $installGuide#Partition_the_disks & beyond" \
    'Welcome to Arch Linux!'

rm "$0"

bash --login