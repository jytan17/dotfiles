#!/bin/bash
set -e

# ==============================================================================
# Dotfiles Installation Script
# ==============================================================================

echo "Starting dotfiles installation..."

# ------------------------------------------------------------------------------
# Helper Functions
# ------------------------------------------------------------------------------

check_sudo() {
    if command -v sudo &> /dev/null && [ "$EUID" -ne 0 ]; then
        SUDO="sudo"
    else
        SUDO=""
    fi
}

install_homebrew() {
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    case "$(uname -s)" in
        Darwin)
            if [ -f /opt/homebrew/bin/brew ]; then
                eval "$(/opt/homebrew/bin/brew shellenv)"
            elif [ -f /usr/local/bin/brew ]; then
                eval "$(/usr/local/bin/brew shellenv)"
            fi
            ;;
        Linux)
            if [ -d /home/linuxbrew/.linuxbrew ]; then
                eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
            fi
            ;;
    esac
}

install_linux_deps() {
    echo "Installing system dependencies for Homebrew..."
    if command -v apt &> /dev/null; then
        $SUDO apt update
        $SUDO apt install -y build-essential procps curl file git
    elif command -v pacman &> /dev/null; then
        $SUDO pacman -Sy --noconfirm base-devel procps-ng curl file git
    elif command -v dnf &> /dev/null; then
        $SUDO dnf groupinstall -y "Development Tools"
        $SUDO dnf install -y procps-ng curl file git
    elif command -v apk &> /dev/null; then
        $SUDO apk update
        $SUDO apk add build-base procps curl file git
    fi
}

install_brew_packages() {
    local packages=(
        # Core utilities
        git
        curl
        stow
        make
        gcc
        unzip

        # Shell & terminal
        zsh
        tmux
        fzf

        # Modern CLI tools
        neovim
        eza
        zoxide
        ripgrep
        fd
        xclip
        lazygit
        lazydocker

        # Language tools
        uv

        # Neovim dependencies
        tree-sitter
        tree-sitter-cli
    )

    echo "Installing Homebrew packages..."
    for package in "${packages[@]}"; do
        if brew list "$package" &>/dev/null; then
            echo "  [ok] $package"
        else
            echo "  [installing] $package"
            brew install "$package"
        fi
    done
}

install_tpm() {
    local tpm_dir="$HOME/.tmux/plugins/tpm"
    if [ -d "$tpm_dir" ]; then
        echo "  [ok] TPM already installed"
    else
        echo "  [installing] TPM (Tmux Plugin Manager)"
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
    fi
}

# ------------------------------------------------------------------------------
# Main Installation
# ------------------------------------------------------------------------------

check_sudo

# Install Homebrew if needed
if ! command -v brew &> /dev/null; then
    install_homebrew
else
    echo "Homebrew already installed"
fi

# OS-specific setup
case "$(uname -s)" in
    Darwin)
        echo "Detected macOS"
        ;;
    Linux)
        echo "Detected Linux"
        install_linux_deps
        ;;
    *)
        echo "Unsupported OS"
        exit 1
        ;;
esac

# Update Homebrew
echo "Updating Homebrew..."
brew update

# Install packages
install_brew_packages

# Install TPM
install_tpm

# ------------------------------------------------------------------------------
# Done
# ------------------------------------------------------------------------------

echo ""
echo "Installation complete!"
echo ""
echo "Next steps:"
echo "  1. Run: stow <package>  (e.g., stow zsh, stow nvim)"
echo "  2. Restart your shell or run: source ~/.zshrc"
echo "  3. In tmux, press prefix + I to install plugins"
echo "  4. In nvim, parsers will auto-install on first use"
