#!/bin/bash
set -e  # Exit on error

echo "🚀 Starting dotfiles installation..."

# Check if sudo is available and needed
if command -v sudo &> /dev/null && [ "$EUID" -ne 0 ]; then
    SUDO="sudo"
else
    SUDO=""
fi

# Function to install Homebrew
install_homebrew() {
    echo "📦 Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH based on OS
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

# Check if Homebrew is installed, if not install it
if ! command -v brew &> /dev/null; then
    install_homebrew
else
    echo "✅ Homebrew already installed"
fi

# Detect OS and set package manager
case "$(uname -s)" in
    Darwin)
        echo "📦 Detected macOS - using Homebrew"
        UPDATE_CMD="brew update"
        PACKAGE_MANAGER="brew install"
        SUDO=""  # Homebrew doesn't use sudo
        ;;
    Linux)
        echo "📦 Detected Linux - using Homebrew"
        # On Linux, use Homebrew for most tools
        UPDATE_CMD="brew update"
        PACKAGE_MANAGER="brew install"
        
        # Install build-essential/development tools via system package manager
        # These are needed for Homebrew to work properly
        echo "📥 Installing system dependencies for Homebrew..."
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
        ;;
    *)
        echo "❌ Unsupported OS"
        exit 1
        ;;
esac

# Update package manager
echo "🔄 Updating package manager..."
$UPDATE_CMD

# Install core tools via Homebrew
echo "📥 Installing core tools via Homebrew..."
for package in neovim tmux zsh stow git curl fzf eza zoxide uv starship; do
    if brew list "$package" &>/dev/null; then
        echo "✅ $package already installed"
    else
        echo "📦 Installing $package..."
        $PACKAGE_MANAGER "$package"
    fi
done

echo "✨ Installation complete!"
echo ""
echo "📝 Next steps:"
echo "  1. Add Homebrew initialization to your .zshrc"
echo "  2. Stow your dotfiles"
echo "  3. Restart your shell or run: source ~/.zshrc"
echo "  4. Keep tools updated with: brew update && brew upgrade"
