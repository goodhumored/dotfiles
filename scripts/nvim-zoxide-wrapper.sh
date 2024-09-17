#!/usr/bin/env zsh


if [ -z "$1" ]; then
    nvim
else
    if [ -f "$1" ]; then
        nvim $1
    else
        eval "$(zoxide init --cmd cd zsh)"
        cd $1
        nvim .
    fi
fi
