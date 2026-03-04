#!/usr/bin/env bash
chosen=$(printf " Lock\n Reboot\n Logout\n⏾ Suspend\n Shutdown" \
  | rofi -dmenu -theme "$HOME/.config/rofi/power.rasi" -p "")

case "$chosen" in
  *Lock) swaylock -f -c 1e1e2e ;;
  *Reboot) systemctl reboot ;;
  *Logout) swaymsg exit ;;
  *Suspend) systemctl suspend ;;
  *Shutdown) systemctl poweroff ;;
  *) exit 0 ;;
esac
