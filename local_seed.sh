#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Default values
ANONYMOUS=false
USERNAME="goodhumored"

# Function to print messages
info() {
    echo -e "${GREEN}[INFO] $1${NC}"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}" >&2
    exit 1
}

# Function to generate random username for anonymous mode
generate_random_username() {
    echo "user$(head /dev/urandom | tr -dc a-z0-9 | head -c 8)"
}

# Function to display usage
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -u, --username    Username to create (default: goodhumored)"
    echo "  -a, --anonymous   Run in anonymous mode (random username, no dotfiles)"
    exit 1
}

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -u|--username) USERNAME="$2"; shift ;;
        -a|--anonymous) ANONYMOUS=true ;;
        *) echo "Unknown parameter: $1"; usage ;;
    esac
    shift
done

# Set username for anonymous mode
if [ "$ANONYMOUS" = true ]; then
    USERNAME=$(generate_random_username)
fi

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    error "This script must be run with sudo privileges"
fi

# Create user and setup home directory
info "Creating user $USERNAME..."
useradd -m -s /bin/bash -G sudo "$USERNAME"
chmod 700 "/home/$USERNAME"

# Setup SSH directory and authorized_keys
info "Setting up SSH directory..."
mkdir -p "/home/$USERNAME/.ssh"
chmod 700 "/home/$USERNAME/.ssh"
touch "/home/$USERNAME/.ssh/authorized_keys"
chmod 600 "/home/$USERNAME/.ssh/authorized_keys"
chown -R "$USERNAME:$USERNAME" "/home/$USERNAME/.ssh"

# Install dependencies
info "Installing dependencies..."
apt-get update
apt-get install -y git stow

# Clone and setup dotfiles (non-anonymous mode only)
if [ "$ANONYMOUS" = false ]; then
    info "Cloning dotfiles repository..."
    su - "$USERNAME" -c "git clone https://github.com/goodhumored/dotfiles /home/$USERNAME/dotfiles"
    info "Running init.sh..."
    su - "$USERNAME" -c "cd /home/$USERNAME/dotfiles && ./init.sh"
fi

info "Local server setup complete!"
echo "Username: $USERNAME"
if [ "$ANONYMOUS" = false ]; then
    echo "Dotfiles have been cloned and initialized."
else
    echo "Anonymous mode: No dotfiles cloned."
fi
echo "You can now add an SSH public key to /home/$USERNAME/.ssh/authorized_keys"
