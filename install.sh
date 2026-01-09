#!/bin/bash
set -e  # Exit on error

#==============================================================================
# SYSTEM DETECTION & DEPENDENCIES
#==============================================================================
echo "Detecting operating system..."
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "✓ Detected Linux"
    
    # Install dependencies (skip sudo if running as root)
    if [ "$EUID" -eq 0 ]; then
        apt-get update
        apt-get install -y build-essential curl git
    else
        sudo apt-get update
        sudo apt-get install -y build-essential curl git
    fi
    
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "✓ Detected macOS"
    # macOS doesn't need build-essential
    # Xcode Command Line Tools should be installed (Homebrew installer prompts for this)
    
else
    echo "✗ Unsupported OS: $OSTYPE"
    exit 1
fi

#==============================================================================
# DIRECTORY SETUP
#==============================================================================
echo ""
echo "Creating configuration directories..."
mkdir -p ~/.config

#==============================================================================
# HOMEBREW INSTALLATION
#==============================================================================
echo ""
echo "Installing Homebrew..."
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Configure Homebrew PATH for current session
# Note: Permanent configuration is handled by dotfiles (bash/.bashrc and zshrc/.zshrc)
if [ -f "/opt/homebrew/bin/brew" ]; then
    # macOS Apple Silicon
    echo "✓ Configuring Homebrew for macOS Apple Silicon"
    eval "$(/opt/homebrew/bin/brew shellenv)"

elif [ -f "/usr/local/bin/brew" ]; then
    # macOS Intel
    echo "✓ Configuring Homebrew for macOS Intel"
    eval "$(/usr/local/bin/brew shellenv)"

elif [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    # Linux
    echo "✓ Configuring Homebrew for Linux"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

else
    echo "✗ Homebrew installation not found!"
    exit 1
fi

#==============================================================================
# DEVELOPMENT TOOLS
#==============================================================================
echo ""
echo "Installing gcc..."
brew install gcc

echo ""
echo "Installing zsh, starship, eza, stow..."
brew install zsh starship eza stow 

#==============================================================================
# OH-MY-ZSH & PLUGINS
#==============================================================================
echo ""
echo "Installing oh-my-zsh..."
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo ""
echo "Installing oh-my-zsh plugins..."
brew install zsh-autosuggestions zsh-syntax-highlighting

echo ""
echo "Setting starship theme..."
starship preset gruvbox-rainbow -o ~/.config/starship.toml

# Stow zshrc
rm ~/.zshrc
stow zshrc

# Stow bashrc
rm ~/.bashrc 2>/dev/null || true
stow bash

#==============================================================================
# TMUX & PLUGIN MANAGER
#==============================================================================
echo ""
echo "Installing tmux and TPM..."
brew install tmux

# Stow tmux config
stow tmux

# Install TPM
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install tmux plugins automatically
echo "Installing tmux plugins..."
tmux start-server
tmux new-session -d -s setup
~/.tmux/plugins/tpm/scripts/install_plugins.sh
tmux kill-server

#==============================================================================
# NVIM
#==============================================================================
echo ""
echo "Installing neovim and essential tools..."
brew install neovim

echo ""
echo "Installing nvim dependencies (ripgrep, fd, lazygit, node)..."
brew install ripgrep fd lazygit node

stow nvim

echo ""
echo "On first nvim launch, Mason will auto-install language servers and formatters."


#==============================================================================
# Finishing words
#==============================================================================
echo ""
echo "✓ Installation complete!"
echo ""
echo "================================================"
echo "To start using your new setup:"
echo ""
echo "  1. Restart your terminal, OR"
echo "  2. Run: exec zsh"
echo ""
echo "Your dotfiles now include:"
echo "  ✓ Homebrew initialization (auto-loaded)"
echo "  ✓ UTF-8 locale support"
echo "  ✓ 256-color terminal support"
echo "  ✓ Starship prompt with Gruvbox theme"
echo "  ✓ Tmux with true color support"
echo "  ✓ Neovim (AstroNvim)"
echo "================================================"
