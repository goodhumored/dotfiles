#!/usr/bin/env python3
from evdev import UInput, ecodes as e
import sys

# Определяем возможности устройства
capabilities = {
    e.EV_REL: [e.REL_WHEEL, e.REL_HWHEEL],  # Список кодов для EV_REL
    e.EV_SYN: [e.SYN_REPORT],               # Список кодов для EV_SYN
}

# Создаём виртуальное устройство
ui = UInput(capabilities, name="virtual-scroll-device")

def scroll(direction, horizontal=False):
    if horizontal:
        ui.write(e.EV_REL, e.REL_HWHEEL, direction)
    else:
        ui.write(e.EV_REL, e.REL_WHEEL, direction)
    ui.syn()

# Обработка аргументов
if len(sys.argv) < 2:
    print("Usage: scroll.py <up|down|left|right>")
    sys.exit(1)

cmd = sys.argv[1]
if cmd == "up":
    scroll(1)
elif cmd == "down":
    scroll(-1)
elif cmd == "left":
    scroll(-1, horizontal=True)
elif cmd == "right":
    scroll(1, horizontal=True)

ui.close()
