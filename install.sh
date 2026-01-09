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

# Install eza (auto-detect architecture)
mkdir -p ~/.local/bin
# Detect system architecture and set appropriate eza binary
ARCH=$(uname -m)
case "$ARCH" in
    x86_64)
        EZA_ARCH="x86_64-unknown-linux-gnu"
        ;;
    aarch64|arm64)
        EZA_ARCH="aarch64-unknown-linux-gnu"
        ;;
    armv7l)
        EZA_ARCH="armv7-unknown-linux-gnueabihf"
        ;;
    *)
        echo "Warning: Unsupported architecture: $ARCH, defaulting to x86_64"
        EZA_ARCH="x86_64-unknown-linux-gnu"
        ;;
esac
echo "Installing eza for architecture: $EZA_ARCH"
wget -qO- "https://github.com/eza-community/eza/releases/latest/download/eza_${EZA_ARCH}.tar.gz" | tar xz -C ~/.local/bin

# Intall TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Stow dotfiles
stow .
