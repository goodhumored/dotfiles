#!/bin/bash

# Проверяем, передан ли аргумент (например, +10, -10 или абсолютное значение)
if [ -z "$1" ]; then
    echo "Ошибка: укажи изменение яркости (например, +10, -10 или 50)"
    exit 1
fi

# Временный файл для хранения значения яркости
TEMP_FILE="/tmp/ddc_brightness_value"
DEBOUNCE_FILE="/tmp/ddc_brightness_debounce"

# Функция для получения текущей яркости
get_current_brightness() {
    ddcutil getvcp 10 | grep -oP '(?<=current value = )\s*\d+' | tr -d ' '
}

# Читаем текущее значение из файла или получаем с монитора, если файла нет
if [ -f "$TEMP_FILE" ]; then
    CURRENT_VALUE=$(cat "$TEMP_FILE")
else
    CURRENT_VALUE=$(get_current_brightness)
    echo "$CURRENT_VALUE" > "$TEMP_FILE"
fi

# Вычисляем новое значение
if [[ "$1" =~ ^[+-] ]]; then
    NEW_VALUE=$((CURRENT_VALUE + $1))
else
    NEW_VALUE="$1"
fi

# Ограничиваем значение в пределах 0-100
if [ "$NEW_VALUE" -lt 0 ]; then
    NEW_VALUE=0
elif [ "$NEW_VALUE" -gt 100 ]; then
    NEW_VALUE=100
fi

# Записываем новое значение во временный файл
echo "$NEW_VALUE" > "$TEMP_FILE"
echo "$NEW_VALUE" >> /tmp/wobpipe

# Обновляем метку времени для debounce
touch "$DEBOUNCE_FILE"

# Функция для установки яркости с debounce
apply_brightness() {
    # Ждём 0.5 секунды после последнего изменения
    sleep 0.5

    # Проверяем, не изменился ли файл с тех пор
    NOW=$(date +%s%3N)
    LAST_CHANGE=$(cat "$TIMESTAMP_FILE" 2>/dev/null || echo 0)

    # Проверяем, прошло ли 500 мс (0.5 с) с последнего изменения
    if [ $((NOW - LAST_CHANGE)) -lt 500 ]; then
        exit 0
    fi

    # Читаем финальное значение из файла
    FINAL_VALUE=$(cat "$TEMP_FILE")

    # Устанавливаем яркость
    ddcutil setvcp 10 "$FINAL_VALUE" > /tmp/ddcutil_output 2>&1

    # Получаем текущую яркость для вывода
    RESULT="$(ddcutil getvcp 10)"
    CURRENT_PERC="$(echo "$RESULT" | grep -oP '(?<=current value = )\s*\d+' | tr -d ' ')"

    # Выводим результат и записываем в wobpipe
    echo "$RESULT"
    echo "\"$CURRENT_PERC\""
}

# Запускаем применение яркости в фоновом режиме, если ещё не запущено
if ! pgrep -f "apply_brightness" > /dev/null; then
    apply_brightness &
fi

exit 0
