#!/bin/bash

# Install packages
apt update
apt install -y zsh tmux neovim stow

# Stow dotfiles
stow .

echo "Dotfiles installed!"
