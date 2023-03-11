#!/bin/bash

systemd-machine-id-setup

pacman-key --init
pacman-key --populate

pacman -Syyu&& printf 'archstrap [\e[32m🗸\e[m]: Refreshed package list & updated all packages\n'
mnt="$1"; shift
(( $# ))&& pacman -S "$@"&& printf 'archstrap [\e[32m🗸\e[m]: Installed specified packages to new root\n'

printf 'archstrap [\e[32m🗸\e[m]: Mounted on %s\n' "$mnt"
