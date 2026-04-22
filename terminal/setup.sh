#!/bin/sh
# Compile custom terminfo entries (adds undercurl support to xterm-256color)
tic -x -o "$HOME/.terminfo" "$(dirname "$0")/undercurl.terminfo"
echo "Terminfo compiled to ~/.terminfo/"
