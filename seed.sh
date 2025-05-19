#!/bin/bash

set -e

# Defaults
ANONYMOUS=false
PORT=22
NEW_USER="goodhumored"
PASS_DIR="$HOME/.password-store"

# Random username for anonymous mode
generate_random_username() {
    echo "user$(head /dev/urandom | tr -dc a-z0-9 | head -c 8)"
}

# Usage
usage() {
    echo "Usage: $0 [options]"
    echo "  -h, --host        Server IP"
    echo "  -p, --port        SSH port (default: 22)"
    echo "  -r, --root_user   Sudo user for SSH"
    echo "  -s, --server_name Server name for SSH config"
    echo "  -u, --username    User to create (default: goodhumored)"
    echo "  -n, --pass_name   Password store name"
    echo "  -a, --anonymous   Anonymous mode"
    exit 1
}

# Check sshpass
if ! command -v sshpass &> /dev/null; then
    echo "Ошибка: нужен sshpass."
    echo "Установи: sudo apt-get install sshpass (Ubuntu) или sudo pacman -S sshpass (Arch)"
    exit 1
fi

# Parse args
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h|--host) HOST="$2"; shift ;;
        -p|--port) PORT="$2"; shift ;;
        -r|--root_user) ROOT_USER="$2"; shift ;;
        -s|--server_name) SERVER_NAME="$2"; shift ;;
        -u|--username) NEW_USER="$2"; shift ;;
        -n|--pass_name) PASS_NAME="$2"; shift ;;
        -a|--anonymous) ANONYMOUS=true ;;
        *) echo "Неизвестный параметр: $1"; usage ;;
    esac
    shift
done

# Validate args
if [ -z "$HOST" ] || [ -z "$ROOT_USER" ] || [ -z "$SERVER_NAME" ]; then
    echo "Ошибка: нужны host, root_user и server_name"
    usage
fi

# Prompt for password
if [ "$ANONYMOUS" = false ]; then
    if [ -z "$PASS_NAME" ]; then
        read -p "Имя для хранения пароля: " PASS_NAME
    fi
    read -s -p "Пароль для SSH и sudo: " ROOT_PASS
    echo
fi

# Set username for anonymous
if [ "$ANONYMOUS" = true ]; then
    NEW_USER=$(generate_random_username)
fi

# Generate SSH key
KEY_PATH="$HOME/.ssh/keys/$SERVER_NAME"
mkdir -p "$HOME/.ssh/keys"
ssh-keygen -t ed25519 -f "$KEY_PATH" -N "" -C "$SERVER_NAME"

# Read public key
PUBLIC_KEY=$(cat "$KEY_PATH.pub")

# Generate and store password
NEW_PASS=""
if [ "$ANONYMOUS" = false ]; then
    mkdir -p "$PASS_DIR"
    NEW_PASS="$(pass generate -n "$PASS_NAME" 16 | tail -n1 | sed -r 's/\x1B\[[0-9;]*[mK]//g')"
    echo "DEBUG: Generated password: '$NEW_PASS'"
fi

# Update SSH config
CONFIG_FILE="$HOME/.ssh/config"
touch "$CONFIG_FILE"
chmod 600 "$CONFIG_FILE"

# Remove old entry
sed -i "/Host $SERVER_NAME/,/^\s*$/d" "$CONFIG_FILE"

# Add new entry
cat << EOF >> "$CONFIG_FILE"

Host $SERVER_NAME
    HostName $HOST
    Port $PORT
    User $NEW_USER
    IdentityFile $KEY_PATH
EOF

# SSH commands
SSH_COMMANDS=$(cat << ENDSSH
set -e
echo '\$PUBLIC_KEY'

# Create user
echo "\$SUDO_PASS" | sudo -S useradd -m -s /bin/bash -G sudo "\$NEW_USER"
echo "\$SUDO_PASS" | sudo -S chmod 700 "/home/\$NEW_USER"

# Set password
if [ -n "\$NEW_PASS" ]; then
    echo "DEBUG: Setting password for \$NEW_USER: \$NEW_PASS"
    export NEW_USER="\$NEW_USER"
    export NEW_PASS="\$NEW_PASS"
    echo "DEBUG: Setting password echo \"\$NEW_USER:\$NEW_PASS\" | chpasswd"
    echo "\$SUDO_PASS" | sudo -S bash -c "echo \"\$NEW_USER:\$NEW_PASS\" | chpasswd"
fi

# Setup SSH dir
echo "\$SUDO_PASS" | sudo -S mkdir -p "/home/\$NEW_USER/.ssh"
echo "\$SUDO_PASS" | sudo -S chmod 700 "/home/\$NEW_USER/.ssh"
echo "\$SUDO_PASS" | sudo -S touch "/home/\$NEW_USER/.ssh/authorized_keys"
echo "\$SUDO_PASS" | sudo -S chmod 600 "/home/\$NEW_USER/.ssh/authorized_keys"
echo "\$SUDO_PASS" | sudo -S chown -R "\$NEW_USER:\$NEW_USER" "/home/\$NEW_USER/.ssh"
echo "\$SUDO_PASS" | sudo -S bash -c "echo \"\$PUBLIC_KEY\" >> /home/\$NEW_USER/.ssh/authorized_keys"

# Install deps
echo "\$SUDO_PASS" | sudo -S apt-get update
echo "\$SUDO_PASS" | sudo -S apt-get install -y git stow
ENDSSH
)

# Run SSH commands
SSHPASS="$ROOT_PASS" sshpass -e ssh -p "$PORT" "$ROOT_USER@$HOST" "SUDO_PASS='$ROOT_PASS' ANONYMOUS=$ANONYMOUS NEW_USER='$NEW_USER' PUBLIC_KEY='$PUBLIC_KEY' NEW_PASS='$NEW_PASS' bash -c '$SSH_COMMANDS'"

ssh "$SERVER_NAME" bash -c "$(cat << ENDSSH
set -e
git clone https://github.com/goodhumored/dotfiles
cd dotfiles
echo "$SUDO_PASS" | sudo -S ./init.sh
ENDSSH
)"

echo "Настройка завершена!"
echo "Пользователь: $NEW_USER"
echo "SSH команда: ssh $SERVER_NAME"
if [ "$ANONYMOUS" = false ]; then
    echo "Пароль сохранен в: $PASS_NAME"
fi
