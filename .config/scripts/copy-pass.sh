#!/bin/bash

# Проверяем, установлена ли утилита pass
if ! command -v pass &> /dev/null; then
    notify-send "Password Manager" "pass utility not found"
    exit 1
fi

# Получаем список паролей (убираем расширение .gpg и путь до password-store)
password_list=$(find ~/.password-store/ -type f -name "*.gpg" | sed "s|$HOME/.password-store/||g" | sed 's/\.gpg$//')

# Проверяем, есть ли пароли
if [ -z "$password_list" ]; then
    notify-send "Password Manager" "No passwords found"
    exit 1
fi

# Показываем меню rofi и получаем выбор пользователя
selected_pass=$(echo "$password_list" | rofi -dmenu -p "Select Password:")

# Если пользователь что-то выбрал
if [ -n "$selected_pass" ]; then
    # Получаем пароль и копируем его в буфер обмена
    error_output=$(pass show -c "$selected_pass" 2>&1)
    
    # Проверяем статус выполнения
    if [ $? -eq 0 ]; then
        notify-send "Password Manager" "Password for $selected_pass copied to clipboard"
    else
        notify-send "Password Manager" "Failed to get password for $selected_pass: \n\n$error_output" -u critical
    fi
fi
