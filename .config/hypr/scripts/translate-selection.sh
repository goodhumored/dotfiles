#!/bin/bash

# Получаем выделенный текст (primary selection)
selected_text=$(wl-paste --primary)

# Проверяем, есть ли выделенный текст
if [ -z "$selected_text" ]; then
  notify-send "Ошибка" "Нет выделенного текста"
  exit 1
fi

# Переводим текст с помощью crow (на русский, например)
translated_text=$(echo "$selected_text" | crow -i -t ru)

# Выводим результат через notify-send
notify-send "Перевод" "$translated_text"

#   ─────────────────────────── Старый  вариант: ───────────────────────────
# qdbus io.crow_translate.CrowTranslate /io/crow_translate/CrowTranslate/MainWindow translateSelection
