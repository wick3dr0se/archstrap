#!/bin/bash

term_size(){ shopt -s checkwinsize; (:;:); }; term_size
trap term_size 28

_div(){ printf '%*s' "$COLUMNS"| tr ' ' "-"; }

_msg(){ printf 'archstrap [\e[1;32m🗸\e[m]: %s\n' "$1"; }

_warn(){ printf 'archstrap [\e[1;33m❗\e[m]: %s\n' "$1"; }

_err(){ printf 'archstrap [\e[1;31m❌\e[m]: %s\n' "$1"; exit 1; }

_rm(){ rm -r "${@:?}"; }