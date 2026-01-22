#!/bin/bash

set -e  # Exit on error

echo "🚀 Starting dotfiles installation..."

# Check if sudo is available and needed
if command -v sudo &> /dev/null && [ "$EUID" -ne 0 ]; then
    SUDO="sudo"
else
    SUDO=""
fi

# Detect OS and set package manager
case "$(uname -s)" in
    Darwin)
        echo "📦 Detected macOS"
        UPDATE_CMD="brew update"
        PACKAGE_MANAGER="brew install"
        SUDO=""  # Homebrew doesn't use sudo
        ;;
    Linux)
        echo "📦 Detected Linux"
        if command -v apt &> /dev/null; then
            UPDATE_CMD="$SUDO apt update"
            PACKAGE_MANAGER="$SUDO apt install -y"
        elif command -v pacman &> /dev/null; then
            UPDATE_CMD="$SUDO pacman -Sy"
            PACKAGE_MANAGER="$SUDO pacman -S --noconfirm"
        elif command -v dnf &> /dev/null; then
            UPDATE_CMD="$SUDO dnf check-update || true"  # dnf returns 100 if updates available
            PACKAGE_MANAGER="$SUDO dnf install -y"
        elif command -v apk &> /dev/null; then
            UPDATE_CMD="$SUDO apk update"
            PACKAGE_MANAGER="$SUDO apk add"
        else
            echo "❌ Unsupported package manager"
            exit 1
        fi
        ;;
    *)
        echo "❌ Unsupported OS"
        exit 1
        ;;
esac

# Update package manager
echo "🔄 Updating package manager..."
$UPDATE_CMD

# Install core tools
echo "📥 Installing core tools..."
$PACKAGE_MANAGER neovim tmux zsh stow git curl

