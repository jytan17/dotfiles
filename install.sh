#!/bin/bash

set -e  # Exit on error

# Install base packages
apt update
apt install -y zsh tmux neovim stow curl wget

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install Starship
curl -sS https://starship.rs/install.sh | sh -s -- -y

# Install eza
mkdir -p ~/.local/bin
wget -qO- https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz | tar xz -C ~/.local/bin

# Intall TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Stow dotfiles
stow .

# Set zsh as default shell
chsh -s $(which zsh)

echo "Dotfiles installed! Restart your shell or run 'zsh'"

