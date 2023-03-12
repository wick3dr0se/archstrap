#!/bin/bash

mnt="$1"; shift

. helpers.sh

systemd-machine-id-setup

pacman-key --init; pacman-key --populate

pacman -Syyu&& _msg 'Refreshed package list & updated all packages'
(( $# ))&& pacman -S "$@"&& _msg 'Installed specified packages to new root'

_msg "Done. Mounted on $mnt"
