#!/bin/bash

set -euo pipefail

# --- Константы ---
DEFAULT_PORT=22
DEFAULT_USER="goodhumored"
PASS_DIR="$HOME/.password-store"
KEYS_DIR="$HOME/.ssh/keys"

# --- Утилиты ---
require() {
    if ! command -v "$1" &> /dev/null; then
        echo "Ошибка: нужна утилита '$1'"
        exit 1
    fi
}
require sshpass
require ssh-keygen
require pass

# --- Параметры ---
ANONYMOUS=false
PORT="$DEFAULT_PORT"
NEW_USER="$DEFAULT_USER"

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--host) HOST="$2"; shift ;;
        -p|--port) PORT="$2"; shift ;;
        -r|--root_user) ROOT_USER="$2"; shift ;;
        -s|--server_name) SERVER_NAME="$2"; shift ;;
        -u|--username) NEW_USER="$2"; shift ;;
        -n|--pass_name) PASS_NAME="$2"; shift ;;
        -a|--anonymous) ANONYMOUS=true ;;
        *) echo "Неизвестный параметр: $1"; exit 1 ;;
    esac
    shift
done

[[ -z "${HOST:-}" || -z "${ROOT_USER:-}" || -z "${SERVER_NAME:-}" ]] && {
    echo "Ошибка: нужны --host, --root_user и --server_name"
    exit 1
}

# --- Логика ---
if $ANONYMOUS; then
    NEW_USER="user$(tr -dc a-z0-9 </dev/urandom | head -c 8)"
fi

if [ -z "${PASS_NAME:-}" ] && ! $ANONYMOUS; then
    read -p "Имя для пароля: " PASS_NAME
fi

if ! $ANONYMOUS; then
    read -s -p "Пароль root для подключения: " ROOT_PASS
    echo
fi

# Генерация ключа
mkdir -p "$KEYS_DIR"
KEY_PATH="$KEYS_DIR/$SERVER_NAME"
ssh-keygen -t ed25519 -N "" -f "$KEY_PATH" -C "$SERVER_NAME"

# Получение нового пароля
if ! $ANONYMOUS; then
    mkdir -p "$PASS_DIR"
    NEW_PASS=$(pass generate -c "$PASS_NAME" 16 | tail -n1)
    echo "$NEW_PASS" | pass insert -m "$PASS_NAME"
else
    NEW_PASS=""
fi

# Обновление SSH-конфига
CONFIG_FILE="$HOME/.ssh/config"
touch "$CONFIG_FILE"
chmod 600 "$CONFIG_FILE"
sed -i "/Host $SERVER_NAME/,/^\s*$/d" "$CONFIG_FILE"
cat <<EOF >> "$CONFIG_FILE"

Host $SERVER_NAME
    HostName $HOST
    Port $PORT
    User $NEW_USER
    IdentityFile $KEY_PATH
EOF

# --- SSH Настройка сервера ---
SSH_COMMANDS=$(cat <<'EOS'
set -euo pipefail

sudo useradd -m -s /bin/bash -G sudo "$NEW_USER"
echo "$NEW_USER:$NEW_PASS" | sudo chpasswd

sudo mkdir -p "/home/$NEW_USER/.ssh"
sudo chmod 700 "/home/$NEW_USER/.ssh"
echo "$PUBLIC_KEY" | sudo tee "/home/$NEW_USER/.ssh/authorized_keys" > /dev/null
sudo chmod 600 "/home/$NEW_USER/.ssh/authorized_keys"
sudo chown -R "$NEW_USER:$NEW_USER" "/home/$NEW_USER/.ssh"

sudo apt-get update
sudo apt-get install -y git stow

if [ "$ANONYMOUS" = "false" ]; then
    sudo -u "$NEW_USER" git clone https://github.com/goodhumored/dotfiles /home/"$NEW_USER"/dotfiles
    sudo -u "$NEW_USER" bash -c "cd /home/$NEW_USER/dotfiles && ./init.sh"
fi
EOS
)

SSHPASS="$ROOT_PASS" sshpass -e ssh -p "$PORT" "$ROOT_USER@$HOST" \
    env NEW_USER="$NEW_USER" NEW_PASS="$NEW_PASS" PUBLIC_KEY="$(cat "$KEY_PATH.pub")" ANONYMOUS="$ANONYMOUS" bash -c "$SSH_COMMANDS"

echo "Готово! Новый пользователь: $NEW_USER (SSH: ssh $SERVER_NAME)"
