#!/bin/bash

. helpers.sh

mnt="$1"; shift

systemd-machine-id-setup

pacman-key --init; pacman-key --populate
pacman -Syu --needed --noconfirm "${@-base}"&& _msg 'Updated & installed packages'

_msg "Done. Mounted on $mnt"
