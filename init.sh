#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to print messages
info() {
    echo -e "${GREEN}[INFO] $1${NC}"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}" >&2
    exit 1
}

# Detect OS
OS=""
if [ -f /etc/os-release ]; then
    . /etc/os-release
    case $ID in
        ubuntu)
            OS="ubuntu"
            ;;
        arch)
            OS="arch"
            ;;
        *)
            error "Unsupported OS: $ID"
            ;;
    esac
else
    error "Cannot detect OS. /etc/os-release not found."
fi

info "Detected OS: $OS"

# Ensure we're in the dotfiles directory
if [ ! -f "$(pwd)/.gitmodules" ]; then
    error "This script must be run from the dotfiles repository directory"
fi

# Install prerequisites
info "Installing prerequisites..."

if [ "$OS" = "ubuntu" ]; then
    # Update package lists
    sudo apt update && sudo apt upgrade -y

    # Install required packages
    sudo apt install -y git tmux stow fzf gcc

    # Install optional packages (bat, fd-find, zoxide)
    sudo apt install -y bat fd-find
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

    # Install eza (community-maintained ls alternative)
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza

    # Install Neovim from GitHub releases (latest stable)
    info "Installing Neovim from GitHub releases..."
    NVIM_VERSION=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
    wget -O /tmp/nvim-linux64.tar.gz "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.tar.gz"
    sudo tar -C /usr/local -xzf /tmp/nvim-linux64.tar.gz
    sudo ln -sf /usr/local/nvim-linux64/bin/nvim /usr/local/bin/nvim
    rm /tmp/nvim-linux64.tar.gz

    # Install thefuck
    sudo apt install -y python3-pip
    pip3 install thefuck --user

elif [ "$OS" = "arch" ]; then
    # Ensure yay is installed for AUR packages
    if ! command -v yay &> /dev/null; then
        info "Installing yay..."
        sudo pacman -S --needed git base-devel
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay
        makepkg -si --noconfirm
        cd - && rm -rf /tmp/yay
    fi

    # Install all packages
    yay -S --noconfirm git tmux neovim zoxide stow fzf bat eza fd gcc thefuck
fi

# Initialize and update submodules
info "Initializing git submodules..."
git submodule update --init --recursive

# Backup existing config files
info "Backing up existing configuration files..."
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%F_%H-%M-%S)"
mkdir -p "$BACKUP_DIR"

for file in .gitconfig .zshrc .tmux.conf .bashrc; do
    [ -f "$HOME/$file" ] && mv "$HOME/$file" "$BACKUP_DIR/$file" && info "Backed up ~/$file to $BACKUP_DIR/$file"
done

for dir in .config/nvim .config/mc kam .oh-my-zsh .tmux; do
    [ -d "$HOME/$dir" ] && mv "$HOME/$dir" "$BACKUP_DIR/$(basename $dir)" && info "Backed up ~/$dir to $BACKUP_DIR/$(basename $dir)"
done

# Create symlinks with stow
info "Creating symlinks with stow..."
stow .

# Change shell to zsh
if [ "$(basename "$SHELL")" != "zsh" ]; then
    info "Changing shell to zsh..."
    ZSH_PATH=$(which zsh)
    if [ -z "$ZSH_PATH" ]; then
        error "zsh not found. Please install zsh and run 'chsh -s $(which zsh)' manually."
    fi
    chsh -s "$ZSH_PATH"
    info "Shell changed to zsh. Please log out and log back in for the change to take effect."
fi

# Final instructions
info "Dotfiles setup complete!"
echo "To source tmux configuration:"
echo "1. Start tmux with 'tmux'"
echo "2. Press <prefix>: (default is Ctrl+b)"
echo "3. Type 'source ~/.tmux.conf' and press Enter"
echo
echo "Backup of previous configs is stored in: $BACKUP_DIR"
echo "You may need to log out and log back in for zsh to take effect."
