#!/bin/bash

# Получаем список VPN соединений
vpn_list=$(nmcli -t -f NAME,TYPE connection show | grep vpn | cut -d':' -f1)

# Проверяем, есть ли VPN соединения
if [ -z "$vpn_list" ]; then
    notify-send "VPN" "No VPN connections found"
    exit 1
fi

# Преобразуем список в формат, подходящий для rofi (каждая строка отдельно)
# vpn_options=$(echo "$vpn_list" | tr ' ' '\n')

# Показываем меню rofi и получаем выбор пользователя
selected_vpn=$(echo "$vpn_list" | rofi -dmenu -p "Select VPN:")

# Если пользователь что-то выбрал
if [ -n "$selected_vpn" ]; then
    # Активируем выбранное VPN соединение
    error_output=$(nmcli connection up "$selected_vpn" 2>&1)
    
    # Проверяем статус выполнения
    if [ $? -eq 0 ]; then
        notify-send "VPN" "Connected to $selected_vpn successfully"
    else
        notify-send "VPN" "Failed to connect to $selected_vpn: \n\n$error_output" 
    fi
fi


