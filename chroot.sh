#!/bin/bash

set -eEuo pipefail

pacman-key --init
pacman-key --populate
pacman -Syyu
